import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubit/lesson_details_cubit.dart';
import '../cubit/lesson_details_state.dart';
import '../widgets/editorjs_renderer.dart';

class LessonDetailsScreen extends StatelessWidget {
  const LessonDetailsScreen({
    required this.lessonName,
    required this.chapterName,
    super.key,
  });

  final String lessonName;
  final String chapterName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LessonDetailsCubit>()..loadLessonDetails(lessonName),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lesson Material'),
        ),
        body: _LessonDetailsView(chapterName: chapterName),
      ),
    );
  }
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
                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  FilledButton(
                    onPressed: () {
                      context.read<LessonDetailsCubit>().loadLessonDetails(
                            context.read<LessonDetailsCubit>().state.lesson?.name ?? '',
                          );
                    },
                    child: const Text('Retry'),
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
                color: colorScheme.secondaryContainer.withOpacity(0.5),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.folder_open, size: 14.r, color: colorScheme.secondary),
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
              style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24.h),
            // Editor.js content renderer
            EditorJsRenderer(content: lesson.content),

            // Instructor notes or files if present
            if (lesson.instructorNotes != null && lesson.instructorNotes!.isNotEmpty) ...[
              SizedBox(height: 32.h),
              const Divider(),
              SizedBox(height: 16.h),
              Text(
                'Instructor Notes',
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.amber.withOpacity(0.3)),
                ),
                child: Text(
                  lesson.instructorNotes!,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.amber.shade900,
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
