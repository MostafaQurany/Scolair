import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/utils/app_date_time_formatter.dart';
import '../../../../../core/widgets/app_user_avatar.dart';
import '../../../domain/entities/homework_submission.dart';

class HomeworkSubmissionInfoCard extends StatelessWidget {
  const HomeworkSubmissionInfoCard({required this.submission, super.key});

  final HomeworkSubmissionDetail submission;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isGraded = submission.status.toLowerCase() == 'graded';
    final maxScore = submission.questions.fold<num>(0, (sum, q) => sum + q.maxMarks);

    return Card(
      elevation: 0,
      margin: EdgeInsets.all(16.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppUserAvatar(
                  imageUrl: null,
                  displayName: submission.displayStudentName,
                  userId: submission.member,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        submission.displayStudentName,
                        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      if (submission.member != submission.displayStudentName)
                        Text(
                          submission.member,
                          style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                        ),
                    ],
                  ),
                ),
                if (submission.isLate)
                  Container(
                    margin: EdgeInsets.only(right: 8.r),
                    padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
                    decoration: BoxDecoration(color: colors.errorContainer, borderRadius: BorderRadius.circular(4.r)),
                    child: Text(context.l10n.homeworkLate, style: TextStyle(color: colors.error, fontSize: 11.sp, fontWeight: FontWeight.w700)),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
                  decoration: BoxDecoration(
                    color: isGraded ? colors.primaryContainer : colors.secondaryContainer,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(submission.status, style: TextStyle(color: isGraded ? colors.primary : colors.secondary, fontSize: 11.sp, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (() {
                    final dt = AppDateTimeFormatter.tryParseApiDateTime(submission.submittedOn);
                    return dt != null ? AppDateTimeFormatter.formatDate(dt, locale: context.l10n.localeName) : (submission.submittedOn ?? '-');
                  })(),
                  style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                ),
                Text(
                  '${submission.totalMarks} / $maxScore',
                  style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: colors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
