import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../cubit/notification_preferences_cubit.dart';
import '../cubit/notification_preferences_state.dart';

class NotificationPreferencesScreen extends StatelessWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<NotificationPreferencesCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.primary),
        title: Text(context.l10n.notificationsScreenTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child:
            BlocBuilder<
              NotificationPreferencesCubit,
              NotificationPreferencesState
            >(
              bloc: cubit,
              builder: (context, state) => SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      _buildToggleCard(
                        context,
                        title: context.l10n.notifCourseAnnouncementsTitle,
                        subtitle: context.l10n.notifCourseAnnouncementsSub,
                        value: state.courseAnnouncements,
                        onChanged: cubit.toggleCourseAnnouncements,
                      ),
                      SizedBox(height: 16.h),
                      _buildToggleCard(
                        context,
                        title: context.l10n.notifAssignmentUpdatesTitle,
                        subtitle: context.l10n.notifAssignmentUpdatesSub,
                        value: state.assignmentUpdates,
                        onChanged: cubit.toggleAssignmentUpdates,
                      ),
                      SizedBox(height: 16.h),
                      _buildToggleCard(
                        context,
                        title: context.l10n.notifMessagesTitle,
                        subtitle: context.l10n.notifMessagesSub,
                        value: state.messages,
                        onChanged: cubit.toggleMessages,
                      ),
                      SizedBox(height: 16.h),
                      _buildToggleCard(
                        context,
                        title: context.l10n.notifRemindersTitle,
                        subtitle: context.l10n.notifRemindersSub,
                        value: state.reminders,
                        onChanged: cubit.toggleReminders,
                      ),
                      SizedBox(height: 16.h),
                      _buildToggleCard(
                        context,
                        title: context.l10n.notifProductUpdatesTitle,
                        subtitle: context.l10n.notifProductUpdatesSub,
                        value: state.productUpdates,
                        onChanged: cubit.toggleProductUpdates,
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
            ),
      ),
    );
  }

  Widget _buildToggleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
