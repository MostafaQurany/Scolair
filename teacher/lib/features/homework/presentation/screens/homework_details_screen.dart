import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/utils/app_date_time_formatter.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/entities/homework_detail.dart';
import '../cubit/details/homework_details_cubit.dart';
import '../cubit/details/homework_details_state.dart';
import '../cubit/submissions/homework_submissions_cubit.dart';
import '../widgets/details/homework_submissions_view.dart';
import '../widgets/forms/course_lesson_selection_bottom_sheet.dart';
import 'homework_questions_slider_screen_args.dart';

class HomeworkDetailsScreen extends StatefulWidget {
  const HomeworkDetailsScreen({required this.homeworkName, super.key});

  final String homeworkName;

  @override
  State<HomeworkDetailsScreen> createState() => _HomeworkDetailsScreenState();
}

class _HomeworkDetailsScreenState extends State<HomeworkDetailsScreen> {
  // Edit mode controllers
  late TextEditingController _titleController;
  late TextEditingController _instructionsController;
  DateTime? _selectedDueDate;
  String? _selectedCourse;
  String? _selectedLesson;
  bool _allowLate = false;
  bool _controllersInitialized = false;

  @override
  void dispose() {
    if (_controllersInitialized) {
      _titleController.dispose();
      _instructionsController.dispose();
    }
    super.dispose();
  }

