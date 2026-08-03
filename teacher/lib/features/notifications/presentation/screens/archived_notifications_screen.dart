import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scolair_teacher/core/di/dependency_injection.dart';
import 'package:scolair_teacher/core/localization/localization_extension.dart';
import 'package:scolair_teacher/core/theme/app_colors.dart';
import 'package:scolair_teacher/core/theme/app_text_styles.dart';
import '../cubit/notification_feed_cubit.dart';
import '../widgets/notification_card.dart';
import '../utils/notification_navigation_helper.dart';
import '../../domain/entities/notification_entity.dart';

class ArchivedNotificationsScreen extends StatefulWidget {
  const ArchivedNotificationsScreen({super.key});

  @override
  State<ArchivedNotificationsScreen> createState() => _ArchivedNotificationsScreenState();
}

class _ArchivedNotificationsScreenState extends State<ArchivedNotificationsScreen> {
  late final NotificationFeedCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<NotificationFeedCubit>()..applyFilter('archived');
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.archivedNotifications),
        ),
        body: BlocBuilder<NotificationFeedCubit, NotificationFeedState>(
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

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: flatList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
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
                      NotificationNavigationHelper.navigateFromNotification(context, notification);
                    },
                    onUnarchive: () {
                      _cubit.unarchive(notification.id);
                    },
                  );
                }

                return const SizedBox();
              },
            );
          },
        ),
      ),
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
