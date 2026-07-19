import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/storage/app_shared_preferences.dart';
import '../../domain/entities/teacher_feed_page.dart';
import '../../domain/entities/teacher_home.dart';
import '../../domain/entities/teacher_wall_post.dart';
import '../../domain/repositories/teacher_home_repository.dart';
import '../datasources/local/teacher_home_local_datasource.dart';
import '../mappers/teacher_home_mapper.dart';
import '../models/teacher_home_response_data.dart';

class TeacherHomeRepositoryImpl implements TeacherHomeRepository {
  const TeacherHomeRepositoryImpl(
    this._localDataSource,
    this._sharedPreferences,
  );

  final TeacherHomeLocalDataSource _localDataSource;
  final AppSharedPreferences _sharedPreferences;

  @override
  Future<ApiResult<TeacherHome>> getTeacherHome() async {
    try {
      final response = await _localDataSource.getTeacherHome();

      // Read real teacher info if available in SharedPreferences
      final realFullName = _sharedPreferences.getFullName();
      final realId =
          _sharedPreferences.getUsername() ?? _sharedPreferences.getUserEmail();
      final realImage = _sharedPreferences.getUserImage();

      final updatedResponse = TeacherHomeResponseData(
        teacher: TeacherProfileResponseData(
          id: realId ?? response.teacher.id,
          displayName: realFullName ?? response.teacher.displayName,
          imageUrl: realImage ?? response.teacher.imageUrl,
        ),
        greetingActivityTitle: response.greetingActivityTitle,
        organizationNoticeCount: response.organizationNoticeCount,
        filters: response.filters,
      );

      final domain = TeacherHomeMapper.mapHome(updatedResponse);
      return ApiSuccess(domain);
    } on Object catch (error) {
      return ApiFailure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<TeacherFeedPage>> getWallPosts({
    required String? filterId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await _localDataSource.getWallPosts(
        filterId: filterId,
        page: page,
        pageSize: pageSize,
      );
      final domain = TeacherHomeMapper.mapFeedPage(response);
      return ApiSuccess(domain);
    } on Object catch (error) {
      return ApiFailure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<TeacherWallPost>> toggleLike({
    required String postId,
    required bool shouldLike,
  }) async {
    try {
      final response = await _localDataSource.toggleLike(
        postId: postId,
        shouldLike: shouldLike,
      );
      final domain = TeacherHomeMapper.mapPost(response);
      return ApiSuccess(domain);
    } on Object catch (error) {
      return ApiFailure(ErrorHandler.handle(error));
    }
  }
}