  void _initControllers(HomeworkDetail homework) {
    if (!_controllersInitialized) {
      _titleController = TextEditingController(text: homework.title);
      _instructionsController = TextEditingController(text: homework.instructions);
      _controllersInitialized = true;
    } else {
      _titleController.text = homework.title;
      _instructionsController.text = homework.instructions;
    }
    _selectedDueDate = homework.dueDate;
    _selectedCourse = homework.course;
    _selectedLesson = homework.lesson;
    _allowLate = homework.allowLateSubmission;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HomeworkDetailsCubit>()..loadHomework(widget.homeworkName)),
        BlocProvider(create: (_) => getIt<HomeworkSubmissionsCubit>()),
      ],
      child: BlocConsumer<HomeworkDetailsCubit, HomeworkDetailsState>(
        listener: (context, state) {
          if (state.status == HomeworkDetailsStatus.failure && state.errorMessage != null) {
            AppSnackBar.showError(context, state.errorMessage!);
          } else if (state.status == HomeworkDetailsStatus.success && !state.isEditMode && state.homework != null) {
            _initControllers(state.homework!);
          }
        },
        builder: (context, state) {
          final homework = state.homework;
          if (homework != null && !_controllersInitialized) {
            _initControllers(homework);
          }

          final isMutating = state.status == HomeworkDetailsStatus.mutating;

          return Scaffold(
            appBar: AppBar(
              title: Text(homework?.title ?? context.l10n.homeworkViewDetails),
              elevation: 0,
              actions: [
                if (homework != null && !state.isEditMode) ...[
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    tooltip: context.l10n.homeworkEditMode,
                    onPressed: () {
                      _initControllers(homework);
                      context.read<HomeworkDetailsCubit>().enterEditMode();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
                    tooltip: context.l10n.delete,
                    onPressed: () => _onDelete(context, context.read<HomeworkDetailsCubit>()),
                  ),
                ],
              ],
            ),
            body: state.status == HomeworkDetailsStatus.loading && homework == null
                ? const Center(child: CircularProgressIndicator())
                : homework == null
                    ? Center(child: Text(state.errorMessage ?? context.l10n.errorOccurred))
                    : SingleChildScrollView(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildStatusBanner(context, homework),
                            SizedBox(height: 16.h),
                            if (state.isEditMode)
                              _buildEditCard(context, homework, isMutating)
                            else
                              _buildReadCard(context, homework),
                            SizedBox(height: 16.h),
                            _buildQuestionsNavCard(context, homework),
                            SizedBox(height: 12.h),
                            _buildSubmissionsNavCard(context, homework),
                            SizedBox(height: 24.h),
                            if (!state.isEditMode) _buildPublishActions(context, homework, isMutating),
                          ],
                        ),
                      ),
          );
        },
      ),
    );
  }

  Widget _buildStatusBanner(BuildContext context, HomeworkDetail homework) {
    final colors = Theme.of(context).colorScheme;
    final isPublished = homework.isPublished;

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isPublished ? colors.primaryContainer.withValues(alpha: 0.2) : colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: isPublished ? colors.primary : colors.outline),
      ),
      child: Row(
        children: [
          Icon(
            isPublished ? Icons.check_circle_outline : Icons.drafts_outlined,
            color: isPublished ? colors.primary : colors.onSurfaceVariant,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              isPublished ? context.l10n.homeworkPublished : context.l10n.homeworkDraft,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isPublished ? colors.primary : colors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadCard(BuildContext context, HomeworkDetail homework) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoRow(context, Icons.title, context.l10n.homeworkTitleLabel, homework.title),
            Divider(height: 24.h),
            _buildInfoRow(context, Icons.book_outlined, context.l10n.quizCourseLabel, homework.course),
            if (homework.lesson != null) ...[
              Divider(height: 24.h),
              _buildInfoRow(context, Icons.menu_book_outlined, context.l10n.courseLesson, homework.lesson!),
            ],
            if (homework.batch != null) ...[
              Divider(height: 24.h),
              _buildInfoRow(context, Icons.group_outlined, context.l10n.classesTitle, homework.batch!),
            ],
            Divider(height: 24.h),
            _buildInfoRow(
              context,
              Icons.calendar_today_outlined,
              context.l10n.homeworkDueDate,
              homework.dueDate != null
                  ? AppDateTimeFormatter.formatDate(homework.dueDate!, locale: context.l10n.localeName)
                  : context.l10n.homeworkNoDueDate,
            ),
            Divider(height: 24.h),
            _buildInfoRow(
              context,
              Icons.star_outline,
              context.l10n.homeworkMaxMarksLabel,
              '${homework.maxMarks}',
            ),
            Divider(height: 24.h),
            _buildInfoRow(
              context,
              Icons.timer_off_outlined,
              context.l10n.homeworkAllowLate,
              homework.allowLateSubmission ? context.l10n.yes : context.l10n.no,
            ),
            Divider(height: 24.h),
            Text(context.l10n.homeworkInstructions, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
            SizedBox(height: 8.h),
            Text(
              homework.instructions.isNotEmpty ? homework.instructions : '—',
              style: textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditCard(BuildContext context, HomeworkDetail homework, bool isMutating) {
    final colors = Theme.of(context).colorScheme;
    final cubit = context.read<HomeworkDetailsCubit>();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colors.primary, width: 1.5),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: context.l10n.homeworkTitleLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),
            InkWell(
              onTap: isMutating
                  ? null
                  : () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDueDate ?? DateTime.now().add(const Duration(days: 7)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null && mounted) {
                        setState(() => _selectedDueDate = date);
                      }
                    },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: context.l10n.homeworkDueDate,
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.calendar_today_outlined),
                ),
                child: Text(
                  _selectedDueDate != null
                      ? AppDateTimeFormatter.formatDate(_selectedDueDate!, locale: context.l10n.localeName)
                      : context.l10n.homeworkSelectDate,
                  style: TextStyle(color: _selectedDueDate != null ? colors.onSurface : colors.onSurfaceVariant),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            InkWell(
              onTap: isMutating
                  ? null
                  : () async {
                      final result = await showModalBottomSheet<CourseLessonSelectionResult>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const CourseLessonSelectionBottomSheet(),
                      );
                      if (result != null && mounted) {
                        setState(() {
                          _selectedCourse = result.course;
                          _selectedLesson = result.lesson;
                        });
                      }
                    },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: '${context.l10n.coursesMyCoursesTab} / ${context.l10n.courseLesson}',
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
                child: Text(
                  _selectedCourse != null ? '$_selectedCourse ${_selectedLesson != null ? "• $_selectedLesson" : ""}' : 'Select Course & Lesson',
                  style: TextStyle(color: _selectedCourse != null ? colors.onSurface : colors.onSurfaceVariant),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _instructionsController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: context.l10n.homeworkInstructions,
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(context.l10n.homeworkAllowLate),
              value: _allowLate,
              onChanged: isMutating ? null : (val) => setState(() => _allowLate = val),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isMutating ? null : () => cubit.cancelEditMode(),
                    child: Text(context.l10n.homeworkCancelEdit),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: isMutating
                        ? null
                        : () {
                            cubit.saveEditedFields(
                              title: _titleController.text.trim(),
                              dueDate: _selectedDueDate,
                              course: _selectedCourse,
                              lesson: _selectedLesson,
                              instructions: _instructionsController.text.trim(),
                              allowLateSubmission: _allowLate,
                            );
                          },
                    child: isMutating
                        ? SizedBox(width: 20.w, height: 20.h, child: const CircularProgressIndicator(strokeWidth: 2))
                        : Text(context.l10n.homeworkSaveChanges),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value, {Color? valueColor}) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 20.r, color: colors.primary),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(label, style: textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant)),
        ),
        Text(value, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: valueColor ?? colors.onSurface)),
      ],
    );
  }

  Widget _buildQuestionsNavCard(BuildContext context, HomeworkDetail homework) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final count = homework.questions.length;
    final totalMarks = homework.questions.fold<int>(0, (sum, q) => sum + q.marks);

    return Card(
      elevation: 0,
      color: colors.primaryContainer.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colors.primary.withValues(alpha: 0.3)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRouteNames.homeworkQuestionsSlider,
            arguments: HomeworkQuestionsSliderScreenArgs(
              cubit: context.read<HomeworkDetailsCubit>(),
              homework: homework,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.help_outline, color: colors.onPrimary, size: 24.r),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.homeworkManageQuestions,
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${context.l10n.homeworkQuestionsCount(count)} • $totalMarks ${context.l10n.marks}',
                      style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.r, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmissionsNavCard(BuildContext context, HomeworkDetail homework) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: colors.secondaryContainer.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colors.secondary.withValues(alpha: 0.3)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<HomeworkSubmissionsCubit>(),
                child: Scaffold(
                  appBar: AppBar(title: Text(context.l10n.homeworkSubmissionsTab)),
                  body: HomeworkSubmissionsView(homeworkName: widget.homeworkName),
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.assignment_turned_in_outlined, color: colors.onSecondary, size: 24.r),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.homeworkViewSubmissions,
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.l10n.homeworkSubmissionsTab,
                      style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.r, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPublishActions(BuildContext context, HomeworkDetail homework, bool isMutating) {
    final cubit = context.read<HomeworkDetailsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!homework.isPublished)
          FilledButton.icon(
            onPressed: isMutating ? null : () => cubit.publishHomework(),
            icon: const Icon(Icons.publish),
            label: Text(context.l10n.homeworkPublish),
          )
        else
          OutlinedButton.icon(
            onPressed: isMutating ? null : () => cubit.unpublishHomework(),
            icon: const Icon(Icons.unpublished_outlined),
            label: Text(context.l10n.homeworkUnpublish),
          ),
      ],
    );
  }

  Future<void> _onDelete(BuildContext context, HomeworkDetailsCubit cubit) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.delete),
        content: Text(context.l10n.homeworkDeleteConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(context.l10n.cancel)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(context.l10n.delete, style: TextStyle(color: Theme.of(context).colorScheme.onError)),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      final success = await cubit.deleteHomework();
      if (success && context.mounted) {
        Navigator.of(context).pop(true);
      }
    }
  }
}
