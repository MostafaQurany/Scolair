import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/remote/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._remoteDataSource);
  final NotificationRemoteDataSource _remoteDataSource;

  Future<ApiResult<T>> _getResult<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return ApiSuccess(result);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<PaginatedList<NotificationEntity>>> getNotifications({
    int start = 0,
    int pageSize = 20,
    String? filter,
    String? searchQuery,
  }) => _getResult(() async {
    final response = await _remoteDataSource.getNotifications(
      start: start,
      pageSize: pageSize,
      filter: filter,
      searchQuery: searchQuery,
    );
    final paginatedModels = response.data;
    return PaginatedList<NotificationEntity>(
      items: paginatedModels.items.map((m) => m.toEntity()).toList(),
      total: paginatedModels.total,
      start: paginatedModels.start,
      pageSize: paginatedModels.pageSize,
      hasNextPage: paginatedModels.hasNextPage,
    );
  });

  @override
  Future<ApiResult<void>> markAsRead(String id) =>
      _getResult(() => _remoteDataSource.markAsRead(id));

  @override
  Future<ApiResult<void>> markAsUnread(String id) =>
      _getResult(() => _remoteDataSource.markAsUnread(id));

  @override
  Future<ApiResult<void>> markAllAsRead() =>
      _getResult(_remoteDataSource.markAllAsRead);

  @override
  Future<ApiResult<void>> togglePin(String id, {required bool isPinned}) =>
      _getResult(() => _remoteDataSource.togglePin(id, isPinned: isPinned));

  @override
  Future<ApiResult<void>> archive(String id) =>
      _getResult(() => _remoteDataSource.archive(id));

  @override
  Future<ApiResult<void>> unarchive(String id) =>
      _getResult(() => _remoteDataSource.unarchive(id));

  @override
  Future<ApiResult<void>> delete(String id) =>
      _getResult(() => _remoteDataSource.delete(id));

  @override
  Future<ApiResult<void>> muteCategory(String categoryName) =>
      _getResult(() => _remoteDataSource.muteCategory(categoryName));

  @override
  Future<ApiResult<void>> muteCourse(String courseId) =>
      _getResult(() => _remoteDataSource.muteCourse(courseId));
}
