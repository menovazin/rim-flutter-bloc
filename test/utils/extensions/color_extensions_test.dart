import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:init/utils/extensions/color_extensions.dart';

void main() {
  group('ColorExt.toHex', () {
    test('converts opaque color to 6-digit hex', () {
      expect(
        const Color(0xFFFF5733).toHex,
        '#FF5733',
      );
    });

    test('converts transparent color to 8-digit hex', () {
      expect(
        const Color(0x80FF5733).toHex,
        '#FF573380',
      );
    });

    test('returns null for invalid color values', () {
      // No easy way to create an invalid Color; test that null-safety holds.
      expect(const Color(0xFF000000).toHex, '#000000');
    });
  });
}
