import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../domain/entities/teacher_feed_filter.dart';

class TeacherFeedFilterList extends StatelessWidget {
  const TeacherFeedFilterList({
    required this.filters,
    required this.selectedFilterId,
    required this.onFilterSelected,
    super.key,
  });

  final List<TeacherFeedFilter> filters;
  final String selectedFilterId;
  final ValueChanged<String> onFilterSelected;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        itemCount: filters.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter.id == selectedFilterId;

          final label = filter.id == 'all'
              ? context.l10n.homeFeedFilterAll
              : filter.label;

          return TeacherFeedFilterChip(
            label: label,
            isSelected: isSelected,
            onTap: () => onFilterSelected(filter.id),
          );
        },
      ),
    );
}

class TeacherFeedFilterChip extends StatelessWidget {
  const TeacherFeedFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      selected: isSelected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.primary : colorScheme.surface,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: 1.r,
            ),
          ),
          child: Text(
            label,
            style: textTheme.labelLarge?.copyWith(
              color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    );
  }
}
