import 'package:flutter/material.dart';

import '../../../../core/localization/localization_extension.dart';

class HomeworkStatusTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  const HomeworkStatusTabBar({
    required this.publishedCount,
    required this.draftCount,
    required this.scheduledCount,
    super.key,
  });

  final int publishedCount;
  final int draftCount;
  final int scheduledCount;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(text: context.l10n.homeworkTabPublished(publishedCount)),
        Tab(text: context.l10n.homeworkTabDrafts(draftCount)),
        Tab(text: context.l10n.homeworkTabScheduled(scheduledCount)),
      ],
    );
  }
}
