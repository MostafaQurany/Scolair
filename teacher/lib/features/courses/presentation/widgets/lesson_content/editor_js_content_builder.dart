/// Generates Editor.js JSON maps for lesson content.
class EditorJsContentBuilder {
  const EditorJsContentBuilder._();

  static Map<String, dynamic> fromBlocks(List<Map<String, dynamic>> blocks) => {
    'time': DateTime.now().millisecondsSinceEpoch,
    'blocks': blocks,
  };

  static Map<String, dynamic> textBlock(String text) => {
    'time': DateTime.now().millisecondsSinceEpoch,
    'blocks': [
      {
        'type': 'paragraph',
        'data': {'text': text},
      },
    ],
  };

  static Map<String, dynamic> markdownBlock(String text) => {
    'time': DateTime.now().millisecondsSinceEpoch,
    'blocks': [markdownBlockData(text)],
  };

  static Map<String, dynamic> markdownBlockData(String text) => {
    'type': 'markdown',
    'data': {'text': text},
  };

  static Map<String, dynamic> youtubeBlock(String youtubeUrl) => {
    'time': DateTime.now().millisecondsSinceEpoch,
    'blocks': [youtubeBlockData(youtubeUrl)],
  };

  static Map<String, dynamic> youtubeBlockData(String youtubeUrl) => {
    'type': 'embed',
    'data': {
      'service': 'youtube',
      'source': youtubeUrl,
      'embed': youtubeUrl,
      'caption': '',
    },
  };

  static Map<String, dynamic> uploadBlock({
    required String fileUrl,
    required String fileType,
  }) => {
    'time': DateTime.now().millisecondsSinceEpoch,
    'blocks': [uploadBlockData(fileUrl: fileUrl, fileType: fileType)],
  };

  static Map<String, dynamic> uploadBlockData({
    required String fileUrl,
    required String fileType,
  }) => {
    'type': 'upload',
    'data': {'file_url': fileUrl, 'file_type': fileType},
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
