import 'package:flutter/material.dart';
import '../responsive/responsive.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? context.maxContentWidth,
        ),
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(horizontal: context.hPad),
          child: child,
        ),
      ),
    );
  }
}