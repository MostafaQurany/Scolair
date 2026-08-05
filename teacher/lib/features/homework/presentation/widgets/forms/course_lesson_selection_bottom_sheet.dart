import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../courses/data/models/courses_models.dart';
import '../../../../courses/domain/usecases/courses_usecases.dart';

typedef CourseLessonSelectionResult = ({
  String course,
  String courseTitle,
  String lesson,
  String lessonTitle,
});

class CourseLessonSelectionBottomSheet extends StatefulWidget {
  const CourseLessonSelectionBottomSheet({super.key});

  @override
  State<CourseLessonSelectionBottomSheet> createState() =>
      _CourseLessonSelectionBottomSheetState();
}

class _CourseLessonSelectionBottomSheetState
    extends State<CourseLessonSelectionBottomSheet> {
  int _step = 0; // 0: Course, 1: Chapter, 2: Lesson
  CourseModel? _selectedCourse;
  ChapterSummaryModel? _selectedChapter;

  bool _loading = true;
  String? _error;

  List<CourseModel> _courses = [];
  List<ChapterSummaryModel> _chapters = [];
  List<LessonSummaryModel> _lessons = [];

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final res = await getIt<GetMyCoursesUseCase>()();
    if (!mounted) return;
    switch (res) {
      case ApiSuccess(data: final data):
        setState(() {
          _courses = data.courses;
          _loading = false;
        });
      case ApiFailure(error: final error):
        setState(() {
          _error = error.message;
          _loading = false;
        });
    }
  }

  Future<void> _loadChapters() async {
    if (_selectedCourse == null) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    final res = await getIt<GetChaptersUseCase>()(_selectedCourse!.name);
    if (!mounted) return;
    switch (res) {
      case ApiSuccess(data: final data):
        setState(() {
          _chapters = data.items;
          _loading = false;
        });
      case ApiFailure(error: final error):
        setState(() {
          _error = error.message;
          _loading = false;
        });
    }
  }

  Future<void> _loadLessons() async {
    if (_selectedChapter == null) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    final res = await getIt<GetLessonsUseCase>()(_selectedChapter!.name);
    if (!mounted) return;
    switch (res) {
      case ApiSuccess(data: final data):
        setState(() {
          _lessons = data.items;
          _loading = false;
        });
      case ApiFailure(error: final error):
        setState(() {
          _error = error.message;
          _loading = false;
        });
    }
  }

  void _selectCourse(CourseModel course) {
    _selectedCourse = course;
    _step = 1;
    _loadChapters();
  }

  void _selectChapter(ChapterSummaryModel chapter) {
    _selectedChapter = chapter;
    _step = 2;
    _loadLessons();
  }

  void _selectLesson(LessonSummaryModel lesson) {
    if (_selectedCourse == null) return;
    final result = (
      course: _selectedCourse!.name,
      courseTitle: _selectedCourse!.title,
      lesson: lesson.name,
      lessonTitle: lesson.title,
    );
    Navigator.of(context).pop(result);
  }

  void _goBack() {
    if (_step == 2) {
      setState(() {
        _step = 1;
        _lessons = [];
      });
      _loadChapters();
    } else if (_step == 1) {
      setState(() {
        _step = 0;
        _chapters = [];
      });
      _loadCourses();
    }
  }

  String _getTitle(BuildContext context) {
    switch (_step) {
      case 0:
        return context.l10n.coursesMyCoursesTab;
      case 1:
        return _selectedCourse?.title ?? 'Chapters';
      case 2:
        return _selectedChapter?.title ?? 'Lessons';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 550.h,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: colors.outlineVariant,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                if (_step > 0)
                  IconButton(
                    onPressed: _goBack,
                    icon: const Icon(Icons.arrow_back),
                    tooltip: 'Back',
                  )
                else
                  SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getTitle(context),
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (_step == 1)
                        Text(
                          'Select Chapter',
                          style: textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        )
                      else if (_step == 2)
                        Text(
                          'Select Lesson',
                          style: textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  tooltip: 'Close',
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(child: _buildBody(context)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48.r, color: colors.error),
              SizedBox(height: 12.h),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.error),
              ),
              SizedBox(height: 16.h),
              ElevatedButton.icon(
                onPressed: () {
                  if (_step == 0) _loadCourses();
                  if (_step == 1) _loadChapters();
                  if (_step == 2) _loadLessons();
                },
                icon: const Icon(Icons.refresh),
                label: Text(context.l10n.retry),
              ),
            ],
          ),
        ),
      );
    }

    if (_step == 0) {
      if (_courses.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Text(
              context.l10n.coursesNoMyCoursesMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ),
        );
      }
      return ListView.separated(
        padding: EdgeInsets.all(16.r),
        itemCount: _courses.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final course = _courses[index];
          return _buildTile(
            context,
            icon: Icons.school_outlined,
            title: course.title,
            subtitle: context.l10n.coursesLessonsCount(course.lessons ?? 0),
            onTap: () => _selectCourse(course),
          );
        },
      );
    } else if (_step == 1) {
      if (_chapters.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Text(
              'No chapters found in this course.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ),
        );
      }
      return ListView.separated(
        padding: EdgeInsets.all(16.r),
        itemCount: _chapters.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final chapter = _chapters[index];
          return _buildTile(
            context,
            icon: Icons.folder_outlined,
            title: chapter.title,
            onTap: () => _selectChapter(chapter),
          );
        },
      );
    } else {
      if (_lessons.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Text(
              'No lessons found in this chapter.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ),
        );
      }
      return ListView.separated(
        padding: EdgeInsets.all(16.r),
        itemCount: _lessons.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final lesson = _lessons[index];
          return _buildTile(
            context,
            icon: Icons.menu_book_outlined,
            title: lesson.title,
            isLastStep: true,
            onTap: () => _selectLesson(lesson),
          );
        },
      );
    }
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap, String? subtitle,
    bool isLastStep = false,
  }) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          border: Border.all(color: colors.outlineVariant),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: colors.primaryContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: colors.primary, size: 22.r),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              isLastStep ? Icons.check_circle_outline : Icons.arrow_forward_ios,
              color: isLastStep ? colors.primary : colors.onSurfaceVariant,
              size: 16.r,
            ),
          ],
        ),
      ),
    );
  }
}
