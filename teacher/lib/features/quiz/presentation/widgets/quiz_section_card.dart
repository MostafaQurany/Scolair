import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

/// Reusable section card used in Quiz Settings and Quiz Form.
/// Displays a titled card with children inside padding.
class QuizSectionCard extends StatelessWidget {
  const QuizSectionCard({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(14.r);

    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: radius,
          border: BorderDirectional(
            end: BorderSide(color: colorScheme.primary.withValues(alpha: 0.4)),
            bottom: BorderSide(
              color: colorScheme.primary.withValues(alpha: 0.4),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 4.h),
              child: Text(
                title,
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Divider(
              height: 1,
              color: colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
