import '../../../../core/network/api_result.dart';
import '../entities/teacher_feed_page.dart';
import '../repositories/teacher_home_repository.dart';

class GetWallPostsUseCase {
  const GetWallPostsUseCase(this._repository);

  final TeacherHomeRepository _repository;

  Future<ApiResult<TeacherFeedPage>> call({
    required String? filterId,
    required int page,
    required int pageSize,
  }) => _repository.getWallPosts(
    filterId: filterId,
    page: page,
    pageSize: pageSize,
  );
}
