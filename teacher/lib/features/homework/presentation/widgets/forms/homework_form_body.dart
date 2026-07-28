import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/utils/app_date_time_formatter.dart';
import '../../cubit/homework_form_cubit.dart';
import '../../cubit/homework_form_state.dart';
import 'course_lesson_selection_bottom_sheet.dart';

class HomeworkFormBody extends StatelessWidget {
  const HomeworkFormBody({super.key});

  String _getSelectionText(HomeworkFormState state) {
    if (state.course == null && state.lesson == null) {
      return 'Select Course & Lesson';
    }
    final parts = <String>[];
    if (state.courseTitle != null) {
      parts.add(state.courseTitle!);
    } else if (state.course != null) {
      parts.add(state.course!);
    }
    if (state.lessonTitle != null) {
      parts.add(state.lessonTitle!);
    } else if (state.lesson != null) {
      parts.add(state.lesson!);
    }
    return parts.isEmpty ? 'Select Course & Lesson' : parts.join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<HomeworkFormCubit, HomeworkFormState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(context.l10n.homeworkBasicInfo, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              SizedBox(height: 16.h),
              TextFormField(
                initialValue: state.title,
                decoration: InputDecoration(
                  labelText: context.l10n.homeworkTitleLabel,
                  hintText: context.l10n.homeworkTitleHint,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (val) => context.read<HomeworkFormCubit>().setTitle(val),
              ),
              SizedBox(height: 16.h),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: state.dueDate ?? DateTime.now().add(const Duration(days: 7)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null && context.mounted) {
                    context.read<HomeworkFormCubit>().setDueDate(date);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: context.l10n.homeworkDueDate,
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.calendar_today_outlined),
                  ),
                  child: Text(
                    state.dueDate != null ? AppDateTimeFormatter.formatDate(state.dueDate!, locale: context.l10n.localeName) : context.l10n.homeworkSelectDate,
                    style: TextStyle(color: state.dueDate != null ? colors.onSurface : colors.onSurfaceVariant),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              InkWell(
                onTap: () async {
                  final result = await showModalBottomSheet<CourseLessonSelectionResult>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const CourseLessonSelectionBottomSheet(),
                  );
                  if (result != null && context.mounted) {
                    context.read<HomeworkFormCubit>().setCourseAndLesson(
                          course: result.course,
                          lesson: result.lesson,
                          courseTitle: result.courseTitle,
                          lessonTitle: result.lessonTitle,
                        );
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: '${context.l10n.coursesMyCoursesTab} / ${context.l10n.courseLesson}',
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                  child: Text(
                    _getSelectionText(state),
                    style: TextStyle(
                      color: (state.course != null || state.lesson != null)
                          ? colors.onSurface
                          : colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextFormField(
                initialValue: state.instructions,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: context.l10n.homeworkInstructions,
                  hintText: context.l10n.homeworkInstructionsHint,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (val) => context.read<HomeworkFormCubit>().setInstructions(val),
              ),
              SizedBox(height: 16.h),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(context.l10n.homeworkAllowLate),
                value: state.allowLateSubmission,
                onChanged: (val) => context.read<HomeworkFormCubit>().setAllowLateSubmission(val),
              ),
            ],
          ),
        );
      },
    );
  }
}
