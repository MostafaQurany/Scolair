import 'package:dio/dio.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/homework_detail_models.dart';
import '../../models/homework_mutation_models.dart';
import '../../models/homework_submission_models.dart';
import '../../models/list_homeworks_request_data.dart';
import '../../models/list_homeworks_response_data.dart';

abstract class HomeworkRemoteDataSource {
  Future<ListHomeworksResponseData> listHomeworks(
    ListHomeworksRequestData request,
  );
  Future<HomeworkDetailResponseData> getHomework(String homeworkName);
  Future<HomeworkDetailResponseData> createHomework(
    CreateHomeworkRequestData request,
  );
  Future<HomeworkDetailResponseData> updateHomework(
    UpdateHomeworkRequestData request,
  );
  Future<void> deleteHomework(String homeworkName);
  Future<void> addQuestion(AddHomeworkQuestionRequestData request);
  Future<void> removeQuestion({
    required String homeworkName,
    required String questionName,
  });
  Future<GetSubmissionsResponseData> getSubmissions({
    required String homeworkName,
    int start = 0,
    int pageSize = 30,
  });
  Future<GetSubmissionDetailResponseData> getSubmission(String submissionName);
  Future<List<int>> downloadAnswerFile({
    required String submissionName,
    required String questionName,
  });
  Future<GetSubmissionDetailResponseData> gradeSubmission(
    GradeSubmissionRequestData request,
  );
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
  Future<HomeworkDetailResponseData> getHomework(String homeworkName) async {
    final response = await _dio.get<Object?>(
      ApiEndpoints.getHomework,
      queryParameters: {'homework': homeworkName},
    );
    final parsed = HomeworkDetailResponseData.fromJson(response.data);
    if (parsed.state.toLowerCase() != 'success') {
      throw AppException(
        parsed.message.isEmpty ? 'Unable to fetch homework details' : parsed.message,
      );
    }
    return parsed;
  }

  @override
  Future<HomeworkDetailResponseData> createHomework(
    CreateHomeworkRequestData request,
  ) async {
    final response = await _dio.post<Object?>(
      ApiEndpoints.createHomework,
      data: request.toJson(),
    );
    final parsed = HomeworkDetailResponseData.fromJson(response.data);
    if (parsed.state.toLowerCase() != 'success') {
      throw AppException(
        parsed.message.isEmpty ? 'Unable to create homework' : parsed.message,
      );
    }
    return parsed;
  }

  @override
  Future<HomeworkDetailResponseData> updateHomework(
    UpdateHomeworkRequestData request,
  ) async {
    final response = await _dio.put<Object?>(
      ApiEndpoints.updateHomework,
      data: request.toJson(),
    );
    final parsed = HomeworkDetailResponseData.fromJson(response.data);
    if (parsed.state.toLowerCase() != 'success') {
      throw AppException(
        parsed.message.isEmpty ? 'Unable to update homework' : parsed.message,
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

  @override
  Future<void> addQuestion(AddHomeworkQuestionRequestData request) async {
    await _dio.post<Object?>(
      ApiEndpoints.addHomeworkQuestion,
      data: request.toJson(),
    );
  }

  @override
  Future<void> removeQuestion({
    required String homeworkName,
    required String questionName,
  }) async {
    await _dio.delete<Object?>(
      ApiEndpoints.removeHomeworkQuestion,
      queryParameters: {
        'homework': homeworkName,
        'question': questionName,
      },
    );
  }

  @override
  Future<GetSubmissionsResponseData> getSubmissions({
    required String homeworkName,
    int start = 0,
    int pageSize = 30,
  }) async {
    final response = await _dio.get<Object?>(
      ApiEndpoints.getHomeworkSubmissions,
      queryParameters: {
        'homework': homeworkName,
        'start': start,
        'page_size': pageSize,
      },
    );
    final parsed = GetSubmissionsResponseData.fromJson(response.data);
    if (parsed.state.toLowerCase() != 'success') {
      throw AppException(
        parsed.message.isEmpty ? 'Unable to fetch submissions' : parsed.message,
      );
    }
    return parsed;
  }

  @override
  Future<GetSubmissionDetailResponseData> getSubmission(
    String submissionName,
  ) async {
    final response = await _dio.get<Object?>(
      ApiEndpoints.getHomeworkSubmission,
      queryParameters: {'submission': submissionName},
    );
    final parsed = GetSubmissionDetailResponseData.fromJson(response.data);
    if (parsed.state.toLowerCase() != 'success') {
      throw AppException(
        parsed.message.isEmpty ? 'Unable to fetch submission details' : parsed.message,
      );
    }
    return parsed;
  }

  @override
  Future<List<int>> downloadAnswerFile({
    required String submissionName,
    required String questionName,
  }) async {
    final response = await _dio.get<List<int>>(
      ApiEndpoints.downloadAnswerFile,
      queryParameters: {
        'submission': submissionName,
        'question': questionName,
      },
      options: Options(responseType: ResponseType.bytes),
    );
    return response.data ?? const [];
  }

  @override
  Future<GetSubmissionDetailResponseData> gradeSubmission(
    GradeSubmissionRequestData request,
  ) async {
    final response = await _dio.post<Object?>(
      ApiEndpoints.gradeHomeworkSubmission,
      data: request.toJson(),
    );
    final parsed = GetSubmissionDetailResponseData.fromJson(response.data);
    if (parsed.state.toLowerCase() != 'success') {
      throw AppException(
        parsed.message.isEmpty ? 'Unable to grade submission' : parsed.message,
      );
    }
    return parsed;
  }
}
