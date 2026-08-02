import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../courses/data/models/courses_models.dart';
import '../../data/models/list_homeworks_request_data.dart';

class HomeworkStatusDropdown extends StatefulWidget {
  const HomeworkStatusDropdown({
    required this.value,
    required this.onChanged,
    required this.searchQuery,
    required this.onSearchQueryChanged,
    required this.selectedCourse,
    required this.selectedChapter,
    required this.selectedLesson,
    required this.courses,
    required this.chapters,
    required this.lessons,
    required this.isLoadingCourses,
    required this.isLoadingChapters,
    required this.isLoadingLessons,
    required this.onCourseSelected,
    required this.onChapterSelected,
    required this.onLessonSelected,
    required this.onClearFilters,
    super.key,
  });

  final HomeworkPublishedFilter value;
  final ValueChanged<HomeworkPublishedFilter> onChanged;
  final String searchQuery;
  final ValueChanged<String> onSearchQueryChanged;
  
  final String? selectedCourse;
  final String? selectedChapter;
  final String? selectedLesson;
  final List<CourseModel> courses;
  final List<ChapterSummaryModel> chapters;
  final List<LessonSummaryModel> lessons;
  final bool isLoadingCourses;
  final bool isLoadingChapters;
  final bool isLoadingLessons;
  final ValueChanged<String?> onCourseSelected;
  final ValueChanged<String?> onChapterSelected;
  final ValueChanged<String?> onLessonSelected;
  final VoidCallback onClearFilters;

  @override
  State<HomeworkStatusDropdown> createState() => _HomeworkStatusDropdownState();
}

