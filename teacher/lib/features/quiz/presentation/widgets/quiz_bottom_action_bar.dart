import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';

/// Persistent bottom bar with Schedule and Publish buttons.
class QuizBottomActionBar extends StatelessWidget {
  const QuizBottomActionBar({
    required this.isLoading,
    required this.onSchedule,
    required this.onPublish,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onSchedule;
  final VoidCallback onPublish;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 14.h + bottomPadding),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withValues(alpha: 0.06),
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: isLoading ? null : onSchedule,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              child: Text(context.l10n.quizScheduleButton),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: FilledButton(
              onPressed: isLoading ? null : onPublish,
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              child: isLoading
                  ? SizedBox(
                      width: 20.r,
                      height: 20.r,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(context.l10n.quizPublishButton),
            ),
          ),
        ],
      ),
    );
  }
}
