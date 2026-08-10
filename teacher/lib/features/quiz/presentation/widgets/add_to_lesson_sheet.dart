import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../../courses/data/models/courses_models.dart';
import '../cubit/add_to_lesson/add_to_lesson_cubit.dart';
import '../cubit/add_to_lesson/add_to_lesson_state.dart';

class AddToLessonSheet extends StatelessWidget {
  const AddToLessonSheet({required this.quizName, super.key});

  final String quizName;

  static Future<void> show(BuildContext context, String quizName) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddToLessonSheet(quizName: quizName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<AddToLessonCubit>(),
      child: Container(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: BlocConsumer<AddToLessonCubit, AddToLessonState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              AppSnackBar.showError(context, state.errorMessage!);
            }
            if (state.isSuccess) {
              AppSnackBar.showSuccess(
                context,
                context.l10n.addedToLessonSuccess,
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final cubit = context.read<AddToLessonCubit>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: theme.dividerColor,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  context.l10n.addToLessonTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),

                // Course Selection
                if (state.isLoadingCourses)
                  const Center(child: CircularProgressIndicator())
                else
                  DropdownButtonFormField<CourseModel>(
                    initialValue: state.selectedCourse,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: context.l10n.selectCourse,
                      border: const OutlineInputBorder(),
                    ),
                    items: state.courses.map((course) {
                      return DropdownMenuItem(
                        value: course,
                        child: Text(
                          course.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (course) => cubit.selectCourse(course),
                  ),

                SizedBox(height: 16.h),

                // Chapter Selection
                if (state.isLoadingChapters)
                  const Center(child: CircularProgressIndicator())
                else if (state.selectedCourse != null)
                  DropdownButtonFormField<ChapterSummaryModel>(
                    initialValue: state.selectedChapter,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: context.l10n.selectChapter,
                      border: const OutlineInputBorder(),
                    ),
                    items: state.chapters.map((chapter) {
                      return DropdownMenuItem(
                        value: chapter,
                        child: Text(
                          chapter.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (chapter) => cubit.selectChapter(chapter),
                  ),

                SizedBox(height: 16.h),

                // Lesson Selection
                if (state.isLoadingLessons)
                  const Center(child: CircularProgressIndicator())
                else if (state.selectedChapter != null)
                  DropdownButtonFormField<LessonSummaryModel>(
                    initialValue: state.selectedLesson,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: context.l10n.selectLesson,
                      border: const OutlineInputBorder(),
                    ),
                    items: state.lessons.map((lesson) {
                      return DropdownMenuItem(
                        value: lesson,
                        child: Text(
                          lesson.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (lesson) => cubit.selectLesson(lesson),
                  ),

                SizedBox(height: 24.h),

                FilledButton(
                  onPressed: state.selectedLesson == null || state.isSubmitting
                      ? null
                      : () => cubit.addQuizToLesson(quizName),
                  child: state.isSubmitting
                      ? SizedBox(
                          height: 20.r,
                          width: 20.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Text(context.l10n.addQuizButton),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
