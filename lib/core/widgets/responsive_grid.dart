import 'package:flutter/material.dart';
import '../../app/theme/app_spacing.dart';

/// Card grid whose rows size to their content.
///
/// Replaces `GridView` + fixed `childAspectRatio`, which clipped cards and
/// produced "BOTTOM OVERFLOWED" stripes whenever a translation, a narrow
/// viewport or a larger text scale made a card taller than the fixed ratio
/// allowed. Cards in the same row are stretched to equal height.
class ResponsiveGrid extends StatelessWidget {
  final int columns;
  final List<Widget> children;
  final double spacing;
  final double runSpacing;

  const ResponsiveGrid({
    super.key,
    required this.columns,
    required this.children,
    this.spacing = AppSpacing.md,
    this.runSpacing = AppSpacing.md,
  });

  @override
  Widget build(BuildContext context) {
    final cols = columns < 1 ? 1 : columns;
    final rows = <Widget>[];
    for (var start = 0; start < children.length; start += cols) {
      final cells = <Widget>[];
      for (var c = 0; c < cols; c++) {
        if (c > 0) cells.add(SizedBox(width: spacing));
        final index = start + c;
        cells.add(Expanded(
          child: index < children.length
              ? children[index]
              : const SizedBox.shrink(),
        ));
      }
      if (rows.isNotEmpty) rows.add(SizedBox(height: runSpacing));
      rows.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: cells,
        ),
      ));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}
