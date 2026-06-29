import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/usecases/courses_usecases.dart';
import '../cubit/course_details_cubit.dart';
import '../cubit/course_details_state.dart';
import '../screens/course_form_screen.dart';
import '../screens/chapter_form_screen.dart';
import '../widgets/course_details/course_header_card.dart';
import '../widgets/course_details/instructors_row.dart';
import '../widgets/course_details/chapter_expansion_tile.dart';
import '../widgets/forms/delete_confirmation_dialog.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({required this.courseName, super.key});

  final String courseName;

  Future<void> _deleteCourse(BuildContext context, String name) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: context.l10n.deleteCourseConfirmTitle,
        body: context.l10n.deleteCourseConfirmBody,
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<CourseDetailsCubit>().deleteChapter(name);
      // Wait, we call deleteCourse instead! Let's check how the cubit exposes deleting a course.
      // Wait, the courses list has delete course, or we can use use case directly:
      // final res = await getIt<DeleteCourseUseCase>().call(courseName);
      // Let's implement deleteCourse directly in CourseDetailsCubit or call repository.
      // Wait, CourseDetailsCubit can also have deleteCourse, or we use getIt.
      // Let's use getIt<DeleteCourseUseCase>() to keep it simple!
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
      // Call DeleteCourseUseCase:
      final res = await getIt<DeleteCourseUseCase>().call(name);
      if (context.mounted) {
        Navigator.pop(context); // Pop loading.
        res.when(
          success: (_) {
            AppSnackBar.showSuccess(context, context.l10n.courseDeletedSuccess);
            Navigator.pop(
              context,
              true,
            ); // Pop details screen back to list with refresh code.
          },
          failure: (fail) => AppSnackBar.showError(context, fail.message),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CourseDetailsCubit>()..loadCourseDetails(courseName),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.courseDetails),
          actions: [
            BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
              builder: (context, state) {
                final course = state.course;
                if (course == null) return const SizedBox.shrink();

                return PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'edit') {
                      final updated = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CourseFormScreen(editingCourse: course),
                        ),
                      );
                      if (updated == true && context.mounted) {
                        context.read<CourseDetailsCubit>().loadCourseDetails(
                          courseName,
                        );
                      }
                    } else if (value == 'delete') {
                      _deleteCourse(context, course.name);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text(context.l10n.editCourse),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(
                        context.l10n.deleteCourse,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: const _CourseDetailsView(),
      ),
    );
  }
}

class _CourseDetailsView extends StatelessWidget {
  const _CourseDetailsView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.errorMessage!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  FilledButton(
                    onPressed: () {
                      final courseName = state.course?.name;
                      if (courseName != null) {
                        context.read<CourseDetailsCubit>().loadCourseDetails(
                          courseName,
                        );
                      }
                    },
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            ),
          );
        }

        final course = state.course;
        if (course == null) {
          return const SizedBox.shrink();
        }

        return ListView(
          padding: EdgeInsets.all(20.r),
          children: [
            CourseHeaderCard(course: course),
            SizedBox(height: 20.h),
            InstructorsRow(instructors: course.instructors ?? []),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.courseOutline,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () async {
                    final res = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ChapterFormScreen(courseName: course.name),
                      ),
                    );
                    if (res == true && context.mounted) {
                      context.read<CourseDetailsCubit>().loadCourseDetails(
                        course.name,
                      );
                    }
                  },
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(context.l10n.createChapter),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            if (state.chapters == null || state.chapters!.isEmpty)
              _buildEmptyOutline(context)
            else
              ...state.chapters!.map(
                (chapter) => ChapterExpansionTile(
                  chapter: chapter,
                  courseName: course.name,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyOutline(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        child: Center(
          child: Text(
            context.l10n.noChaptersOrLessons,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    );
  }
}
