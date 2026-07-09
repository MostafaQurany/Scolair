import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';

/// A pill-shaped Material 3 segment bar for filtering homework by status.
///
/// Shows Published, Drafts, and Scheduled counts inline.
class HomeworkSegmentBar extends StatelessWidget {
  const HomeworkSegmentBar({
    required this.selectedIndex,
    required this.publishedCount,
    required this.draftCount,
    required this.scheduledCount,
    required this.onChanged,
    super.key,
  });

  final int selectedIndex;
  final int publishedCount;
  final int draftCount;
  final int scheduledCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 2),
            color: Colors.black12,
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SegmentedButton<int>(
          selected: {selectedIndex},
          onSelectionChanged: (values) => onChanged(values.first),
          showSelectedIcon: false,
          style: SegmentedButton.styleFrom(
            backgroundColor: Colors.transparent,
            selectedBackgroundColor: colorScheme.primary,
            selectedForegroundColor: colorScheme.onPrimary,
            foregroundColor: colorScheme.onSurfaceVariant,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            textStyle: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          segments: [
            _segment(
              context,
              index: 0,
              label: context.l10n.homeworkTabPublished(publishedCount),
              icon: Icons.check_circle_outline,
            ),
            _segment(
              context,
              index: 1,
              label: context.l10n.homeworkTabDrafts(draftCount),
              icon: Icons.edit_note_outlined,
            ),
            _segment(
              context,
              index: 2,
              label: context.l10n.homeworkTabScheduled(scheduledCount),
              icon: Icons.schedule_outlined,
            ),
          ],
        ),
      ),
    );
  }

  ButtonSegment<int> _segment(
    BuildContext context, {
    required int index,
    required String label,
    required IconData icon,
  }) {
    return ButtonSegment<int>(
      value: index,
      label: Text(label, overflow: TextOverflow.ellipsis, maxLines: 1),
      icon: Icon(icon, size: 16.r),
    );
  }
}
