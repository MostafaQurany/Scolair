import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../courses/data/models/courses_models.dart';
import '../../../homework/data/models/homework_models.dart';
import '../../../quiz/data/models/quiz_models.dart';
import '../cubit/question_bank_state.dart';
import 'question_type_label.dart';

class QuestionFilterBar extends StatefulWidget {
  const QuestionFilterBar({
    required this.state,
    required this.searchController,
    required this.onSearchChanged,
    required this.onClearSearch,
    required this.onTypeChanged,
    required this.onCourseChanged,
    required this.onChapterChanged,
    required this.onLessonChanged,
    required this.onQuizChanged,
    required this.onHomeworkChanged,
    required this.onClearFilters,
    super.key,
  });

  final QuestionBankState state;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final ValueChanged<ApiQuestionType?> onTypeChanged;
  final ValueChanged<String?> onCourseChanged;
  final ValueChanged<String?> onChapterChanged;
  final ValueChanged<String?> onLessonChanged;
  final ValueChanged<String?> onQuizChanged;
  final ValueChanged<String?> onHomeworkChanged;
  final VoidCallback onClearFilters;

  @override
  State<QuestionFilterBar> createState() => _QuestionFilterBarState();
}

class _QuestionFilterBarState extends State<QuestionFilterBar> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double fieldWidth = constraints.maxWidth * 0.4;

        final hasActiveFilters = widget.state.filters.hasActiveFilters;

        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Field + Toggle Action Row
              Container(
                decoration: !_isExpanded
                    ? null
                    : BoxDecoration(
                        border: BorderDirectional(
                          start: BorderSide(
                            color: colorScheme.primary,
                            width: 1,
                          ),
                          end: BorderSide(color: colorScheme.primary, width: 1),
                          top: BorderSide(color: colorScheme.primary, width: 1),
                        ),
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(12.r),
                          topEnd: Radius.circular(12.r),
                        ),
                      ),
                padding: _isExpanded ? EdgeInsetsDirectional.all(8.w) : null,
                child: Row(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: widget.searchController,
                        builder: (context, value, _) {
                          return SizedBox(
                            height: 48.h,
                            child: TextField(
                              controller: widget.searchController,
                              onChanged: widget.onSearchChanged,
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                hintText: context.l10n.search,
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: value.text.isEmpty
                                    ? null
                                    : IconButton(
                                        onPressed: widget.onClearSearch,
                                        icon: const Icon(Icons.clear),
                                      ),
                                filled: true,
                                fillColor: colorScheme.surfaceContainerLow,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: colorScheme.outlineVariant,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: colorScheme.outlineVariant,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Expandable Trigger Button
                    SizedBox(
                      height: 48.h,
                      width: 48.w,
                      child: IconButton.filledTonal(
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor: hasActiveFilters || _isExpanded
                              ? colorScheme.primaryContainer
                              : colorScheme.surfaceContainerLow,
                          foregroundColor: hasActiveFilters || _isExpanded
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurfaceVariant,
                        ),
                        icon: Icon(
                          _isExpanded
                              ? Icons.filter_alt
                              : Icons.filter_alt_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Animated Smooth Slide Down Expansion Panel
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.fastOutSlowIn,
                child: _isExpanded
                    ? Container(
                        decoration: BoxDecoration(
                          border: BorderDirectional(
                            start: BorderSide(
                              color: colorScheme.primary,
                              width: 1,
                            ),
                            end: BorderSide(
                              color: colorScheme.primary,
                              width: 1,
                            ),
                            bottom: BorderSide(
                              color: colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(12.r),
                            bottomEnd: Radius.circular(12.r),
                          ),
                        ),
                        padding: EdgeInsetsDirectional.all(8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: [
                                SizedBox(
                                  width: fieldWidth,
                                  height: 52.h,
                                  child: _TypeDropdown(
                                    value: widget.state.filters.type,
                                    onChanged: widget.onTypeChanged,
                                  ),
                                ),
                                SizedBox(
                                  width: fieldWidth,
                                  height: 52.h,
                                  child: _NamedDropdown<CourseModel>(
                                    label: context.l10n.courseTitleLabel,
                                    value: widget.state.filters.course,
                                    items: widget.state.courses,
                                    itemValue: (course) => course.name,
                                    itemLabel: (course) => course.title,
                                    onChanged: widget.onCourseChanged,
                                  ),
                                ),
                                SizedBox(
                                  width: fieldWidth,
                                  height: 52.h,
                                  child: _NamedDropdown<ChapterSummaryModel>(
                                    label: context.l10n.chapterTitleLabel,
                                    value: widget.state.filters.chapter,
                                    items: widget.state.chapters,
                                    itemValue: (chapter) => chapter.name,
                                    itemLabel: (chapter) => chapter.title,
                                    onChanged: widget.onChapterChanged,
                                  ),
                                ),
                                SizedBox(
                                  width: fieldWidth,
                                  height: 52.h,
                                  child: _NamedDropdown<LessonSummaryModel>(
                                    label: context.l10n.lessonTitleLabel,
                                    value: widget.state.filters.lesson,
                                    items: widget.state.lessons,
                                    itemValue: (lesson) => lesson.name,
                                    itemLabel: (lesson) => lesson.title,
                                    onChanged: widget.onLessonChanged,
                                  ),
                                ),
                                SizedBox(
                                  width: fieldWidth,
                                  height: 52.h,
                                  child: _NamedDropdown<QuizSummaryModel>(
                                    label: context.l10n.quizTitleLabel,
                                    value: widget.state.filters.quiz,
                                    items: widget.state.quizzes,
                                    itemValue: (quiz) => quiz.name,
                                    itemLabel: (quiz) => quiz.title,
                                    onChanged: widget.onQuizChanged,
                                  ),
                                ),
                                SizedBox(
                                  width: fieldWidth,
                                  height: 52.h,
                                  child: _NamedDropdown<HomeworkModel>(
                                    label: context.l10n.homeworkTitleLabel,
                                    value: widget.state.filters.homework,
                                    items: widget.state.homework,
                                    itemValue: (homework) => homework.id,
                                    itemLabel: (homework) => homework.title,
                                    onChanged: widget.onHomeworkChanged,
                                  ),
                                ),
                              ],
                            ),
                            if (hasActiveFilters) ...[
                              SizedBox(height: 4.h),
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: TextButton.icon(
                                  onPressed: widget.onClearFilters,
                                  icon: const Icon(
                                    Icons.filter_alt_off_outlined,
                                  ),
                                  label: Text(
                                    context.l10n.questionBankClearFilters,
                                  ),
                                  style: TextButton.styleFrom(
                                    foregroundColor: colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TypeDropdown extends StatelessWidget {
  const _TypeDropdown({required this.value, required this.onChanged});

  final ApiQuestionType? value;
  final ValueChanged<ApiQuestionType?> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DropdownButtonFormField<ApiQuestionType?>(
      initialValue: value,
      icon: Icon(Icons.arrow_drop_down, color: colorScheme.primary),
      decoration: InputDecoration(
        labelText: context.l10n.questionBankFilterType,
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      isExpanded: true,
      items: [
        DropdownMenuItem<ApiQuestionType?>(
          child: Text(
            context.l10n.questionBankFilterAll,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        ...ApiQuestionType.values.map(
          (type) => DropdownMenuItem<ApiQuestionType?>(
            value: type,
            child: Text(type.label(context), overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}

class _NamedDropdown<T> extends StatelessWidget {
  const _NamedDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.itemValue,
    required this.itemLabel,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<T> items;
  final String Function(T item) itemValue;
  final String Function(T item) itemLabel;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DropdownButtonFormField<String?>(
      initialValue: value,
      icon: Icon(Icons.arrow_drop_down, color: colorScheme.primary),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      isExpanded: true,
      items: [
        DropdownMenuItem<String?>(
          child: Text(context.l10n.questionBankFilterAll),
        ),
        ...items.map(
          (item) => DropdownMenuItem<String?>(
            value: itemValue(item),
            child: Text(itemLabel(item), overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
