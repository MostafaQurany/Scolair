import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_submission_models.dart';
import '../cubit/submissions/quiz_submissions_cubit.dart';
import '../cubit/submissions/quiz_submissions_state.dart';
import 'quiz_submissions_list_shimmer.dart';

class QuizSubmissionsView extends StatelessWidget {
  const QuizSubmissionsView({required this.quizName, super.key});

  final String quizName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<QuizSubmissionsCubit>()..fetchSubmissions(quizName),
      child: BlocBuilder<QuizSubmissionsCubit, QuizSubmissionsState>(
        builder: (context, state) {
          if (state.status == QuizSubmissionsStatus.loading) {
            return const QuizSubmissionsListShimmer();
          }

          if (state.status == QuizSubmissionsStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage ?? context.l10n.authErrorGeneric,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context
                        .read<QuizSubmissionsCubit>()
                        .fetchSubmissions(quizName),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            );
          }

          final submissions = state.filteredSubmissions;

          if (submissions.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_turned_in_outlined,
                      size: 64.r,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withAlpha(100),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      context.l10n.homeworkNoSubmissions,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              _buildFilterChips(context, state),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    left: 16.r,
                    right: 16.r,
                    top: 8.r,
                    bottom: 80.r,
                  ),
                  itemCount: submissions.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final submission = submissions[index];
                    return _SubmissionItemCard(
                      submission: submission,
                      quizName: quizName,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, QuizSubmissionsState state) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
      child: Row(
        children: QuizSubmissionFilter.values.map((filter) {
          final isSelected = state.filter == filter;
          String label = filter.name;
          if (filter == QuizSubmissionFilter.all) label = context.l10n.all;
          if (filter == QuizSubmissionFilter.needsGrading) {
            label = context.l10n.homeworkNeedsGrading;
          }

          return Padding(
            padding: EdgeInsets.only(right: 8.r),
            child: FilterChip(
              selected: isSelected,
              label: Text(label),
              onSelected: (selected) {
                if (selected) {
                  context.read<QuizSubmissionsCubit>().setFilter(filter);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SubmissionItemCard extends StatelessWidget {
  const _SubmissionItemCard({required this.submission, required this.quizName});

  final QuizSubmissionItemModel submission;
  final String quizName;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isNeedsGrading = submission.requiresManualGrading;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colors.outlineVariant.withAlpha(100)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRouteNames.quizSubmissionDetails,
            arguments: {'quizName': quizName, 'submission': submission},
          );
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colors.primaryContainer,
                child: Text(
                  submission.memberName.isNotEmpty
                      ? submission.memberName[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: colors.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      submission.memberName,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14.r,
                          color: colors.onSurfaceVariant,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            submission.creation.split(' ')[0], // Date only
                            style: textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isNeedsGrading)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.tertiaryContainer,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        context.l10n.homeworkNeedsGrading,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.onTertiaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    Text(
                      '${submission.score}/${submission.scoreOutOf}',
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  SizedBox(height: 4.h),
                  Text(
                    '${submission.percentage.toStringAsFixed(1)}%',
                    style: textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
