import '../../../../../core/network/paginated_list.dart';
import '../../../domain/entities/notification_category.dart';
import '../../../domain/entities/notification_priority.dart';
import '../../models/notification_model.dart';
import '../../models/notification_response_models.dart';
import '../remote/notification_remote_data_source.dart';

class NotificationMockDataSourceImpl implements NotificationRemoteDataSource {
  final List<NotificationModel> _mockNotifications = [
    NotificationModel(
      id: 'mock-id-1',
      title: 'New Assignment Submission',
      message: 'John Doe has submitted the assignment for Math 101.',
      category: NotificationCategory.assignmentSubmission,
      priority: NotificationPriority.high,
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
      isPinned: false,
      isArchived: false,
      actionRequired: true,
      actionCompleted: false,
      studentName: 'John Doe',
      courseName: 'Math 101',
      courseId: 'math101-id',
      relatedEntityId: 'submission-123',
    ),
    NotificationModel(
      id: 'mock-id-2',
      title: 'System Maintenance',
      message: 'The system will be down for maintenance this weekend.',
      category: NotificationCategory.security,
      priority: NotificationPriority.normal,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
      isPinned: true,
      isArchived: false,
      actionRequired: false,
      actionCompleted: false,
    ),
    NotificationModel(
      id: 'mock-id-3',
      title: 'Course Update',
      message: 'New materials have been added to Science 202.',
      category: NotificationCategory.enrollment,
      priority: NotificationPriority.low,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isRead: false,
      isPinned: false,
      isArchived: false,
      actionRequired: false,
      actionCompleted: false,
      courseName: 'Science 202',
      courseId: 'science202-id',
    ),
  ];

