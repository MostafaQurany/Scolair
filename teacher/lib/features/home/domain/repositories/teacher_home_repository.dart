import '../../../../core/network/api_result.dart';
import '../entities/teacher_feed_page.dart';
import '../entities/teacher_home.dart';
import '../entities/teacher_wall_post.dart';

abstract interface class TeacherHomeRepository {
  Future<ApiResult<TeacherHome>> getTeacherHome();

  Future<ApiResult<TeacherFeedPage>> getWallPosts({
    required String? filterId,
    required int page,
    required int pageSize,
  });

  Future<ApiResult<TeacherWallPost>> toggleLike({
    required String postId,
    required bool shouldLike,
  });
}
