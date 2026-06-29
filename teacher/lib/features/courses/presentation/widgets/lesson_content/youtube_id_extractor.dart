/// Extracts a YouTube video ID from various URL formats and
/// raw ID strings.
///
/// Supports:
/// - https://www.youtube.com/watch?v=VIDEO_ID
/// - https://youtu.be/VIDEO_ID
/// - https://www.youtube.com/embed/VIDEO_ID
/// - Raw 11-character video IDs
class YouTubeIdExtractor {
  const YouTubeIdExtractor._();

  static final _patterns = [
    RegExp(r'(?:youtube\.com/watch\?.*v=)([a-zA-Z0-9_-]{11})'),
    RegExp(r'(?:youtu\.be/)([a-zA-Z0-9_-]{11})'),
    RegExp(r'(?:youtube\.com/embed/)([a-zA-Z0-9_-]{11})'),
    RegExp(r'^([a-zA-Z0-9_-]{11})$'),
  ];

  /// Returns the video ID or `null` if extraction fails.
  static String? extract(String? source) {
    if (source == null || source.trim().isEmpty) return null;

    final trimmed = source.trim();
    for (final pattern in _patterns) {
      final match = pattern.firstMatch(trimmed);
      if (match != null) return match.group(1);
    }
    return null;
  }
}
