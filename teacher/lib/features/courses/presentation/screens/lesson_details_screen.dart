import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/usecases/courses_usecases.dart';
import '../cubit/lesson_details_cubit.dart';
import '../cubit/lesson_details_state.dart';
import '../widgets/editorjs_renderer.dart';
import 'lesson_form_screen.dart';
import '../widgets/forms/delete_confirmation_dialog.dart';

class LessonDetailsScreenArgs {
  const LessonDetailsScreenArgs({
    required this.lessonName,
    required this.chapterName,
  });

  final String lessonName;
  final String chapterName;
}

class LessonDetailsScreen extends StatelessWidget {
  const LessonDetailsScreen({
    required this.lessonName,
    required this.chapterName,
    super.key,
  });

  final String lessonName;
  final String chapterName;

  Future<void> _deleteLesson(
    BuildContext context,
    LessonDetailsCubit cubit,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: context.l10n.deleteLessonConfirmTitle,
        body: context.l10n.deleteLessonConfirmBody,
      ),
    );

    if ((confirmed ?? false) && context.mounted) {
      final res = await getIt<DeleteLessonUseCase>().call(
        lessonName: lessonName,
        chapterName: chapterName,
      );
      if (context.mounted) {
        res.when(
          success: (_) {
            AppSnackBar.showSuccess(context, context.l10n.lessonDeletedSuccess);
            Navigator.pop(
              context,
              true,
            ); // Pop screen back with success indicator to refresh outline.
          },
          failure: (fail) => AppSnackBar.showError(context, fail.message),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) => getIt<LessonDetailsCubit>()..loadLessonDetails(lessonName),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(context.l10n.lessonMaterial),
          actions: [
            BlocBuilder<LessonDetailsCubit, LessonDetailsState>(
              builder: (context, state) {
                final lesson = state.lesson;
                if (lesson == null) return const SizedBox.shrink();

                final cubit = context.read<LessonDetailsCubit>();
                return PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'edit') {
                      final updated = await Navigator.pushNamed(
                        context,
                        AppRouteNames.lessonForm,
                        arguments: LessonFormScreenArgs(
                          chapterName: chapterName,
                          editingLesson: lesson,
                        ),
                      );
                      if (updated == true && context.mounted) {
                        cubit.loadLessonDetails(lessonName);
                      }
                    } else if (value == 'delete') {
                      _deleteLesson(context, cubit);
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
        body: _LessonDetailsView(chapterName: chapterName),
      ),
    );
}

class _LessonDetailsView extends StatelessWidget {
  const _LessonDetailsView({required this.chapterName});

  final String chapterName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<LessonDetailsCubit, LessonDetailsState>(
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
                      context.read<LessonDetailsCubit>().loadLessonDetails(
                        context.read<LessonDetailsCubit>().state.lesson?.name ??
                            '',
                      );
                    },
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            ),
          );
        }

        final lesson = state.lesson;
        if (lesson == null) {
          return const SizedBox.shrink();
        }

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          children: [
            // Chapter info header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.folder_open,
                    size: 14.r,
                    color: colorScheme.secondary,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      chapterName,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Lesson title
            Text(
              lesson.title,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.h),
            // Editor.js content renderer
            EditorJsRenderer(
              content: lesson.content,
              onRemoveQuiz: (quizName) {
                context.read<LessonDetailsCubit>().removeQuizFromLesson(
                  quizName,
                );
              },
            ),

            // Instructor notes or files if present
            if (lesson.instructorNotes != null &&
                lesson.instructorNotes!.isNotEmpty) ...[
              SizedBox(height: 32.h),
              const Divider(),
              SizedBox(height: 16.h),
              Text(
                context.l10n.instructorNotes,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: colorScheme.tertiaryContainer.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: colorScheme.tertiaryContainer.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  lesson.instructorNotes!,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
              ),
            ],
            SizedBox(height: 48.h),
          ],
        );
      },
    );
  }
}
