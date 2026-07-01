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

    try {
      final decoded = jsonDecode(content);
      if (decoded is! Map<String, dynamic>) {
        return EditorJsContent(
          blocks: const [],
          isMalformed: true,
          raw: content,
        );
      }

      final rawBlocks = decoded['blocks'];
      if (rawBlocks is! List) {
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
            data: data is Map<String, dynamic> ? data : const {},
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
    } on FormatException {
      return EditorJsContent(blocks: const [], isMalformed: true, raw: content);
    }
  }

  static int? _parseInt(Object? value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    return null;
  }
}
