import 'dart:convert';

/// Parsed representation of an Editor.js content document.
class EditorJsContent {
  const EditorJsContent({
    required this.blocks,
    this.time,
    this.version,
    this.isMalformed = false,
    this.raw,
  });

  final int? time;
  final String? version;
  final List<EditorJsBlock> blocks;
  final bool isMalformed;
  final String? raw;
}

/// A single block within an Editor.js document.
class EditorJsBlock {
  const EditorJsBlock({required this.type, required this.data, this.id});

  final String? id;
  final String type;
  final Map<String, dynamic> data;
}

/// Parses raw Editor.js JSON content strings into a safe
/// [EditorJsContent] structure. Handles null, empty, malformed
/// JSON, missing blocks, and invalid block shapes gracefully.
class EditorJsContentParser {
  const EditorJsContentParser._();

  static EditorJsContent parse(String? content) {
    if (content == null || content.trim().isEmpty) {
      return const EditorJsContent(blocks: []);
    }

    Object? decoded;
    try {
      decoded = jsonDecode(content);
    } catch (_) {
      try {
        decoded = _parseRelaxedJson(content);
      } catch (_) {
        decoded = null;
      }
    }

    if (decoded is! Map<String, dynamic>) {
      final extractedBlocks = _extractBlocksFromRawString(content);
      if (extractedBlocks.isNotEmpty) {
        return EditorJsContent(blocks: extractedBlocks, raw: content);
      }
      return EditorJsContent(
        blocks: const [],
        isMalformed: true,
        raw: content,
      );
    }

    final rawBlocks = decoded['blocks'];
    if (rawBlocks is! List) {
      final extractedBlocks = _extractBlocksFromRawString(content);
      if (extractedBlocks.isNotEmpty) {
        return EditorJsContent(blocks: extractedBlocks, raw: content);
      }
      return EditorJsContent(
        blocks: const [],
        time: _parseInt(decoded['time']),
        version: decoded['version'] as String?,
        isMalformed: rawBlocks != null,
        raw: content,
      );
    }

    final blocks = <EditorJsBlock>[];
    for (final item in rawBlocks) {
      if (item is! Map<String, dynamic>) continue;

      final type = item['type'];
      if (type is! String || type.isEmpty) continue;

      final data = item['data'];
      blocks.add(
        EditorJsBlock(
          type: type,
          data: data is Map<String, dynamic>
              ? data
              : (data is Map ? Map<String, dynamic>.from(data) : const {}),
          id: item['id'] as String?,
        ),
      );
    }

    return EditorJsContent(
      blocks: blocks,
      time: _parseInt(decoded['time']),
      version: decoded['version'] as String?,
      raw: content,
    );
  }

  static Map<String, dynamic>? _parseRelaxedJson(String raw) {
    var s = raw.trim();
    s = s
        .replaceAll(': True', ': true')
        .replaceAll(': False', ': false')
        .replaceAll(': None', ': null');

    // Quote unquoted keys (e.g. time:, blocks:, type:, data:, text:)
    s = s.replaceAllMapped(
      RegExp(r'([{,]\s*)([a-zA-Z0-9_]+)\s*:'),
      (m) => '${m[1]}"${m[2]}":',
    );

    // Quote unquoted string values for type if needed (e.g. "type": markdown -> "type": "markdown")
    s = s.replaceAllMapped(
      RegExp(r'("type"\s*:\s*)([a-zA-Z0-9_]+)(\s*[,}])'),
      (m) => '${m[1]}"${m[2]}"${m[3]}',
    );

    final decoded = jsonDecode(s);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    return null;
  }

  static List<EditorJsBlock> _extractBlocksFromRawString(String raw) {
    final blocks = <EditorJsBlock>[];
    final blockRegex = RegExp(
      r'\{type:\s*([a-zA-Z0-9_]+),\s*data:\s*\{([^}]*)\}\}',
    );

    for (final match in blockRegex.allMatches(raw)) {
      final type = match.group(1);
      final dataContent = match.group(2) ?? '';
      if (type != null && type.isNotEmpty) {
        final dataMap = <String, dynamic>{};
        final textMatch = RegExp(r'text:\s*(.*)').firstMatch(dataContent);
        if (textMatch != null) {
          final textVal = textMatch.group(1)?.trim() ?? '';
          dataMap['text'] = textVal.endsWith('}')
              ? textVal.substring(0, textVal.length - 1).trim()
              : textVal;
        }
        blocks.add(EditorJsBlock(type: type, data: dataMap));
      }
    }
    return blocks;
  }

  static int? _parseInt(Object? value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    return null;
  }
}
