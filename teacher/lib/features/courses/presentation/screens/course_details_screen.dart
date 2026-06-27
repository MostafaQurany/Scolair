import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/courses_models.dart';
import '../cubit/course_details_cubit.dart';
import '../cubit/course_details_state.dart';
import 'lesson_details_screen.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({required this.courseName, super.key});

  final String courseName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CourseDetailsCubit>()..loadCourseDetails(courseName),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Course Details'),
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
                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  FilledButton(
                    onPressed: () {
                      final courseName = state.course?.name;
                      if (courseName != null) {
                        context.read<CourseDetailsCubit>().loadCourseDetails(courseName);
                      }
                    },
                    child: const Text('Retry'),
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
            _buildCourseHeader(context, course),
            SizedBox(height: 20.h),
            _buildInstructors(context, course.instructors ?? []),
            SizedBox(height: 24.h),
            Text(
              'Course Outline',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            if (state.chapters == null || state.chapters!.isEmpty)
              _buildEmptyOutline(context)
            else
              ...state.chapters!.map((chapter) => _buildChapterTile(context, chapter)),
          ],
        );
      },
    );
  }

  Widget _buildCourseHeader(BuildContext context, CourseModel course) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final isRed = course.cardGradient?.toLowerCase() == 'red';
    final headerGrad = isRed
        ? const LinearGradient(
            colors: [Color(0xFFE52D27), Color(0xFFB31217)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [colorScheme.primary, colorScheme.primary.withRed(150)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140.h,
            decoration: BoxDecoration(
              gradient: course.image == null ? headerGrad : null,
              image: course.image != null
                  ? DecorationImage(
                      image: NetworkImage('https://dev.scolair.site${course.image!}'),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (course.category != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      course.category!,
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
                Text(
                  course.title,
                  style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (course.shortIntroduction != null) ...[
                  SizedBox(height: 10.h),
                  Text(
                    course.shortIntroduction!,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(Icons.video_library, size: 18.r, color: AppColors.neutral),
                    SizedBox(width: 6.w),
                    Text(
                      '${course.lessons ?? 0} total lessons',
                      style: TextStyle(fontSize: 13.sp, color: AppColors.neutral),
                    ),
                    SizedBox(width: 16.w),
                    Icon(Icons.people_outline, size: 18.r, color: AppColors.neutral),
                    SizedBox(width: 6.w),
                    Text(
                      '${course.enrollments ?? 0} active students',
                      style: TextStyle(fontSize: 13.sp, color: AppColors.neutral),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructors(BuildContext context, List<InstructorModel> instructors) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (instructors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructors',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        Row(
          children: instructors.map((instructor) {
            final hasImg = instructor.userImage != null;
            return Container(
              margin: EdgeInsets.only(right: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: colorScheme.primaryContainer,
                    backgroundImage: hasImg
                        ? NetworkImage('https://dev.scolair.site${instructor.userImage!}')
                        : null,
                    child: !hasImg
                        ? Icon(Icons.person, color: colorScheme.primary, size: 16.r)
                        : null,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    instructor.fullName,
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
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
            'No chapters or lessons listed for this course yet.',
            style: TextStyle(color: AppColors.neutral, fontSize: 13.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildChapterTile(BuildContext context, ChapterDetailModel chapter) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colorScheme.outlineVariant),
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
            '${chapter.lessons.length} lessons',
            style: TextStyle(color: AppColors.neutral, fontSize: 12.sp),
          ),
          childrenPadding: EdgeInsets.zero,
          children: [
            const Divider(height: 1),
            ...chapter.lessons.map((lesson) => _buildLessonItem(context, lesson, chapter.name)),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonItem(BuildContext context, LessonSummaryModel lesson, String chapterName) {
    final textTheme = Theme.of(context).textTheme;

    // Resolve lesson icon based on its type or icon name
    IconData icon = Icons.description;
    Color iconColor = AppColors.neutral;

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

    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20.r),
      ),
      title: Text(
        lesson.title,
        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 12),
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
    );
  }
}
