import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../cubit/course_students_cubit.dart';
import '../cubit/course_students_state.dart';
import '../widgets/add_email_dialog.dart';
import '../widgets/forms/delete_confirmation_dialog.dart';
import '../widgets/student_list_item.dart';

class CourseStudentsScreenArgs {
  const CourseStudentsScreenArgs({
    required this.courseName,
    required this.courseTitle,
  });

  final String courseName;
  final String courseTitle;
}

class CourseStudentsScreen extends StatelessWidget {
  const CourseStudentsScreen({
    required this.courseName,
    required this.courseTitle,
    super.key,
  });

  final String courseName;
  final String courseTitle;

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) =>
          getIt<CourseStudentsCubit>()..loadStudents(courseName),
      child: _CourseStudentsView(courseTitle: courseTitle),
    );
}

class _CourseStudentsView extends StatelessWidget {
  const _CourseStudentsView({required this.courseTitle});

  final String courseTitle;

  void _onAddStudent(BuildContext context) {
    AddEmailDialog.show(
      context: context,
      title: 'Add Student to Course',
      hintText: 'Student Email',
      onAdd: (email) {
        context.read<CourseStudentsCubit>().addStudent(email);
      },
    );
  }

  Future<void> _onRemoveStudent(
    BuildContext context,
    String email,
    String name,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: 'Remove Student',
        body: 'Are you sure you want to remove "$name" ($email) from this course?',
      ),
    );

    if ((confirm ?? false) && context.mounted) {
      context.read<CourseStudentsCubit>().removeStudent(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: theme.colorScheme.primary),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enrolled Students'),
            Text(
              courseTitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_outlined),
            onPressed: () => _onAddStudent(context),
            tooltip: 'Add Student',
          ),
        ],
      ),
      body: BlocConsumer<CourseStudentsCubit, CourseStudentsState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            AppSnackBar.showError(context, state.errorMessage!);
          } else if (state.successMessage != null) {
            AppSnackBar.showSuccess(context, state.successMessage!);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.students.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64.r,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No students enrolled yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton.icon(
                    onPressed: () => _onAddStudent(context),
                    icon: const Icon(Icons.person_add_outlined),
                    label: const Text('Add Student'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => context
                .read<CourseStudentsCubit>()
                .loadStudents(state.courseName ?? ''),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                final student = state.students[index];
                return StudentListItem(
                  student: student,
                  onRemove: () => _onRemoveStudent(
                    context,
                    student.member ?? student.name,
                    student.memberName ??
                        student.memberUsername ??
                        student.member ??
                        student.name,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