  @override
  Future<GetNotificationsResponseData> getNotifications({
    int start = 0,
    int pageSize = 20,
    String? filter,
    String? searchQuery,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network delay

    List<NotificationModel> filteredList = List.from(_mockNotifications);

    if (filter == 'archived') {
      // Only show archived notifications
      filteredList = filteredList.where((n) => n.isArchived).toList();
    } else {
      // Exclude archived notifications from main feed
      filteredList = filteredList.where((n) => !n.isArchived).toList();

      // Apply other filtering if necessary
      if (filter != null && filter.isNotEmpty) {
        if (filter == 'unread') {
          filteredList = filteredList.where((n) => !n.isRead).toList();
        } else if (filter == 'action_required') {
          filteredList = filteredList.where((n) => n.actionRequired).toList();
        }
      }
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filteredList = filteredList
          .where((n) =>
              n.title.toLowerCase().contains(query) ||
              n.message.toLowerCase().contains(query))
          .toList();
    }

    // Sort by timeline (newest first)
    filteredList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final int total = filteredList.length;
    final int end = (start + pageSize < total) ? start + pageSize : total;
    final items = start < total ? filteredList.sublist(start, end) : <NotificationModel>[];

    return GetNotificationsResponseData(
      state: 'success',
      message: 'Mock notifications fetched successfully',
      data: PaginatedList<NotificationModel>(
        items: items,
        total: total,
        start: start,
        pageSize: pageSize,
        hasNextPage: end < total,
      ),
    );
  }

  @override
  Future<GenericNotificationResponseData> markAsRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockNotifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _mockNotifications[index] = NotificationModel(
        id: _mockNotifications[index].id,
        title: _mockNotifications[index].title,
        message: _mockNotifications[index].message,
        category: _mockNotifications[index].category,
        priority: _mockNotifications[index].priority,
        createdAt: _mockNotifications[index].createdAt,
        isRead: true,
        isPinned: _mockNotifications[index].isPinned,
        isArchived: _mockNotifications[index].isArchived,
        actionRequired: _mockNotifications[index].actionRequired,
        actionCompleted: _mockNotifications[index].actionCompleted,
        courseId: _mockNotifications[index].courseId,
        courseName: _mockNotifications[index].courseName,
        actionUrl: _mockNotifications[index].actionUrl,
        relatedEntityId: _mockNotifications[index].relatedEntityId,
        studentId: _mockNotifications[index].studentId,
        studentName: _mockNotifications[index].studentName,
      );
    }
    return const GenericNotificationResponseData(state: 'success', message: 'Marked as read');
  }

  @override
  Future<GenericNotificationResponseData> markAsUnread(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockNotifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _mockNotifications[index] = NotificationModel(
        id: _mockNotifications[index].id,
        title: _mockNotifications[index].title,
        message: _mockNotifications[index].message,
        category: _mockNotifications[index].category,
        priority: _mockNotifications[index].priority,
        createdAt: _mockNotifications[index].createdAt,
        isRead: false,
        isPinned: _mockNotifications[index].isPinned,
        isArchived: _mockNotifications[index].isArchived,
        actionRequired: _mockNotifications[index].actionRequired,
        actionCompleted: _mockNotifications[index].actionCompleted,
        courseId: _mockNotifications[index].courseId,
        courseName: _mockNotifications[index].courseName,
        actionUrl: _mockNotifications[index].actionUrl,
        relatedEntityId: _mockNotifications[index].relatedEntityId,
        studentId: _mockNotifications[index].studentId,
        studentName: _mockNotifications[index].studentName,
      );
    }
    return const GenericNotificationResponseData(state: 'success', message: 'Marked as unread');
  }

  @override
  Future<GenericNotificationResponseData> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (int i = 0; i < _mockNotifications.length; i++) {
      _mockNotifications[i] = NotificationModel(
        id: _mockNotifications[i].id,
        title: _mockNotifications[i].title,
        message: _mockNotifications[i].message,
        category: _mockNotifications[i].category,
        priority: _mockNotifications[i].priority,
        createdAt: _mockNotifications[i].createdAt,
        isRead: true,
        isPinned: _mockNotifications[i].isPinned,
        isArchived: _mockNotifications[i].isArchived,
        actionRequired: _mockNotifications[i].actionRequired,
        actionCompleted: _mockNotifications[i].actionCompleted,
        courseId: _mockNotifications[i].courseId,
        courseName: _mockNotifications[i].courseName,
        actionUrl: _mockNotifications[i].actionUrl,
        relatedEntityId: _mockNotifications[i].relatedEntityId,
        studentId: _mockNotifications[i].studentId,
        studentName: _mockNotifications[i].studentName,
      );
    }
    return const GenericNotificationResponseData(state: 'success', message: 'All marked as read');
  }

  @override
  Future<GenericNotificationResponseData> togglePin(String id, {required bool isPinned}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockNotifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _mockNotifications[index] = NotificationModel(
        id: _mockNotifications[index].id,
        title: _mockNotifications[index].title,
        message: _mockNotifications[index].message,
        category: _mockNotifications[index].category,
        priority: _mockNotifications[index].priority,
        createdAt: _mockNotifications[index].createdAt,
        isRead: _mockNotifications[index].isRead,
        isPinned: isPinned,
        isArchived: _mockNotifications[index].isArchived,
        actionRequired: _mockNotifications[index].actionRequired,
        actionCompleted: _mockNotifications[index].actionCompleted,
        courseId: _mockNotifications[index].courseId,
        courseName: _mockNotifications[index].courseName,
        actionUrl: _mockNotifications[index].actionUrl,
        relatedEntityId: _mockNotifications[index].relatedEntityId,
        studentId: _mockNotifications[index].studentId,
        studentName: _mockNotifications[index].studentName,
      );
    }
    return const GenericNotificationResponseData(state: 'success', message: 'Pin toggled');
  }

  @override
  Future<GenericNotificationResponseData> archive(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockNotifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _mockNotifications[index] = NotificationModel(
        id: _mockNotifications[index].id,
        title: _mockNotifications[index].title,
        message: _mockNotifications[index].message,
        category: _mockNotifications[index].category,
        priority: _mockNotifications[index].priority,
        createdAt: _mockNotifications[index].createdAt,
        isRead: _mockNotifications[index].isRead,
        isPinned: _mockNotifications[index].isPinned,
        isArchived: true, // Mark as archived instead of deleting
        actionRequired: _mockNotifications[index].actionRequired,
        actionCompleted: _mockNotifications[index].actionCompleted,
        courseId: _mockNotifications[index].courseId,
        courseName: _mockNotifications[index].courseName,
        actionUrl: _mockNotifications[index].actionUrl,
        relatedEntityId: _mockNotifications[index].relatedEntityId,
        studentId: _mockNotifications[index].studentId,
        studentName: _mockNotifications[index].studentName,
      );
    }
    return const GenericNotificationResponseData(state: 'success', message: 'Archived');
  }

  @override
  Future<GenericNotificationResponseData> unarchive(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockNotifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _mockNotifications[index] = NotificationModel(
        id: _mockNotifications[index].id,
        title: _mockNotifications[index].title,
        message: _mockNotifications[index].message,
        category: _mockNotifications[index].category,
        priority: _mockNotifications[index].priority,
        createdAt: _mockNotifications[index].createdAt,
        isRead: _mockNotifications[index].isRead,
        isPinned: _mockNotifications[index].isPinned,
        isArchived: false, // Mark as unarchived
        actionRequired: _mockNotifications[index].actionRequired,
        actionCompleted: _mockNotifications[index].actionCompleted,
        courseId: _mockNotifications[index].courseId,
        courseName: _mockNotifications[index].courseName,
        actionUrl: _mockNotifications[index].actionUrl,
        relatedEntityId: _mockNotifications[index].relatedEntityId,
        studentId: _mockNotifications[index].studentId,
        studentName: _mockNotifications[index].studentName,
      );
    }
    return const GenericNotificationResponseData(state: 'success', message: 'Unarchived');
  }

  @override
  Future<GenericNotificationResponseData> delete(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockNotifications.removeWhere((n) => n.id == id);
    return const GenericNotificationResponseData(state: 'success', message: 'Deleted');
  }

  @override
  Future<GenericNotificationResponseData> muteCategory(String categoryName) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const GenericNotificationResponseData(state: 'success', message: 'Category muted');
  }

  @override
  Future<GenericNotificationResponseData> muteCourse(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const GenericNotificationResponseData(state: 'success', message: 'Course muted');
  }
}
