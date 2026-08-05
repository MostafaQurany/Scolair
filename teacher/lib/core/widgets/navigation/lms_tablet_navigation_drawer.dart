import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'lms_navigation_item.dart';

class LmsTabletNavigationDrawer extends StatelessWidget {
  const LmsTabletNavigationDrawer({
    required this.currentIndex, required this.onTap, required this.items, super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<LmsNavigationItem> items;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final selectedIndex = currentIndex >= 0 && currentIndex < items.length
        ? currentIndex
        : null;

    return SafeArea(
      child: NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: onTap,
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primary,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.w, 24.h, 24.w, 16.h),
            child: Text(
              'Scolair Teacher',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          for (final item in items)
            NavigationDrawerDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.activeIcon),
              label: Text(item.label),
            ),
        ],
      ),
    );
  }
}
