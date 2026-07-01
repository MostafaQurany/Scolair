import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';

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
    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        12.h,
        16.w,
        16.h + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: isLoading ? null : onSchedule,
              child: Text(context.l10n.quizScheduleButton),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: FilledButton(
              onPressed: isLoading ? null : onPublish,
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
