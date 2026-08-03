import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../data/models/courses_models.dart';
import '../cubit/courses_cubit.dart';
import '../cubit/courses_state.dart';
import '../widgets/courses_list_shimmer.dart';
import '../widgets/modern_course_card.dart';

/// Standalone screen listing only the teacher's own courses, using the
/// redesigned [ModernCourseCard] visual style.
class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CoursesCubit>()..loadCourses(),
      child: const _MyCoursesView(),
    );
  }
}

class _MyCoursesView extends StatelessWidget {
  const _MyCoursesView();

  Future<void> _openCourse(BuildContext context, CourseModel course) async {
    await Navigator.pushNamed(
      context,
      AppRouteNames.courseDetails,
      arguments: course.name,
    );
    if (context.mounted) {
      context.read<CoursesCubit>().loadCourses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.myCoursesTitle)),
      body: SafeArea(
        child: BlocBuilder<CoursesCubit, CoursesState>(
          builder: (context, state) {
            if (state.isInitialLoading && state.myCourses == null) {
              return const CoursesListShimmer();
            }

            final courses = state.myCourses ?? const [];

            if (courses.isEmpty) {
              return RefreshIndicator(
                onRefresh: context.read<CoursesCubit>().refreshCourses,
                child: _EmptyMyCourses(
                  message: state.errorMessage ?? context.l10n.myCoursesEmpty,
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: context.read<CoursesCubit>().refreshCourses,
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return ModernCourseCard(
                    course: course,
                    canManage: true,
                    onTap: () => _openCourse(context, course),
                    onChanged: () => context.read<CoursesCubit>().loadCourses(),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EmptyMyCourses extends StatelessWidget {
  const _EmptyMyCourses({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: EdgeInsets.all(24.r),
      children: [
        SizedBox(height: 120.h),
        Icon(
          Icons.menu_book_outlined,
          size: 64.r,
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
        ),
        SizedBox(height: 16.h),
        Text(
          message,
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
