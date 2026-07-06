import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:init/utils/extensions/string_extensions.dart';

void main() {
  group('StringExt.toColor', () {
    test('parses 6-digit hex with hash', () {
      expect('#FF5733'.toColor, const Color(0xFFFF5733));
    });

    test('parses 6-digit hex without hash', () {
      expect('FF5733'.toColor, const Color(0xFFFF5733));
    });

    test('parses 8-digit hex with alpha (RRGGBBAA)', () {
      expect('#FF573380'.toColor, const Color(0x80FF5733));
    });

    test('returns null for invalid hex', () {
      expect('GGGGGG'.toColor, isNull);
    });

    test('returns null for malformed length', () {
      expect('FFF'.toColor, isNull);
    });
  });
}
