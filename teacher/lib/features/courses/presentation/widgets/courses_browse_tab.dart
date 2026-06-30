import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/extensions/adaptive_layout_extension.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/storage/app_shared_preferences.dart';
import '../../data/models/courses_models.dart';
import '../cubit/courses_cubit.dart';
import '../cubit/courses_state.dart';
import '../utils/course_permission_helper.dart';
import 'course_card.dart';

class BrowseCoursesTab extends StatelessWidget {
  const BrowseCoursesTab({
    required this.state,
    required this.searchController,
    required this.onSearchChanged,
    required this.onClearSearch,
    this.onCourseTapped,
    this.onCourseChanged,
    super.key,
  });

  final CoursesState state;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final ValueChanged<CourseModel>? onCourseTapped;
  final VoidCallback? onCourseChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CoursesFilters(
          state: state,
          searchController: searchController,
          onSearchChanged: onSearchChanged,
          onClearSearch: onClearSearch,
        ),
        if (state.isFiltering) const LinearProgressIndicator(minHeight: 2),
        if (state.errorMessage != null)
          InlineCoursesError(message: state.errorMessage!),
        Expanded(
          child: CoursesRefreshList(
            courses: state.allCourses ?? const [],
            isMyCourses: false,
            hasActiveBrowseFilters:
                state.searchText.trim().isNotEmpty ||
                state.publishedFilter != null,
            onRefresh: context.read<CoursesCubit>().refreshCourses,
            onCourseTapped: onCourseTapped,
            onCourseChanged: onCourseChanged,
          ),
        ),
      ],
    );
  }
}

class CoursesFilters extends StatelessWidget {
  const CoursesFilters({
    required this.state,
    required this.searchController,
    required this.onSearchChanged,
    required this.onClearSearch,
    super.key,
  });

  final CoursesState state;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.isTabletLayout ? 32.w : 20.w;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        12.h,
        horizontalPadding,
        8.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: searchController,
            builder: (context, value, _) {
              return TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: context.l10n.coursesSearchHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: value.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: onClearSearch,
                        )
                      : null,
                ),
              );
            },
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              PublishedFilterChip(
                label: context.l10n.coursesFilterAll,
                selected: state.publishedFilter == null,
                value: null,
              ),
              PublishedFilterChip(
                label: context.l10n.coursesFilterPublished,
                selected: state.publishedFilter == true,
                value: true,
              ),
              PublishedFilterChip(
                label: context.l10n.coursesFilterUnpublished,
                selected: state.publishedFilter == false,
                value: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PublishedFilterChip extends StatelessWidget {
  const PublishedFilterChip({
    required this.label,
    required this.selected,
    required this.value,
    super.key,
  });

  final String label;
  final bool selected;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => context.read<CoursesCubit>().filterByPublished(value),
    );
  }
}

class CoursesRefreshList extends StatelessWidget {
  const CoursesRefreshList({
    required this.courses,
    required this.isMyCourses,
    required this.onRefresh,
    this.hasActiveBrowseFilters = false,
    this.onCourseTapped,
    this.onCourseChanged,
    super.key,
  });

  final List<CourseModel> courses;
  final bool isMyCourses;
  final bool hasActiveBrowseFilters;
  final Future<void> Function() onRefresh;
  final ValueChanged<CourseModel>? onCourseTapped;
  final VoidCallback? onCourseChanged;

  @override
  Widget build(BuildContext context) {
    final prefs = getIt<AppSharedPreferences>();

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: courses.isEmpty
          ? CoursesEmptyState(
              isMyCourses: isMyCourses,
              hasActiveBrowseFilters: hasActiveBrowseFilters,
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: context.isTabletLayout ? 32.w : 20.w,
                vertical: 8.h,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                final canManage = CoursePermissionHelper.canManageCourse(
                  course,
                  prefs,
                );
                return CourseCard(
                  course: course,
                  canManage: canManage,
                  onTap: onCourseTapped != null
                      ? () => onCourseTapped!(course)
                      : null,
                  onDeleted: onCourseChanged,
                  onEdited: onCourseChanged,
                );
              },
            ),
    );
  }
}

class CoursesEmptyState extends StatelessWidget {
  const CoursesEmptyState({
    required this.isMyCourses,
    required this.hasActiveBrowseFilters,
    super.key,
  });

  final bool isMyCourses;
  final bool hasActiveBrowseFilters;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final message = hasActiveBrowseFilters
        ? context.l10n.coursesNoMatchesMessage
        : isMyCourses
        ? context.l10n.coursesNoMyCoursesMessage
        : context.l10n.coursesNoBrowseCoursesMessage;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 96.h),
        Icon(Icons.menu_book, size: 64.r, color: colorScheme.outlineVariant),
        SizedBox(height: 16.h),
        Text(
          context.l10n.coursesNoCoursesTitle,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class CoursesErrorState extends StatelessWidget {
  const CoursesErrorState({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            FilledButton(
              onPressed: context.read<CoursesCubit>().loadCourses,
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}

class InlineCoursesError extends StatelessWidget {
  const InlineCoursesError({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
