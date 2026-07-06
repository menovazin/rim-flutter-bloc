import 'package:flutter_test/flutter_test.dart';
import 'package:init/utils/json_converter/api_errors_converter.dart';

void main() {
  group('ApiErrorsConverter', () {
    const converter = ApiErrorsConverter();

    test('fromJson joins map values with newlines', () {
      expect(
        converter.fromJson({'a': 'Error A', 'b': 'Error B'}),
        'Error A\nError B',
      );
    });

    test('fromJson joins list items with newlines', () {
      expect(
        converter.fromJson(['Error A', 'Error B']),
        'Error A\nError B',
      );
    });

    test('fromJson converts scalar to string', () {
      expect(converter.fromJson(42), '42');
    });

    test('toJson wraps string in list', () {
      expect(converter.toJson('Error'), ['Error']);
    });
  });
}
