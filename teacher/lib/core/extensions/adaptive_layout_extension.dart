import 'package:flutter/widgets.dart';

abstract final class AdaptiveLayoutBreakpoints {
  static const double compact = 600;
  static const double expanded = 840;
}

extension AdaptiveLayoutExtension on BuildContext {
  double get adaptiveWidth => MediaQuery.sizeOf(this).width;

  bool get isCompactLayout => adaptiveWidth < AdaptiveLayoutBreakpoints.compact;

  bool get isMediumLayout =>
      adaptiveWidth >= AdaptiveLayoutBreakpoints.compact &&
      adaptiveWidth < AdaptiveLayoutBreakpoints.expanded;

  bool get isExpandedLayout =>
      adaptiveWidth >= AdaptiveLayoutBreakpoints.expanded;

  bool get isMobileLayout => isCompactLayout;

  bool get isTabletLayout => !isCompactLayout;
}
