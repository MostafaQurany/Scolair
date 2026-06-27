import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class LmsNavigationItem {
  const LmsNavigationItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

abstract final class LmsNavigationDefaults {
  static List<LmsNavigationItem> items(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return <LmsNavigationItem>[
      LmsNavigationItem(
        label: l10n.navHome,
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
      ),
      LmsNavigationItem(
        label: l10n.navClasses,
        icon: Icons.school_outlined,
        activeIcon: Icons.school,
      ),
      LmsNavigationItem(
        label: l10n.navStudents,
        icon: Icons.people_outline,
        activeIcon: Icons.people,
      ),
      LmsNavigationItem(
        label: l10n.navMessages,
        icon: Icons.chat_bubble_outline,
        activeIcon: Icons.chat_bubble,
      ),
      LmsNavigationItem(
        label: l10n.navSchedule,
        icon: Icons.calendar_month_outlined,
        activeIcon: Icons.calendar_month,
      ),
    ];
  }
}
