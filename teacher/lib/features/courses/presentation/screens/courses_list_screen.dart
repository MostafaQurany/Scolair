import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/storage/app_shared_preferences.dart';
import '../../data/models/courses_models.dart';
import '../cubit/courses_cubit.dart';
import '../cubit/courses_state.dart';
import '../widgets/courses_browse_tab.dart';
import '../widgets/courses_list_shimmer.dart';

class CoursesListScreen extends StatelessWidget {
  const CoursesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CoursesCubit>()..loadCourses(),
      child: const _CoursesListView(),
    );
  }
}

class _CoursesListView extends StatefulWidget {
  const _CoursesListView();

  @override
  State<_CoursesListView> createState() => _CoursesListViewState();
}

class _CoursesListViewState extends State<_CoursesListView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      context.read<CoursesCubit>().searchCourses(value);
    });
  }

  void _clearSearch() {
    _searchDebounce?.cancel();
    _searchController.clear();
    context.read<CoursesCubit>().searchCourses('');
  }

  Future<void> _navigateToCourseDetails(CourseModel course) async {
    final deletedOrUpdated = await Navigator.pushNamed(
      context,
      AppRouteNames.courseDetails,
      arguments: course.name,
    );
    if (deletedOrUpdated == true && mounted) {
      context.read<CoursesCubit>().loadCourses();
    }
  }

  Future<void> _createNewCourse() async {
    final created = await Navigator.pushNamed(
      context,
      AppRouteNames.courseForm,
    );
    if (created == true && mounted) {
      context.read<CoursesCubit>().loadCourses();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.navClasses),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: colorScheme.primary,
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.onSurfaceVariant,
          tabs: [
            Tab(text: context.l10n.coursesMyCoursesTab),
            Tab(text: context.l10n.coursesBrowseAllTab),
          ],
        ),
      ),
      floatingActionButton: getIt<AppSharedPreferences>().isCourseCreator
          ? FloatingActionButton(
              onPressed: _createNewCourse,
              child: const Icon(Icons.add),
            )
          : null,
      body: SafeArea(
        child: BlocBuilder<CoursesCubit, CoursesState>(
          builder: (context, state) {
            if (state.isInitialLoading && state.allCourses == null) {
              return const CoursesListShimmer();
            }

            if (state.errorMessage != null &&
                (state.allCourses == null || state.myCourses == null)) {
              return CoursesErrorState(message: state.errorMessage!);
            }

            return TabBarView(
              controller: _tabController,
              children: [
                CoursesRefreshList(
                  courses: state.myCourses ?? const [],
                  isMyCourses: true,
                  onRefresh: context.read<CoursesCubit>().refreshCourses,
                  onCourseTapped: _navigateToCourseDetails,
                  onCourseChanged: () =>
                      context.read<CoursesCubit>().loadCourses(),
                ),
                BrowseCoursesTab(
                  state: state,
                  searchController: _searchController,
                  onSearchChanged: _onSearchChanged,
                  onClearSearch: _clearSearch,
                  onCourseTapped: _navigateToCourseDetails,
                  onCourseChanged: () =>
                      context.read<CoursesCubit>().loadCourses(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
