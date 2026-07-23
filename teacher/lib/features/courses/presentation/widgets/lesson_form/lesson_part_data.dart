import 'dart:io';

enum LessonPartType { markdown, youtube, video, pdf, quiz }

class LessonPartData {
  const LessonPartData({
    required this.type,
    this.text,
    this.uploadFile,
    this.existingFileUrl,
    this.existingFileType,
  });

  final LessonPartType type;
  final String? text;
  final File? uploadFile;
  final String? existingFileUrl;
  final String? existingFileType;
}
