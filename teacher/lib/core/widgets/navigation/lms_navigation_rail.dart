import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'lms_navigation_item.dart';

class LmsNavigationRail extends StatelessWidget {
  const LmsNavigationRail({
    required this.currentIndex,
    required this.onTap,
    required this.extended,
    this.items,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool extended;
  final List<LmsNavigationItem>? items;

  @override
  Widget build(BuildContext context) {
    final resolvedItems = items ?? LmsNavigationDefaults.items(context);
    final colorScheme = Theme.of(context).colorScheme;
    final railWidth = extended ? 212.w : 88.w;

    return SafeArea(
      right: false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        width: railWidth,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: BorderDirectional(
            end: BorderSide(color: colorScheme.outlineVariant),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12.w, 16.h, 12.w, 16.h),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              for (var index = 0; index < resolvedItems.length; index++) ...[
                _RailNavItem(
                  item: resolvedItems[index],
                  selected: currentIndex == index,
                  extended: extended,
                  onTap: () => onTap(index),
                ),
                SizedBox(height: 8.h),
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RailNavItem extends StatelessWidget {
  const _RailNavItem({
    required this.item,
    required this.selected,
    required this.extended,
    required this.onTap,
  });

  static const _duration = Duration(milliseconds: 200);
  static const _curve = Curves.easeOutCubic;

  final LmsNavigationItem item;
  final bool selected;
  final bool extended;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final foreground = selected
        ? colorScheme.onPrimary
        : colorScheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: AnimatedContainer(
          duration: _duration,
          curve: _curve,
          constraints: BoxConstraints(minHeight: 54.h),
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: extended ? 14.w : 8.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            color: selected ? colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: extended
              ? Row(
                  children: [
                    _RailIcon(
                      item: item,
                      selected: selected,
                      color: foreground,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _RailLabel(
                        label: item.label,
                        selected: selected,
                        color: foreground,
                        style: textTheme.labelMedium,
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _RailIcon(
                      item: item,
                      selected: selected,
                      color: foreground,
                    ),
                    SizedBox(height: 5.h),
                    _RailLabel(
                      label: item.label,
                      selected: selected,
                      color: foreground,
                      style: textTheme.labelSmall,
                      centered: true,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _RailIcon extends StatelessWidget {
  const _RailIcon({
    required this.item,
    required this.selected,
    required this.color,
  });

  static const _duration = Duration(milliseconds: 200);
  static const _popCurve = Curves.easeOutBack;

  final LmsNavigationItem item;
  final bool selected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedScale(
          scale: selected ? 1.16 : 1,
          duration: _duration,
          curve: _popCurve,
          child: AnimatedSwitcher(
            duration: _duration,
            switchInCurve: _popCurve,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Icon(
              selected ? item.activeIcon : item.icon,
              key: ValueKey(selected ? item.activeIcon : item.icon),
              color: color,
              size: 23.r,
            ),
          ),
        ),
        PositionedDirectional(
          top: -1.h,
          end: -3.w,
          child: AnimatedOpacity(
            opacity: selected ? 0 : 1,
            duration: _duration,
            curve: Curves.easeOutCubic,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.tertiary,
                shape: BoxShape.circle,
              ),
              child: SizedBox(width: 6.r, height: 6.r),
            ),
          ),
        ),
      ],
    );
  }
}

class _RailLabel extends StatelessWidget {
  const _RailLabel({
    required this.label,
    required this.selected,
    required this.color,
    required this.style,
    this.centered = false,
  });

  static const _duration = Duration(milliseconds: 200);
  static const _popCurve = Curves.easeOutBack;

  final String label;
  final bool selected;
  final Color color;
  final TextStyle? style;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: _duration,
      curve: _popCurve,
      offset: selected ? Offset(0, -0.08.h) : Offset.zero,
      child: AnimatedDefaultTextStyle(
        duration: _duration,
        curve: _popCurve,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: centered ? TextAlign.center : TextAlign.start,
        style: (style ?? const TextStyle()).copyWith(
          color: color,
          fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
        ),
        child: Text(label),
      ),
    );
  }
}
