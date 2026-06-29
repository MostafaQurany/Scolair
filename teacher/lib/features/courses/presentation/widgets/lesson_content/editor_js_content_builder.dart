/// Generates Editor.js JSON maps for simple content types
/// created via the lesson form.
class EditorJsContentBuilder {
  const EditorJsContentBuilder._();

  static Map<String, dynamic> textBlock(String text) => {
    'time': DateTime.now().millisecondsSinceEpoch,
    'blocks': [
      {
        'type': 'paragraph',
        'data': {'text': text},
      },
    ],
  };

  static Map<String, dynamic> youtubeBlock(String youtubeUrl) => {
    'time': DateTime.now().millisecondsSinceEpoch,
    'blocks': [
      {
        'type': 'embed',
        'data': {
          'service': 'youtube',
          'source': youtubeUrl,
          'embed': youtubeUrl,
          'caption': '',
        },
      },
    ],
  };

  static Map<String, dynamic> uploadBlock({
    required String fileUrl,
    required String fileType,
  }) => {
    'time': DateTime.now().millisecondsSinceEpoch,
    'blocks': [
      {
        'type': 'upload',
        'data': {'file_url': fileUrl, 'file_type': fileType},
      },
    ],
  };

  static Map<String, dynamic> quizBlock(String quizName) => {
    'time': DateTime.now().millisecondsSinceEpoch,
    'blocks': [
      {
        'type': 'quiz',
        'data': {'quiz': quizName},
      },
    ],
  };

  static Map<String, dynamic> codeBlock(
    String code, {
    String language = 'text',
  }) => {
    'time': DateTime.now().millisecondsSinceEpoch,
    'blocks': [
      {
        'type': 'codeBox',
        'data': {'code': code, 'language': language},
      },
    ],
  };
}
