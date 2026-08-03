import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  const GetNotificationsUseCase(this._repository);
  final NotificationRepository _repository;

  Future<ApiResult<PaginatedList<NotificationEntity>>> call({
    int start = 0,
    int pageSize = 20,
    String? filter,
    String? searchQuery,
  }) => _repository.getNotifications(
    start: start,
    pageSize: pageSize,
    filter: filter,
    searchQuery: searchQuery,
  );
}

class MarkNotificationAsReadUseCase {
  const MarkNotificationAsReadUseCase(this._repository);
  final NotificationRepository _repository;

  Future<ApiResult<void>> call(String id) => _repository.markAsRead(id);
}

class MarkNotificationAsUnreadUseCase {
  const MarkNotificationAsUnreadUseCase(this._repository);
  final NotificationRepository _repository;

  Future<ApiResult<void>> call(String id) => _repository.markAsUnread(id);
}

class MarkAllNotificationsAsReadUseCase {
  const MarkAllNotificationsAsReadUseCase(this._repository);
  final NotificationRepository _repository;

  Future<ApiResult<void>> call() => _repository.markAllAsRead();
}

class ToggleNotificationPinUseCase {
  const ToggleNotificationPinUseCase(this._repository);
  final NotificationRepository _repository;

  Future<ApiResult<void>> call(String id, {required bool isPinned}) =>
      _repository.togglePin(id, isPinned: isPinned);
}

class ArchiveNotificationUseCase {
  const ArchiveNotificationUseCase(this._repository);
  final NotificationRepository _repository;

  Future<ApiResult<void>> call(String id) => _repository.archive(id);
}

class UnarchiveNotificationUseCase {
  const UnarchiveNotificationUseCase(this._repository);
  final NotificationRepository _repository;

  Future<ApiResult<void>> call(String id) => _repository.unarchive(id);
}

class DeleteNotificationUseCase {
  const DeleteNotificationUseCase(this._repository);
  final NotificationRepository _repository;

  Future<ApiResult<void>> call(String id) => _repository.delete(id);
}

class MuteNotificationCategoryUseCase {
  const MuteNotificationCategoryUseCase(this._repository);
  final NotificationRepository _repository;

  Future<ApiResult<void>> call(String categoryName) =>
      _repository.muteCategory(categoryName);
}

class MuteCourseNotificationsUseCase {
  const MuteCourseNotificationsUseCase(this._repository);
  final NotificationRepository _repository;

  Future<ApiResult<void>> call(String courseId) =>
      _repository.muteCourse(courseId);
}
