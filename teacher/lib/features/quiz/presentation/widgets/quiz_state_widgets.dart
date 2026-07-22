import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/localization/localization_extension.dart';

/// Skeleton shimmer loading state for quiz question lists.
class QuizQuestionsShimmer extends StatelessWidget {
  const QuizQuestionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Skeletonizer(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 10.h),
                child: Row(
                  children: [
                    Container(
                      width: 112.w,
                      height: 22.h,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 96.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverList.builder(
              itemCount: 4,
              itemBuilder: (context, index) => _ShimmerCard(index: index),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colorScheme.outlineVariant, width: 1.w),
      ),
      child: Row(
        children: [
          Icon(
            Icons.drag_indicator,
            size: 20.r,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Q${index + 1}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 64.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 48.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.infinity,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  width: 220.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.delete_outline, size: 20.r, color: colorScheme.error),
        ],
      ),
    );
  }
}

/// Empty state widget for when there are no questions.
class QuizEmptyState extends StatelessWidget {
  const QuizEmptyState({required this.onAdd, super.key});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.r,
              height: 72.r,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Icon(
                Icons.quiz_outlined,
                size: 36.r,
                color: colorScheme.primary,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              context.l10n.quizNoQuestionsTitle,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              context.l10n.quizNoQuestionsSubtitle,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onAdd,
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                icon: const Icon(Icons.add),
                label: Text(context.l10n.questionAddTitle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Error state widget for quiz screens.
class QuizErrorState extends StatelessWidget {
  const QuizErrorState({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                size: 32.r,
                color: colorScheme.error,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              context.l10n.quizErrorTitle,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(context.l10n.quizRetryButton),
            ),
          ],
        ),
      ),
    );
  }
}
