import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  /// Fetches a paginated list of notifications, optionally filtered by category and search query.
  Future<ApiResult<PaginatedList<NotificationEntity>>> getNotifications({
    int start = 0,
    int pageSize = 20,
    String? filter, // 'unread', 'action_required', 'submissions', 'archived', etc.
    String? searchQuery,
  });

  /// Marks a specific notification as read.
  Future<ApiResult<void>> markAsRead(String id);

  /// Marks a specific notification as unread.
  Future<ApiResult<void>> markAsUnread(String id);

  /// Marks all visible/matching notifications as read.
  Future<ApiResult<void>> markAllAsRead();

  /// Pins or unpins a notification.
  Future<ApiResult<void>> togglePin(String id, {required bool isPinned});

  /// Archives a notification.
  Future<ApiResult<void>> archive(String id);

  /// Unarchives a notification.
  Future<ApiResult<void>> unarchive(String id);
  
  /// Deletes a notification (if permitted).
  Future<ApiResult<void>> delete(String id);

  /// Mutes a specific category.
  Future<ApiResult<void>> muteCategory(String categoryName);

  /// Mutes a specific course.
  Future<ApiResult<void>> muteCourse(String courseId);
}
