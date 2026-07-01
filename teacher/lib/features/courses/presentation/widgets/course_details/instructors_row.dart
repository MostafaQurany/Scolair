import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../data/models/courses_models.dart';

class InstructorsRow extends StatelessWidget {
  const InstructorsRow({required this.instructors, super.key});

  final List<InstructorModel> instructors;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (instructors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.instructors,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        Row(
          children: instructors.map((instructor) {
            final hasImg = instructor.userImage != null;
            return Container(
              margin: EdgeInsetsDirectional.only(end: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.2,
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: colorScheme.primaryContainer,
                    backgroundImage: hasImg
                        ? NetworkImage(
                            '${ApiEndpoints.baseUrl}${instructor.userImage!}',
                          )
                        : null,
                    child: !hasImg
                        ? Icon(
                            Icons.person,
                            color: colorScheme.primary,
                            size: 16.r,
                          )
                        : null,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    instructor.fullName ??
                        instructor.username ??
                        instructor.instructor ??
                        '',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
