import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/adaptive_layout_extension.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/navigation/lms_adaptive_navigation_shell.dart';
import '../../../../core/widgets/navigation/lms_navigation_item.dart';
import 'home_screen.dart';
import '../../../classes/presentation/screens/classes_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final items = LmsNavigationDefaults.items(context);

    return LmsAdaptiveNavigationShell(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      items: items,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreen(embedded: true),
          const ClassesScreen(),
          _PlaceholderTab(
            title: items[2].label,
            message: context.l10n.navStudentsPlaceholder,
            icon: items[2].activeIcon,
          ),
          _PlaceholderTab(
            title: items[3].label,
            message: context.l10n.navMessagesPlaceholder,
            icon: items[3].activeIcon,
          ),
          _PlaceholderTab(
            title: items[4].label,
            message: context.l10n.navSchedulePlaceholder,
            icon: items[4].activeIcon,
          ),
        ],
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({
    required this.title,
    required this.message,
    required this.icon,
  });

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bodyContent = SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsetsDirectional.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Icon(icon, color: colorScheme.primary, size: 30.r),
              ),
              SizedBox(height: 18.h),
              Text(
                title,
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                message,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    if (context.isMediumLayout) {
      return bodyContent;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: bodyContent,
    );
  }
}
