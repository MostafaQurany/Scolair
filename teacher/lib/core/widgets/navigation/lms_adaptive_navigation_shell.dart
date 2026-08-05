import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../extensions/adaptive_layout_extension.dart';
import 'lms_bottom_nav_bar.dart';
import 'lms_navigation_item.dart';
import 'lms_tablet_navigation_drawer.dart';

class LmsAdaptiveNavigationShell extends StatelessWidget {
  const LmsAdaptiveNavigationShell({
    required this.currentIndex,
    required this.onTap,
    required this.body,
    this.items,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final Widget body;
  final List<LmsNavigationItem>? items;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < AdaptiveLayoutBreakpoints.compact) {
          return Scaffold(
            body: body,
            bottomNavigationBar: LmsBottomNavBar(
              currentIndex: currentIndex,
              onTap: onTap,
              items: items,
            ),
          );
        }

        final resolvedItems = items ?? LmsNavigationDefaults.items(context);

        if (constraints.maxWidth < AdaptiveLayoutBreakpoints.expanded) {
          final activeIndex =
              currentIndex >= 0 && currentIndex < resolvedItems.length
              ? currentIndex
              : 0;
          return Scaffold(
            appBar: AppBar(title: Text(resolvedItems[activeIndex].label)),
            drawer: Builder(
              builder: (drawerContext) => LmsTabletNavigationDrawer(
                  currentIndex: currentIndex,
                  onTap: (index) {
                    onTap(index);
                    Scaffold.of(drawerContext).closeDrawer();
                  },
                  items: resolvedItems,
                ),
            ),
            body: body,
          );
        }

        final drawerWidth = 304.w;
        return Scaffold(
          body: Row(
            children: [
              SizedBox(
                width: drawerWidth,
                child: LmsTabletNavigationDrawer(
                  currentIndex: currentIndex,
                  onTap: onTap,
                  items: resolvedItems,
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              Expanded(child: body),
            ],
          ),
        );
      },
    );
}
