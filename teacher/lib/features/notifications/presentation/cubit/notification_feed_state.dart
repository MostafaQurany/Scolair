part of 'notification_feed_cubit.dart';

@freezed
abstract class NotificationFeedState with _$NotificationFeedState {
  const factory NotificationFeedState({
    @Default([]) List<NotificationEntity> notifications,
    @Default(true) bool isLoading,
    @Default(false) bool isFetchingMore,
    @Default(false) bool hasReachedMax,
    @Default('') String filter, // 'unread', 'archived', 'submissions'
    @Default('') String searchQuery,
    String? error,
  }) = _NotificationFeedState;
}
