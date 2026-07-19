import '../../../../core/network/api_result.dart';
import '../entities/teacher_wall_post.dart';
import '../repositories/teacher_home_repository.dart';

class ToggleWallPostLikeUseCase {
  const ToggleWallPostLikeUseCase(this._repository);

  final TeacherHomeRepository _repository;

  Future<ApiResult<TeacherWallPost>> call({
    required String postId,
    required bool shouldLike,
  }) => _repository.toggleLike(postId: postId, shouldLike: shouldLike);
}
