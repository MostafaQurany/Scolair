import 'package:dio/dio.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/list_homeworks_request_data.dart';
import '../../models/list_homeworks_response_data.dart';

abstract class HomeworkRemoteDataSource {
  Future<ListHomeworksResponseData> listHomeworks(
    ListHomeworksRequestData request,
  );
  Future<void> deleteHomework(String homeworkName);
}

class HomeworkRemoteDataSourceImpl implements HomeworkRemoteDataSource {
  const HomeworkRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<ListHomeworksResponseData> listHomeworks(
    ListHomeworksRequestData request,
  ) async {
    final response = await _dio.get<Object?>(
      ApiEndpoints.listHomeworks,
      queryParameters: request.toJson(),
    );
    final parsed = ListHomeworksResponseData.fromJson(response.data);
    if (parsed.state.toLowerCase() != 'success') {
      throw AppException(
        parsed.message.isEmpty ? 'Unable to fetch homeworks' : parsed.message,
      );
    }
    return parsed;
  }

  @override
  Future<void> deleteHomework(String homeworkName) async {
    await _dio.delete<Object?>(
      ApiEndpoints.deleteHomework,
      queryParameters: {'homework': homeworkName},
    );
  }
}
