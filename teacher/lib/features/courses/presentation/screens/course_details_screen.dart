import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/storage/app_shared_preferences.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/usecases/courses_usecases.dart';

import '../cubit/course_details_cubit.dart';
import '../cubit/course_details_state.dart';
import '../screens/chapter_form_screen.dart';
import '../screens/course_form_screen.dart';
import '../screens/course_students_screen.dart';
import '../widgets/add_email_dialog.dart';
import '../widgets/course_details/chapter_expansion_tile.dart';
import '../widgets/course_details/course_header_card.dart';
import '../widgets/course_details/instructors_row.dart';
import '../widgets/forms/delete_confirmation_dialog.dart';
import '../utils/course_permission_helper.dart';

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
      final res = await getIt<DeleteCourseUseCase>().call(name);
      if (context.mounted) {
        res.when(
          success: (_) {
            AppSnackBar.showSuccess(context, context.l10n.courseDeletedSuccess);
            Navigator.pop(context, true);
          },
          failure: (fail) => AppSnackBar.showError(context, fail.message),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => getIt<CourseDetailsCubit>()..loadCourseDetails(courseName),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: theme.colorScheme.primary),
          title: Text(context.l10n.courseDetails),
          actions: [
            BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
              builder: (context, state) {
                final course = state.course;
                if (course == null) return const SizedBox.shrink();
                final canManage = CoursePermissionHelper.canManageCourse(
                  course,
                  getIt<AppSharedPreferences>(),
                );
                if (!canManage) return const SizedBox.shrink();

                return PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'edit') {
                      final updated = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseFormScreen(
                            editingCourse: course,
                          ),
                        ),
                      );
                      if (updated == true && context.mounted) {
                        context.read<CourseDetailsCubit>().loadCourseDetails(courseName);
                      }
                    } else if (value == 'delete') {
                      _deleteCourse(context, course.name);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 'edit', child: Text(context.l10n.editCourse)),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(
                        context.l10n.deleteCourse,
                        style: TextStyle(color: theme.colorScheme.error),
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

class _CourseDetailsView extends StatefulWidget {
  const _CourseDetailsView();

  @override
  State<_CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<_CourseDetailsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      context.read<CourseDetailsCubit>().loadMoreChapters();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
      listener: (context, state) {
        if (state.mutationError != null) {
          AppSnackBar.showError(context, state.mutationError!);
          context.read<CourseDetailsCubit>().clearMutationState();
        } else if (state.mutationSuccess != null) {
          AppSnackBar.showSuccess(context, state.mutationSuccess!);
          context.read<CourseDetailsCubit>().clearMutationState();
        }
      },
      builder: (context, state) {
        if (state.isLoading) return const Center(child: CircularProgressIndicator());
        final course = state.course;
        if (course == null) return const SizedBox.shrink();

        final canManage = CoursePermissionHelper.canManageCourse(
          course,
          getIt<AppSharedPreferences>(),
        );

        return ListView(
          controller: _scrollController,
          padding: EdgeInsets.all(20.r),
          children: [
            CourseHeaderCard(course: course),
            SizedBox(height: 16.h),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseStudentsScreen(
                      courseName: course.name,
                      courseTitle: course.title,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.people_alt_outlined),
              label: const Text('Manage Enrolled Students'),
            ),
            SizedBox(height: 16.h),
            InstructorsRow(
              instructors: course.instructors ?? [],
              onAddInstructor: canManage
                  ? () => AddEmailDialog.show(
                        context: context,
                        title: 'Add Instructor',
                        hintText: 'Instructor Email',
                        onAdd: (email) =>
                            context.read<CourseDetailsCubit>().addInstructor(email),
                      )
                  : null,
              onRemoveInstructor: canManage
                  ? (inst) async {
                      final email = inst.username ?? inst.name;
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (_) => DeleteConfirmationDialog(
                          title: 'Remove Instructor',
                          body: 'Remove "${inst.fullName ?? email}" from course?',
                        ),
                      );
                      if (confirm == true && context.mounted) {
                        context.read<CourseDetailsCubit>().removeInstructor(email);
                      }
                    }
                  : null,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.courseOutline,
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (canManage)
                  TextButton.icon(
                    onPressed: () async {
                      final res = await showDialog<bool>(
                        context: context,
                        builder: (_) => ChapterFormScreen(courseName: course.name),
                      );
                      if (res == true && context.mounted) {
                        context.read<CourseDetailsCubit>().loadCourseDetails(course.name);
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
                (ch) => ChapterExpansionTile(
                  chapter: ch,
                  courseName: course.name,
                  canManageCourse: canManage,
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
