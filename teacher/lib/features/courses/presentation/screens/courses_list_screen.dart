import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/courses_models.dart';
import '../cubit/courses_cubit.dart';
import '../cubit/courses_state.dart';
import 'course_details_screen.dart';

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

class _CoursesListViewState extends State<_CoursesListView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.navClasses),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: colorScheme.primary,
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.onSurfaceVariant,
          tabs: const [
            Tab(text: 'My Courses'),
            Tab(text: 'Browse All'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search courses...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        )
                      : null,
                  filled: true,
                  fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<CoursesCubit, CoursesState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.errorMessage != null) {
                    return Center(
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
                            onPressed: () => context.read<CoursesCubit>().loadCourses(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _buildCourseList(state.myCourses ?? [], isMyCourses: true),
                      _buildCourseList(state.allCourses ?? [], isMyCourses: false),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseList(List<CourseModel> courses, {required bool isMyCourses}) {
    final filteredCourses = courses.where((course) {
      final matchesSearch = course.title.toLowerCase().contains(_searchQuery) ||
          (course.shortIntroduction?.toLowerCase().contains(_searchQuery) ?? false);
      return matchesSearch;
    }).toList();

    if (filteredCourses.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book,
                size: 64.r,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              SizedBox(height: 16.h),
              Text(
                'No courses found',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 4.h),
              Text(
                _searchQuery.isNotEmpty
                    ? 'Try searching for a different keyword'
                    : isMyCourses
                        ? "You aren't enrolled or teaching any courses yet"
                        : 'Check back later for new courses',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        final course = filteredCourses[index];
        return _CourseCard(course: course);
      },
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Gradient based on card_gradient metadata
    final isRed = course.cardGradient?.toLowerCase() == 'red';
    final cardGrad = isRed
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
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailsScreen(courseName: course.name),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner representation (either image or colored gradient)
            Container(
              height: 120.h,
              decoration: BoxDecoration(
                gradient: course.image == null ? cardGrad : null,
                image: course.image != null
                    ? DecorationImage(
                        image: NetworkImage('https://dev.scolair.site${course.image!}'),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Stack(
                children: [
                  // Dark overlay for text readability
                  Container(color: Colors.black.withOpacity(0.15)),
                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: _getStatusColor(course.status).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        course.status ?? 'Active',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (course.category != null)
                    Positioned(
                      bottom: 12.h,
                      left: 12.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          course.category!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Details
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (course.shortIntroduction != null) ...[
                    SizedBox(height: 6.h),
                    Text(
                      course.shortIntroduction!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: 12.h),
                  const Divider(),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoTile(
                        icon: Icons.list,
                        label: '${course.lessons ?? 0} lessons',
                      ),
                      _buildInfoTile(
                        icon: Icons.people,
                        label: '${course.enrollments ?? 0} enrolled',
                      ),
                      _buildInfoTile(
                        icon: Icons.star,
                        label: _formatRating(course.rating),
                        iconColor: Colors.amber,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    Color? iconColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16.r, color: iconColor ?? AppColors.neutral),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.neutral,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return AppColors.success;
      case 'in progress':
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }

  String _formatRating(dynamic rating) {
    if (rating == null) return '0.0';
    if (rating is num) return rating.toStringAsFixed(1);
    if (rating is String) {
      final parsed = double.tryParse(rating);
      if (parsed != null) return parsed.toStringAsFixed(1);
      return rating;
    }
    return '0.0';
  }
}
