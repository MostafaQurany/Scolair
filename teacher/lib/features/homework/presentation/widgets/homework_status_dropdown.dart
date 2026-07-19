import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/list_homeworks_request_data.dart';

class HomeworkStatusDropdown extends StatefulWidget {
  const HomeworkStatusDropdown({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final HomeworkPublishedFilter value;
  final ValueChanged<HomeworkPublishedFilter> onChanged;

  @override
  State<HomeworkStatusDropdown> createState() => _HomeworkStatusDropdownState();
}

class _HomeworkStatusDropdownState extends State<HomeworkStatusDropdown> {
  bool _isExpanded = false;

  String _filterLabel(BuildContext context) => switch (widget.value) {
    HomeworkPublishedFilter.all => context.l10n.homeworkFilterAll,
    HomeworkPublishedFilter.published => context.l10n.homeworkFilterPublished,
    HomeworkPublishedFilter.drafts => context.l10n.homeworkFilterDrafts,
  };

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final hasActiveFilter = widget.value != HomeworkPublishedFilter.all;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: !_isExpanded ? null : EdgeInsetsDirectional.all(8.r),
          decoration:
          !_isExpanded ? null : BoxDecoration(
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
                child: Container(
                  height: 48.h,
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                  alignment: AlignmentDirectional.centerStart,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: colors.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        size: 20.r,
                        color: colors.onSurfaceVariant,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          _filterLabel(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
                  padding: EdgeInsetsDirectional.all(8.r),
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
                  child: Wrap(
                    spacing: 2.w,
                    runSpacing: 10.h,
                    children: [
                      _StatusFilterCard(
                        label: context.l10n.homeworkFilterAll,
                        icon: Icons.view_list_outlined,
                        selected: widget.value == HomeworkPublishedFilter.all,
                        onTap: () => _select(HomeworkPublishedFilter.all),
                      ),
                      _StatusFilterCard(
                        label: context.l10n.homeworkFilterPublished,
                        icon: Icons.publish_outlined,
                        selected:
                            widget.value == HomeworkPublishedFilter.published,
                        onTap: () => _select(HomeworkPublishedFilter.published),
                      ),
                      _StatusFilterCard(
                        label: context.l10n.homeworkFilterDrafts,
                        icon: Icons.drafts_outlined,
                        selected:
                            widget.value == HomeworkPublishedFilter.drafts,
                        onTap: () => _select(HomeworkPublishedFilter.drafts),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  void _select(HomeworkPublishedFilter filter) {
    widget.onChanged(filter);
    setState(() => _isExpanded = false);
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
