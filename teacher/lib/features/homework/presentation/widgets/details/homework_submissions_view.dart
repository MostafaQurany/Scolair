import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/constants/app_route_names.dart';
import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/utils/app_date_time_formatter.dart';
import '../../../domain/entities/homework_submission.dart';
import '../../cubit/submissions/homework_submissions_cubit.dart';
import '../../cubit/submissions/homework_submissions_state.dart';

class HomeworkSubmissionsView extends StatefulWidget {
  const HomeworkSubmissionsView({required this.homeworkName, super.key});

  final String homeworkName;

  @override
  State<HomeworkSubmissionsView> createState() => _HomeworkSubmissionsViewState();
}

class _HomeworkSubmissionsViewState extends State<HomeworkSubmissionsView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeworkSubmissionsCubit>().loadSubmissions(widget.homeworkName);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<HomeworkSubmissionsCubit, HomeworkSubmissionsState>(
      builder: (context, state) {
        if (state.status == HomeworkSubmissionsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == HomeworkSubmissionsStatus.failure) {
          return Center(child: Text(state.errorMessage ?? context.l10n.errorOccurred));
        }

        final filtered = state.filteredSubmissions;

        return Column(
          children: [
            _buildFilterBar(context, state),
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState(context, textTheme)
                  : RefreshIndicator(
                      onRefresh: () => context.read<HomeworkSubmissionsCubit>().loadSubmissions(widget.homeworkName),
                      child: ListView.separated(
                        padding: EdgeInsets.all(16.r),
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) => _buildSubmissionCard(context, colors, textTheme, filtered[index]),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterBar(BuildContext context, HomeworkSubmissionsState state) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      child: Row(
        children: SubmissionFilter.values.map((filter) {
          final isSelected = state.filter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 8.r),
            child: FilterChip(
              label: Text(_getFilterLabel(context, filter)),
              selected: isSelected,
              onSelected: (_) => context.read<HomeworkSubmissionsCubit>().setFilter(filter),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getFilterLabel(BuildContext context, SubmissionFilter filter) {
    switch (filter) {
      case SubmissionFilter.all:
        return context.l10n.all;
      case SubmissionFilter.submitted:
        return context.l10n.homeworkSubmitted;
      case SubmissionFilter.graded:
        return context.l10n.homeworkGraded;
      case SubmissionFilter.late:
        return context.l10n.homeworkLate;
      case SubmissionFilter.needsGrading:
        return context.l10n.homeworkNeedsGrading;
    }
  }

  Widget _buildEmptyState(BuildContext context, TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64.r, color: Theme.of(context).colorScheme.outline),
          SizedBox(height: 16.h),
          Text(context.l10n.homeworkNoSubmissions, style: textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _buildSubmissionCard(
    BuildContext context,
    ColorScheme colors,
    TextTheme textTheme,
    HomeworkSubmissionItem item,
  ) {
    final isGraded = item.status.toLowerCase() == 'graded';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.displayStudentName,
                    style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                if (item.isLate)
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
                  child: Text(item.status, style: TextStyle(color: isGraded ? colors.primary : colors.secondary, fontSize: 11.sp, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (() {
                    final dt = AppDateTimeFormatter.tryParseApiDateTime(item.submittedOn);
                    return dt != null ? AppDateTimeFormatter.formatDate(dt, locale: context.l10n.localeName) : (item.submittedOn ?? '-');
                  })(),
                  style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                ),
                Text(
                  isGraded ? '${item.marks}' : '-',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  await Navigator.of(context).pushNamed(
                    AppRouteNames.homeworkSubmissionDetails,
                    arguments: item.name,
                  );
                  if (context.mounted) {
                    context.read<HomeworkSubmissionsCubit>().loadSubmissions(widget.homeworkName);
                  }
                },
                child: Text(isGraded ? context.l10n.homeworkReview : context.l10n.homeworkGrade),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
