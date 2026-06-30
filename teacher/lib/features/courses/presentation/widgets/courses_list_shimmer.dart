import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/adaptive_layout_extension.dart';

class CoursesListShimmer extends StatelessWidget {
  const CoursesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: context.isTabletLayout ? 32.w : 20.w,
      vertical: 8.h,
    );

    return Skeletonizer(
      child: ListView.builder(
        padding: padding,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (_, _) => const _ShimmerCourseCard(),
      ),
    );
  }
}

class _ShimmerCourseCard extends StatelessWidget {
  const _ShimmerCourseCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: 120.h, color: colorScheme.surfaceContainerHighest),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 12.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  height: 12.h,
                  width: 140.w,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 12.h),
                const Divider(),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _InfoPlaceholder(width: 60.w),
                    const Spacer(),
                    _InfoPlaceholder(width: 60.w),
                    const Spacer(),
                    _InfoPlaceholder(width: 40.w),
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

class _InfoPlaceholder extends StatelessWidget {
  const _InfoPlaceholder({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