class _HomeworkStatusDropdownState extends State<HomeworkStatusDropdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final hasActiveFilter = widget.value != HomeworkPublishedFilter.all || 
                            widget.selectedCourse != null || 
                            widget.selectedChapter != null || 
                            widget.selectedLesson != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: !_isExpanded ? null : EdgeInsetsDirectional.all(8.r),
          decoration: !_isExpanded
              ? null
              : BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  border: Border(
                    top: BorderSide(color: colors.primary),
                    left: BorderSide(color: colors.primary),
                    right: BorderSide(color: colors.primary),
                  ),
                ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: widget.searchQuery,
                  onChanged: widget.onSearchQueryChanged,
                  decoration: InputDecoration(
                    hintText: context.l10n.search,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: colors.surfaceContainerLow,
                    contentPadding: EdgeInsetsDirectional.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: colors.outlineVariant),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: colors.outlineVariant),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                width: 48.w,
                height: 48.h,
                child: IconButton.filledTonal(
                  onPressed: () => setState(() => _isExpanded = !_isExpanded),
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    backgroundColor: hasActiveFilter || _isExpanded
                        ? colors.primaryContainer
                        : colors.surfaceContainerLow,
                    foregroundColor: hasActiveFilter || _isExpanded
                        ? colors.onPrimaryContainer
                        : colors.onSurfaceVariant,
                  ),
                  icon: Icon(
                    _isExpanded ? Icons.filter_alt : Icons.filter_alt_outlined,
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
          child: _isExpanded
              ? Container(
                  padding: EdgeInsetsDirectional.all(12.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r),
                    ),
                    border: Border(
                      bottom: BorderSide(color: colors.primary),
                      left: BorderSide(color: colors.primary),
                      right: BorderSide(color: colors.primary),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        spacing: 15.w,
                        runSpacing: 10.h,
                        children: [
                          _StatusFilterCard(
                            label: context.l10n.homeworkFilterAll,
                            icon: Icons.view_list_outlined,
                            selected: widget.value == HomeworkPublishedFilter.all,
                            onTap: () => widget.onChanged(HomeworkPublishedFilter.all),
                          ),
                          _StatusFilterCard(
                            label: context.l10n.homeworkFilterPublished,
                            icon: Icons.publish_outlined,
                            selected:
                                widget.value == HomeworkPublishedFilter.published,
                            onTap: () => widget.onChanged(HomeworkPublishedFilter.published),
                          ),
                          _StatusFilterCard(
                            label: context.l10n.homeworkFilterDrafts,
                            icon: Icons.drafts_outlined,
                            selected:
                                widget.value == HomeworkPublishedFilter.drafts,
                            onTap: () => widget.onChanged(HomeworkPublishedFilter.drafts),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      
                      _DropdownTrigger(
                        label: 'Course',
                        hint: 'Select Course',
                        selectedTitle: widget.courses.firstWhere(
                          (c) => c.name == widget.selectedCourse,
                          orElse: () => const CourseModel(name: '', title: ''),
                        ).title.isEmpty ? null : widget.courses.firstWhere(
                          (c) => c.name == widget.selectedCourse,
                        ).title,
                        isEnabled: true,
                        isLoading: widget.isLoadingCourses,
                        onTap: () => _showSelectionBottomSheet(
                          context: context,
                          title: 'Select Course',
                          items: widget.courses.map((c) => MapEntry(c.name, c.title)).toList(),
                          selectedValue: widget.selectedCourse,
                          onSelected: widget.onCourseSelected,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      
                      _DropdownTrigger(
                        label: 'Chapter',
                        hint: 'Select Chapter',
                        selectedTitle: widget.chapters.firstWhere(
                          (c) => c.name == widget.selectedChapter,
                          orElse: () => const ChapterSummaryModel(idx: 0, name: '', title: '', isScormPackage: 0, lessonCount: 0),
                        ).title.isEmpty ? null : widget.chapters.firstWhere(
                          (c) => c.name == widget.selectedChapter,
                        ).title,
                        isEnabled: widget.selectedCourse != null,
                        isLoading: widget.isLoadingChapters,
                        onTap: () => _showSelectionBottomSheet(
                          context: context,
                          title: 'Select Chapter',
                          items: widget.chapters.map((c) => MapEntry(c.name, c.title)).toList(),
                          selectedValue: widget.selectedChapter,
                          onSelected: widget.onChapterSelected,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      
                      _DropdownTrigger(
                        label: 'Lesson',
                        hint: 'Select Lesson',
                        selectedTitle: widget.lessons.firstWhere(
                          (c) => c.name == widget.selectedLesson,
                          orElse: () => const LessonSummaryModel(idx: 0, name: '', title: '', includeInPreview: 0, fileType: '', icon: ''),
                        ).title.isEmpty ? null : widget.lessons.firstWhere(
                          (c) => c.name == widget.selectedLesson,
                        ).title,
                        isEnabled: widget.selectedChapter != null,
                        isLoading: widget.isLoadingLessons,
                        onTap: () => _showSelectionBottomSheet(
                          context: context,
                          title: 'Select Lesson',
                          items: widget.lessons.map((c) => MapEntry(c.name, c.title)).toList(),
                          selectedValue: widget.selectedLesson,
                          onSelected: widget.onLessonSelected,
                        ),
                      ),
                      
                      if (hasActiveFilter) ...[
                        SizedBox(height: 16.h),
                        TextButton.icon(
                          onPressed: widget.onClearFilters,
                          icon: const Icon(Icons.clear),
                          label: Text(context.l10n.questionBankClearFilters),
                        ),
                      ],
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  void _showSelectionBottomSheet({
    required BuildContext context,
    required String title,
    required List<MapEntry<String, String>> items,
    required String? selectedValue,
    required ValueChanged<String?> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.9,
          initialChildSize: 0.5,
          builder: (context, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleLarge),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = item.key == selectedValue;
                      return ListTile(
                        title: Text(item.value),
                        trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
                        selected: isSelected,
                        onTap: () {
                          Navigator.pop(context);
                          onSelected(item.key);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _DropdownTrigger extends StatelessWidget {
  const _DropdownTrigger({
    required this.label,
    required this.hint,
    required this.selectedTitle,
    required this.isEnabled,
    required this.isLoading,
    required this.onTap,
  });

  final String label;
  final String hint;
  final String? selectedTitle;
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: isEnabled && !isLoading ? onTap : null,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isEnabled ? colors.surfaceContainerLow : colors.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
                  SizedBox(height: 4.h),
                  if (isLoading)
                    SizedBox(height: 16.h, width: 16.h, child: const CircularProgressIndicator(strokeWidth: 2))
                  else
                    Text(
                      selectedTitle ?? hint,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: selectedTitle != null ? colors.onSurface : colors.onSurfaceVariant,
                        fontWeight: selectedTitle != null ? FontWeight.bold : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Icon(Icons.arrow_drop_down, color: isEnabled ? colors.onSurfaceVariant : colors.outline),
          ],
        ),
      ),
    );
  }
}

class _StatusFilterCard extends StatelessWidget {
  const _StatusFilterCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: selected ? colors.primaryContainer : colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: BorderDirectional(
          bottom: BorderSide(
            color: colors.primary.withValues(alpha: .5),
            width: 1.w,
          ),
          end: BorderSide(
            color: colors.primary.withValues(alpha: .5),
            width: 1.w,
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: selected
                    ? colors.onPrimaryContainer
                    : colors.onSurfaceVariant,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: selected
                      ? colors.onPrimaryContainer
                      : colors.onSurface,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              if (selected)
                Icon(Icons.check_circle, color: colors.primary, size: 22.r),
            ],
          ),
        ),
      ),
    );
  }
}

