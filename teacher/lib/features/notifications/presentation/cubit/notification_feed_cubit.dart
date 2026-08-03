import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/api_result.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/notification_usecases.dart';

part 'notification_feed_state.dart';
part 'notification_feed_cubit.freezed.dart';

class NotificationFeedCubit extends Cubit<NotificationFeedState> {
  NotificationFeedCubit({
    required GetNotificationsUseCase getNotificationsUseCase,
    required MarkNotificationAsReadUseCase markAsReadUseCase,
    required MarkAllNotificationsAsReadUseCase markAllAsReadUseCase,
    required ArchiveNotificationUseCase archiveNotificationUseCase,
    required UnarchiveNotificationUseCase unarchiveNotificationUseCase,
    required ToggleNotificationPinUseCase toggleNotificationPinUseCase,
  })  : _getNotifications = getNotificationsUseCase,
        _markAsRead = markAsReadUseCase,
        _markAllAsRead = markAllAsReadUseCase,
        _archive = archiveNotificationUseCase,
        _unarchive = unarchiveNotificationUseCase,
        _togglePin = toggleNotificationPinUseCase,
        super(const NotificationFeedState());

  final GetNotificationsUseCase _getNotifications;
  final MarkNotificationAsReadUseCase _markAsRead;
  final MarkAllNotificationsAsReadUseCase _markAllAsRead;
  final ArchiveNotificationUseCase _archive;
  final UnarchiveNotificationUseCase _unarchive;
  final ToggleNotificationPinUseCase _togglePin;

  static const int _pageSize = 20;

  void applyFilter(String filter) {
    emit(state.copyWith(filter: filter, hasReachedMax: false));
    fetchNotifications();
  }

  void search(String query) {
    emit(state.copyWith(searchQuery: query, hasReachedMax: false));
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await _getNotifications(
      start: 0,
      pageSize: _pageSize,
      filter: state.filter,
      searchQuery: state.searchQuery,
    );

    switch (result) {
      case ApiSuccess(data: final paginatedList):
        emit(
          state.copyWith(
            isLoading: false,
            notifications: paginatedList.items,
            hasReachedMax: !paginatedList.hasNextPage,
          ),
        );
      case ApiFailure(error: final failure):
        emit(
          state.copyWith(
            isLoading: false,
            error: failure.message,
          ),
        );
    }
  }

  Future<void> fetchMore() async {
    if (state.hasReachedMax || state.isLoading || state.isFetchingMore) return;

    emit(state.copyWith(isFetchingMore: true, error: null));

    final result = await _getNotifications(
      start: state.notifications.length,
      pageSize: _pageSize,
      filter: state.filter,
      searchQuery: state.searchQuery,
    );

    switch (result) {
      case ApiSuccess(data: final paginatedList):
        emit(
          state.copyWith(
            isFetchingMore: false,
            notifications: [...state.notifications, ...paginatedList.items],
            hasReachedMax: !paginatedList.hasNextPage,
          ),
        );
      case ApiFailure(error: final failure):
        emit(
          state.copyWith(
            isFetchingMore: false,
            error: failure.message,
          ),
        );
    }
  }

  Future<void> markAsRead(String id) async {
    // Optimistic update
    final index = state.notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final updatedList = List<NotificationEntity>.from(state.notifications);
      updatedList[index] = updatedList[index].copyWith(isRead: true);
      emit(state.copyWith(notifications: updatedList));
    }

    await _markAsRead(id);
  }

  Future<void> markAllAsRead() async {
    // Optimistic update
    final updatedList = state.notifications
        .map((n) => n.copyWith(isRead: true))
        .toList();
    emit(state.copyWith(notifications: updatedList));

    await _markAllAsRead();
  }

  Future<void> togglePin(String id, {required bool isPinned}) async {
    final index = state.notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final updatedList = List<NotificationEntity>.from(state.notifications);
      updatedList[index] = updatedList[index].copyWith(isPinned: isPinned);
      
      // Keep pinned items at the top
      updatedList.sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.createdAt.compareTo(a.createdAt);
      });
      
      emit(state.copyWith(notifications: updatedList));
    }

    await _togglePin(id, isPinned: isPinned);
  }

  Future<void> archive(String id) async {
    final updatedList = state.notifications.where((n) => n.id != id).toList();
    emit(state.copyWith(notifications: updatedList));

    await _archive(id);
  }

  Future<void> unarchive(String id) async {
    final updatedList = state.notifications.where((n) => n.id != id).toList();
    emit(state.copyWith(notifications: updatedList));

    await _unarchive(id);
  }
}
