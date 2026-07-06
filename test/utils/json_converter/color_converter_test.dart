import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:init/utils/json_converter/color_converter.dart';

void main() {
  group('ColorConverter', () {
    const converter = ColorConverter();

    test('fromJson converts hex string to Color', () {
      expect(converter.fromJson('#FF5733'), const Color(0xFFFF5733));
    });

    test('fromJson returns null for null input', () {
      expect(converter.fromJson(null), isNull);
    });

    test('toJson converts Color to hex string', () {
      expect(converter.toJson(const Color(0xFFFF5733)), '#FF5733');
    });

    test('toJson returns null for null input', () {
      expect(converter.toJson(null), isNull);
    });
  });
}
