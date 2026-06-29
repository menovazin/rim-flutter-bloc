import 'package:flutter/widgets.dart';

/// Helpers for the adaptive catalog grid.
abstract class GridUtils {
  /// Target width (logical px) of a single grid tile.
  static const double tileTargetWidth = 200;

  /// Minimum number of columns.
  static const int minColumns = 1;

  /// Maximum number of columns (caps stretching on very wide screens).
  static const int maxColumns = 6;

  /// Computes the number of grid columns for the given screen [width].
  ///
  /// `width ~/ 200`, clamped to [minColumns]..[maxColumns].
  static int crossAxisCount(double width) {
    final raw = width ~/ tileTargetWidth;
    return raw.clamp(minColumns, maxColumns);
  }
}

extension GridContextX on BuildContext {
  /// Adaptive grid column count based on the current screen width.
  int get gridCrossAxisCount =>
      GridUtils.crossAxisCount(MediaQuery.sizeOf(this).width);
}
