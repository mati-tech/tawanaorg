import 'package:flutter/material.dart';

class Breakpoints {
  static const mobile = 600.0;
  static const tablet = 900.0;
  static const desktop = 1200.0;
  static const largeDesktop = 1600.0;
}

extension ResponsiveContext on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  bool get isMobile => width < Breakpoints.mobile;
  bool get isTablet => width >= Breakpoints.mobile && width < Breakpoints.tablet;
  bool get isDesktop => width >= Breakpoints.tablet;
  bool get isLargeDesktop => width >= Breakpoints.largeDesktop;

  double get hPad {
    if (isMobile) return 16;
    if (isTablet) return 32;
    return 48;
  }

  double get maxContentWidth => 1280;

  /// Column count for card grids.
  int gridCols({int mobile = 1, int tablet = 2, int desktop = 3}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }
}