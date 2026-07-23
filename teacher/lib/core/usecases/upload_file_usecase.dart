import 'dart:io';
import '../network/api_result.dart';
import '../errors/failures.dart';
import '../repositories/upload_repository.dart';
import 'package:dio/dio.dart';

class UploadFileUseCase {
  final UploadRepository _repository;

  UploadFileUseCase(this._repository);

  Future<ApiResult<String>> call({
    required File file,
    required int isPrivate,
  }) async {
    try {
      final fileUrl = await _repository.uploadFile(
        file: file,
        isPrivate: isPrivate,
      );
      return ApiSuccess(fileUrl);
    } on DioException catch (e) {
      return ApiFailure(ServerFailure(e.message ?? 'Upload failed'));
    } catch (e) {
      return ApiFailure(UnknownFailure(e.toString()));
    }
  }
}
