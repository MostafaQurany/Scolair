import 'dart:io';
import 'package:dio/dio.dart';
import '../network/api_client.dart';

abstract class UploadRepository {
  Future<String> uploadFile({required File file, required int isPrivate});
}

class UploadRepositoryImpl implements UploadRepository {

  UploadRepositoryImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<String> uploadFile({
    required File file,
    required int isPrivate,
  }) async {
    try {
      final fileName = file.path.split(Platform.pathSeparator).last;
      final multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );
      final response = await _apiClient.uploadFile(
        file: multipartFile,
        isPrivate: isPrivate,
      );
      return response.message.fileUrl;
    } catch (e) {
      rethrow;
    }
  }
}
