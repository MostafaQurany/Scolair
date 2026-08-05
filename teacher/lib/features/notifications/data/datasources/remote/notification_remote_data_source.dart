import '../../../../../core/network/api_client.dart';
import '../../models/notification_response_models.dart';

abstract class NotificationRemoteDataSource {
  Future<GetNotificationsResponseData> getNotifications({
    int start = 0,
    int pageSize = 20,
    String? filter,
    String? searchQuery,
  });

  Future<GenericNotificationResponseData> markAsRead(String id);
  Future<GenericNotificationResponseData> markAsUnread(String id);
  Future<GenericNotificationResponseData> markAllAsRead();
  Future<GenericNotificationResponseData> togglePin(String id, {required bool isPinned});
  Future<GenericNotificationResponseData> archive(String id);
  Future<GenericNotificationResponseData> unarchive(String id);
  Future<GenericNotificationResponseData> delete(String id);
  Future<GenericNotificationResponseData> muteCategory(String categoryName);
  Future<GenericNotificationResponseData> muteCourse(String courseId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  const NotificationRemoteDataSourceImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<GetNotificationsResponseData> getNotifications({
    int start = 0,
    int pageSize = 20,
    String? filter,
    String? searchQuery,
  }) =>
      _apiClient.listNotifications(start, pageSize, filter, searchQuery);

  @override
  Future<GenericNotificationResponseData> markAsRead(String id) =>
      _apiClient.markNotificationRead({'id': id});

  @override
  Future<GenericNotificationResponseData> markAsUnread(String id) =>
      _apiClient.markNotificationUnread({'id': id});

  @override
  Future<GenericNotificationResponseData> markAllAsRead() =>
      _apiClient.markAllNotificationsRead();

  @override
  Future<GenericNotificationResponseData> togglePin(String id, {required bool isPinned}) =>
      _apiClient.toggleNotificationPin({'id': id, 'is_pinned': isPinned});

  @override
  Future<GenericNotificationResponseData> archive(String id) =>
      _apiClient.archiveNotification({'id': id});

  @override
  Future<GenericNotificationResponseData> unarchive(String id) =>
      _apiClient.unarchiveNotification({'id': id});

  @override
  Future<GenericNotificationResponseData> delete(String id) =>
      _apiClient.deleteNotification(id);

  @override
  Future<GenericNotificationResponseData> muteCategory(String categoryName) =>
      _apiClient.muteCategory({'category': categoryName});

  @override
  Future<GenericNotificationResponseData> muteCourse(String courseId) =>
      _apiClient.muteCourse({'course_id': courseId});
}
