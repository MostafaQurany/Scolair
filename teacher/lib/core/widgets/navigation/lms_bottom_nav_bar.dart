import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'lms_navigation_item.dart';

class LmsBottomNavBar extends StatelessWidget {
  const LmsBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    this.items,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<LmsNavigationItem>? items;

  @override
  Widget build(BuildContext context) {
    final resolvedItems = items ?? LmsNavigationDefaults.items(context);
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.w, 20.h, 10.w, 20.h),
          child: Row(
            children: [
              for (var index = 0; index < resolvedItems.length; index++)
                Expanded(
                  child: _BottomNavItem(
                    item: resolvedItems[index],
                    selected: currentIndex == index,
                    index: index,
                    onTap: () => onTap(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _BottomNavItem extends StatelessWidget {
//   const _BottomNavItem({
//     required this.item,
//     required this.selected,
//     required this.onTap,
//   });

//   static const _duration = Duration(milliseconds: 200);
//   static const _curve = Curves.easeOutCubic;
//   static const _popCurve = Curves.easeOutBack;

//   final LmsNavigationItem item;
//   final bool selected;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;
//     final foreground = selected
//         ? colorScheme.onPrimary
//         : colorScheme.onSurfaceVariant;

//     return Semantics(
//       button: true,
//       selected: selected,
//       label: item.label,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 3.w),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(18.r),
//           child: AnimatedContainer(
//             duration: _duration,
//             curve: _curve,
//             constraints: BoxConstraints(minHeight: 56.h),
//             padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 7.h),
//             decoration: BoxDecoration(
//               color: selected ? colorScheme.primary : Colors.transparent,
//               borderRadius: BorderRadius.circular(18.r),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     AnimatedScale(
//                       scale: selected ? 1.16 : 1,
//                       duration: _duration,
//                       curve: _popCurve,
//                       child: AnimatedSwitcher(
//                         duration: _duration,
//                         switchInCurve: _popCurve,
//                         switchOutCurve: Curves.easeInCubic,
//                         transitionBuilder: (child, animation) {
//                           return ScaleTransition(
//                             scale: animation,
//                             child: FadeTransition(
//                               opacity: animation,
//                               child: child,
//                             ),
//                           );
//                         },
//                         child: Icon(
//                           selected ? item.activeIcon : item.icon,
//                           key: ValueKey(selected ? item.activeIcon : item.icon),
//                           color: foreground,
//                           size: 22.r,
//                         ),
//                       ),
//                     ),
//                     PositionedDirectional(
//                       top: -1.h,
//                       end: -3.w,
//                       child: AnimatedOpacity(
//                         opacity: selected ? 0 : 1,
//                         duration: _duration,
//                         curve: _curve,
//                         child: DecoratedBox(
//                           decoration: BoxDecoration(
//                             color: colorScheme.tertiary,
//                             shape: BoxShape.circle,
//                           ),
//                           child: SizedBox(width: 6.r, height: 6.r),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 3.h),
//                 AnimatedSlide(
//                   duration: _duration,
//                   curve: _popCurve,
//                   offset: selected ? Offset.zero : const Offset(0, 0.32),
//                   child: AnimatedOpacity(
//                     duration: _duration,
//                     curve: _curve,
//                     opacity: selected ? 1 : 0.86,
//                     child: AnimatedDefaultTextStyle(
//                       duration: _duration,
//                       curve: _popCurve,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.center,
//                       style: (textTheme.labelSmall ?? const TextStyle())
//                           .copyWith(
//                             color: foreground,
//                             fontSize: 10.sp,
//                             fontWeight: selected
//                                 ? FontWeight.w800
//                                 : FontWeight.w700,
//                           ),
//                       child: Text(item.label),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.item,
    required this.selected,
    required this.index,
    required this.onTap,
  });

  static const _duration = Duration(milliseconds: 200); //[cite: 3]
  static const _popCurve = Curves.easeOutBack; //[cite: 3]

  final LmsNavigationItem item;
  final bool selected;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isCenterItem = index == 2;
    final colorScheme = Theme.of(context).colorScheme; //[cite: 3]

    // Set colors using the primary color from your theme
    final activeColor = colorScheme.primary;
    final inactiveColor = colorScheme.primary.withValues(alpha: 0.4);
    final foreground = selected ? activeColor : inactiveColor; //[cite: 3]

    return Semantics(
      button: true, //[cite: 3]
      selected: selected, //[cite: 3]
      label: item.label, //[cite: 3]
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 56.w,
          child: Column(
            mainAxisSize: MainAxisSize.min, //[cite: 3]
            mainAxisAlignment: MainAxisAlignment.center, //[cite: 3]
            children: [
              _buildIcon(foreground),
              SizedBox(height: 4.h), //[cite: 3]
              // Active indicator dot colored with the primary color
              AnimatedOpacity(
                opacity: selected ? 1.0 : 0.0,
                duration: _duration, //[cite: 3]
                child: Container(
                  width: 4.r,
                  height: 4.r,
                  decoration: BoxDecoration(
                    color: activeColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Scaling animations for the icons[cite: 3]
  Widget _buildIcon(Color color) {
    return AnimatedScale(
      scale: selected ? 1.15 : 1, //[cite: 3]
      duration: _duration, //[cite: 3]
      curve: _popCurve, //[cite: 3]
      child: AnimatedSwitcher(
        duration: _duration, //[cite: 3]
        switchInCurve: _popCurve, //[cite: 3]
        switchOutCurve: Curves.easeInCubic, //[cite: 3]
        child: Icon(
          selected ? item.activeIcon : item.icon, //[cite: 3]
          key: ValueKey(selected ? item.activeIcon : item.icon), //[cite: 3]
          color: color, //[cite: 3]
          size: 24.r, //[cite: 3]
        ),
      ),
    );
  }
}
