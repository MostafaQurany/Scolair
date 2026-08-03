import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scolair_teacher/core/constants/app_route_names.dart';
import 'package:scolair_teacher/core/di/dependency_injection.dart';
import 'package:scolair_teacher/core/localization/localization_extension.dart';
import 'package:scolair_teacher/core/theme/app_colors.dart';
import 'package:scolair_teacher/core/theme/app_text_styles.dart';
import '../cubit/notification_feed_cubit.dart';
import '../widgets/notification_card.dart';
import '../utils/notification_navigation_helper.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationFeedScreen extends StatefulWidget {
  const NotificationFeedScreen({super.key});

  @override
  State<NotificationFeedScreen> createState() => _NotificationFeedScreenState();
}

class _NotificationFeedScreenState extends State<NotificationFeedScreen> {
  late final NotificationFeedCubit _cubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = getIt<NotificationFeedCubit>()..fetchNotifications();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      _cubit.fetchMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.notifications),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                Navigator.pushNamed(context, AppRouteNames.notificationPreferences);
              },
            ),
            IconButton(
              icon: const Icon(Icons.inventory_2_outlined),
              onPressed: () async {
                await Navigator.pushNamed(context, AppRouteNames.archivedNotifications);
                // Refresh the feed when returning to pick up any unarchived items
                _cubit.fetchNotifications();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            _buildFilterBar(),
            Expanded(
              child: BlocBuilder<NotificationFeedCubit, NotificationFeedState>(
                builder: (context, state) {
                  if (state.isLoading && state.notifications.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.error != null && state.notifications.isEmpty) {
                    return Center(
                      child: Text(
                        state.error!,
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
                      ),
                    );
                  }

                  if (state.notifications.isEmpty) {
                    return Center(
                      child: Text(
                        context.l10n.noNotifications,
                        style: AppTextStyles.bodyLarge,
                      ),
                    );
                  }

                  final flatList = _buildGroupedList(state.notifications);

                  return RefreshIndicator(
                    onRefresh: () => _cubit.fetchNotifications(),
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: flatList.length + (state.isFetchingMore ? 1 : 0),
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        if (index >= flatList.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final item = flatList[index];

                        if (item is String) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 4, left: 4),
                            child: Text(
                              item,
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.textTertiary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else if (item is NotificationEntity) {
                          final notification = item;
                          return NotificationCard(
                            notification: notification,
                            onTap: () {
                              _cubit.markAsRead(notification.id);
                              NotificationNavigationHelper.navigateFromNotification(context, notification);
                            },
                            onTogglePin: () {
                              _cubit.togglePin(notification.id, isPinned: !notification.isPinned);
                            },
                            onArchive: () {
                              _cubit.archive(notification.id);
                            },
                          );
                        }
                        
                        return const SizedBox();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return BlocBuilder<NotificationFeedCubit, NotificationFeedState>(
      buildWhen: (previous, current) => previous.filter != current.filter,
      builder: (context, state) {
        final filters = {
          '': context.l10n.all,
          'unread': context.l10n.unread,
          'action_required': context.l10n.actionRequired,
        };

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: filters.entries.map((entry) {
              final isSelected = state.filter == entry.key;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(entry.value),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      _cubit.applyFilter(entry.key);
                    }
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  List<Object> _buildGroupedList(List<NotificationEntity> notifications) {
    final Map<String, List<NotificationEntity>> grouped = {
      context.l10n.notificationGroupPinned: [],
      context.l10n.notificationGroupToday: [],
      context.l10n.notificationGroupYesterday: [],
      context.l10n.notificationGroupEarlierThisWeek: [],
      context.l10n.notificationGroupEarlierThisMonth: [],
      context.l10n.notificationGroupOlder: [],
    };

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final thisWeek = today.subtract(Duration(days: today.weekday - 1));
    final thisMonth = DateTime(now.year, now.month, 1);

    for (var notification in notifications) {
      if (notification.isPinned) {
        grouped[context.l10n.notificationGroupPinned]!.add(notification);
        continue;
      }

      final date = notification.createdAt;
      final dateOnly = DateTime(date.year, date.month, date.day);

      if (dateOnly == today) {
        grouped[context.l10n.notificationGroupToday]!.add(notification);
      } else if (dateOnly == yesterday) {
        grouped[context.l10n.notificationGroupYesterday]!.add(notification);
      } else if (dateOnly.isAfter(thisWeek) || dateOnly == thisWeek) {
        grouped[context.l10n.notificationGroupEarlierThisWeek]!.add(notification);
      } else if (dateOnly.isAfter(thisMonth) || dateOnly == thisMonth) {
        grouped[context.l10n.notificationGroupEarlierThisMonth]!.add(notification);
      } else {
        grouped[context.l10n.notificationGroupOlder]!.add(notification);
      }
    }

    final List<Object> flatList = [];
    grouped.forEach((header, items) {
      if (items.isNotEmpty) {
        flatList.add(header);
        flatList.addAll(items);
      }
    });

    return flatList;
  }
}
