import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/widgets/app_user_avatar.dart';
import '../../../data/models/courses_models.dart';

class InstructorsRow extends StatelessWidget {
  const InstructorsRow({
    required this.instructors,
    this.onAddInstructor,
    this.onRemoveInstructor,
    super.key,
  });

  final List<InstructorModel> instructors;
  final VoidCallback? onAddInstructor;
  final ValueChanged<InstructorModel>? onRemoveInstructor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.instructors,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (onAddInstructor != null)
              IconButton(
                onPressed: onAddInstructor,
                icon: const Icon(Icons.person_add_alt_1_outlined),
                iconSize: 20.r,
                tooltip: 'Add Instructor',
              ),
          ],
        ),
        SizedBox(height: 8.h),
        if (instructors.isEmpty)
          Text(
            'No instructors assigned',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          )
        else
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: instructors.map((instructor) {
              final displayName = instructor.fullName ??
                  instructor.username ??
                  instructor.instructor ??
                  instructor.name;
              final isLastInstructor = instructors.length <= 1;

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.3,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppUserAvatar(
                      imageUrl: instructor.userImage,
                      displayName: displayName,
                      userId: instructor.name,
                      radius: 14,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      displayName,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (onRemoveInstructor != null) ...[
                      SizedBox(width: 4.w),
                      InkWell(
                        onTap: isLastInstructor
                            ? null
                            : () => onRemoveInstructor!(instructor),
                        child: Padding(
                          padding: EdgeInsets.all(2.r),
                          child: Icon(
                            Icons.close,
                            size: 16.r,
                            color: isLastInstructor
                                ? colorScheme.onSurfaceVariant.withValues(alpha: 0.3)
                                : colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
