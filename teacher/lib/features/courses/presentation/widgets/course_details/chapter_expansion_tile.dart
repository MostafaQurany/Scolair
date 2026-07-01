import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/widgets/app_snack_bar.dart';
import '../../../data/models/courses_models.dart';
import '../../../domain/usecases/courses_usecases.dart';
import '../../cubit/course_details_cubit.dart';
import '../../screens/chapter_form_screen.dart';
import '../../screens/lesson_details_screen.dart';
import '../../screens/lesson_form_screen.dart';
import '../forms/delete_confirmation_dialog.dart';

class ChapterExpansionTile extends StatelessWidget {
  const ChapterExpansionTile({
    required this.chapter,
    required this.courseName,
    required this.canManageCourse,
    super.key,
  });

  final ChapterDetailModel chapter;
  final String courseName;
  final bool canManageCourse;

  Future<void> _deleteChapter(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: context.l10n.deleteChapterConfirmTitle,
        body: context.l10n.deleteChapterConfirmBody,
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<CourseDetailsCubit>().deleteChapter(chapter.name);
    }
  }

  Future<void> _deleteLesson(BuildContext context, String lessonName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: context.l10n.deleteLessonConfirmTitle,
        body: context.l10n.deleteLessonConfirmBody,
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<CourseDetailsCubit>().deleteLesson(lessonName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<CourseDetailsCubit>();

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              chapter.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              context.l10n.coursesLessonsCount(chapter.lessons.length),
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12.sp,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (canManageCourse)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) async {
                      if (value == 'edit') {
                        final res = await showDialog<bool>(
                          context: context,
                          builder: (_) => ChapterFormScreen(
                            courseName: courseName,
                            editingChapter: chapter,
                          ),
                        );
                        if (res == true && context.mounted) {
                          cubit.loadCourseDetails(courseName);
                        }
                      } else if (value == 'delete') {
                        _deleteChapter(context);
                      } else if (value == 'create_lesson') {
                        final res = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                LessonFormScreen(chapterName: chapter.name),
                          ),
                        );
                        if (res == true && context.mounted) {
                          cubit.loadCourseDetails(courseName);
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'create_lesson',
                        child: Text(context.l10n.createLesson),
                      ),
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(context.l10n.editChapter),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(
                          context.l10n.deleteChapter,
                          style: TextStyle(color: colorScheme.error),
                        ),
                      ),
                    ],
                  ),
                const Icon(Icons.expand_more),
              ],
            ),
            childrenPadding: EdgeInsets.zero,
            children: [
              const Divider(height: 1),
              if (chapter.lessons.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
                  child: Text(
                    context.l10n.noChaptersOrLessons,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 12.sp,
                    ),
                  ),
                )
              else
                ...chapter.lessons.map(
                  (lesson) =>
                      _buildLessonItem(context, lesson, chapter.name, cubit),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLessonItem(
    BuildContext context,
    LessonSummaryModel lesson,
    String chapterName,
    CourseDetailsCubit cubit,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    IconData icon = Icons.description;
    Color iconColor = colorScheme.onSurfaceVariant;

    final nameLower = lesson.icon.toLowerCase();
    if (nameLower.contains('youtube') || lesson.youtube != null) {
      icon = Icons.play_circle_outline;
      iconColor = Colors.redAccent;
    } else if (nameLower.contains('quiz') || lesson.quizId != null) {
      icon = Icons.assignment_outlined;
      iconColor = Colors.deepPurple;
    } else if (lesson.fileType.toLowerCase() == 'pdf') {
      icon = Icons.picture_as_pdf_outlined;
      iconColor = Colors.orange;
    } else if (lesson.fileType.toLowerCase() == 'mp4') {
      icon = Icons.videocam_outlined;
      iconColor = Colors.blue;
    }

    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20.r),
        ),
        title: Text(
          lesson.title,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (canManageCourse)
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, size: 20),
                onSelected: (value) async {
                  if (value == 'edit') {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                    final lessonRes = await getIt<GetLessonUseCase>().call(
                      lesson.name,
                    );
                    if (context.mounted) {
                      Navigator.pop(context);
                    }

                    lessonRes.when(
                      success: (fullLesson) async {
                        if (context.mounted) {
                          final updated = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LessonFormScreen(
                                chapterName: chapterName,
                                editingLesson: fullLesson,
                              ),
                            ),
                          );
                          if (updated == true && context.mounted) {
                            cubit.loadCourseDetails(courseName);
                          }
                        }
                      },
                      failure: (fail) {
                        if (context.mounted) {
                          AppSnackBar.showError(context, fail.message);
                        }
                      },
                    );
                  } else if (value == 'delete') {
                    _deleteLesson(context, lesson.name);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text(context.l10n.editLesson),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      context.l10n.deleteLesson,
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ),
                ],
              ),
            const Icon(Icons.arrow_forward_ios, size: 12),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonDetailsScreen(
                lessonName: lesson.name,
                chapterName: chapterName,
              ),
            ),
          );
        },
      ),
    );
  }
}
