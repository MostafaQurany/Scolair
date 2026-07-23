import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/widgets/app_user_avatar.dart';
import '../../data/models/courses_models.dart';

class StudentListItem extends StatelessWidget {
  const StudentListItem({
    required this.student,
    required this.onRemove,
    super.key,
  });

  final StudentModel student;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayName = student.memberName ??
        student.memberUsername ??
        student.member ??
        student.name;
    final email = student.member ?? student.name;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          AppUserAvatar(
            imageUrl: student.memberImage,
            displayName: displayName,
            userId: student.name,
            radius: 22,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (email.isNotEmpty && email != displayName) ...[
                  SizedBox(height: 2.h),
                  Text(
                    email,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.person_remove_outlined,
              color: theme.colorScheme.error,
              size: 20.r,
            ),
            onPressed: onRemove,
            tooltip: 'Remove Student',
          ),
        ],
      ),
    );
  }
}
