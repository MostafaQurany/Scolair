import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/widgets/app_cached_network_image.dart';
import '../../../data/models/courses_models.dart';

class CourseHeaderCard extends StatelessWidget {
  const CourseHeaderCard({required this.course, super.key});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final isRed = course.cardGradient?.toLowerCase() == 'red';
    final headerGrad = isRed
        ? const LinearGradient(
            colors: [Color(0xFFE52D27), Color(0xFFB31217)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [colorScheme.primary, colorScheme.primary.withRed(150)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 140.h,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(decoration: BoxDecoration(gradient: headerGrad)),
                if (course.image != null)
                  AppCachedNetworkImage(
                    imageUrl:
                        (course.image!.contains('http') ||
                            course.image!.contains('https'))
                        ? course.image!
                        : '${ApiEndpoints.baseUrl}${course.image!}',
                    width: double.infinity,
                    height: 140.h,
                    fit: BoxFit.cover,
                    errorWidget: const SizedBox.shrink(),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (course.category != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      course.category!,
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
                Text(
                  course.title,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (course.shortIntroduction != null) ...[
                  SizedBox(height: 10.h),
                  Text(
                    course.shortIntroduction!,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(
                      Icons.video_library,
                      size: 18.r,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      context.l10n.coursesLessonsCount(course.lessons ?? 0),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Icon(
                      Icons.people_outline,
                      size: 18.r,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      context.l10n.coursesEnrollmentsCount(
                        course.enrollments ?? 0,
                      ),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
