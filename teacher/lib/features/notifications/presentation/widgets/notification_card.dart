import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/notification_category.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_priority.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.notification, super.key,
    this.onTap,
    this.onTogglePin,
    this.onArchive,
    this.onUnarchive,
  });

  final NotificationEntity notification;
  final VoidCallback? onTap;
  final VoidCallback? onTogglePin;
  final VoidCallback? onArchive;
  final VoidCallback? onUnarchive;

  @override
  Widget build(BuildContext context) => Card(
      elevation: notification.isRead ? 0 : 2,
      color: notification.isRead ? Colors.transparent : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: notification.isRead ? AppColors.border : Colors.transparent,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: AppTextStyles.labelLarge.copyWith(
                              fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                            ),
                          ),
                        ),
                        if (notification.isPinned)
                          const Icon(Icons.push_pin, size: 16, color: AppColors.primary),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          _formatDate(notification.createdAt),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                        if (notification.actionRequired) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: notification.actionCompleted 
                                ? AppColors.success.withValues(alpha: 0.1) 
                                : AppColors.error.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              notification.actionCompleted ? 'Completed' : 'Action Required',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: notification.actionCompleted ? AppColors.success : AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              if (onTogglePin != null || onArchive != null || onUnarchive != null)
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert, size: 20),
                  itemBuilder: (context) => [
                    if (onTogglePin != null)
                      PopupMenuItem(
                        onTap: onTogglePin,
                        child: Text(notification.isPinned ? 'Unpin' : 'Pin'),
                      ),
                    if (onArchive != null && !notification.isArchived)
                      PopupMenuItem(
                        onTap: onArchive,
                        child: const Text('Archive'),
                      ),
                    if (onUnarchive != null && notification.isArchived)
                      PopupMenuItem(
                        onTap: onUnarchive,
                        child: const Text('Unarchive'),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );

  Widget _buildIcon() {
    var iconData = Icons.notifications;
    var iconColor = AppColors.primary;

    switch (notification.category) {
      case NotificationCategory.assignmentSubmission:
      case NotificationCategory.quizSubmission:
      case NotificationCategory.manualGradingRequired:
      case NotificationCategory.gradesPublished:
        iconData = Icons.assignment;
        iconColor = Colors.orange;
        break;
      case NotificationCategory.collaborationPost:
      case NotificationCategory.collaborationComment:
      case NotificationCategory.studyGroupActivity:
        iconData = Icons.forum;
        iconColor = Colors.purple;
        break;
      case NotificationCategory.moderation:
      case NotificationCategory.security:
        iconData = Icons.security;
        iconColor = AppColors.error;
        break;
      case NotificationCategory.smartNotes:
      case NotificationCategory.enrollment:
      case NotificationCategory.integrationSync:
        iconData = Icons.library_books;
        iconColor = AppColors.primary;
        break;
      case NotificationCategory.studentRisk:
      case NotificationCategory.workloadCapacity:
        iconData = Icons.warning_amber_rounded;
        iconColor = Colors.amber;
        break;
    }

    if (notification.priority == NotificationPriority.high || notification.priority == NotificationPriority.urgent) {
      iconColor = AppColors.error;
    }

    return CircleAvatar(
      backgroundColor: iconColor.withValues(alpha: 0.1),
      child: Icon(iconData, color: iconColor),
    );
  }

  String _formatDate(DateTime date) {
    // Simple format for now, would typically use intl package or timeago
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
