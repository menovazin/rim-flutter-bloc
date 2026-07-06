import 'package:flutter_test/flutter_test.dart';
import 'package:init/utils/extensions/collection_extensions.dart';

void main() {
  group('SeparatedIterable', () {
    test('separated inserts separator between elements', () {
      expect(
        [1, 2, 3].separated(0).toList(),
        [1, 0, 2, 0, 3],
      );
    });

    test('separated returns single element unchanged', () {
      expect([1].separated(0).toList(), [1]);
    });

    test('separated returns empty for empty iterable', () {
      expect(<int>[].separated(0).toList(), isEmpty);
    });
  });

  group('MapExt.safe', () {
    test('removes null, empty strings, and sentinel numbers', () {
      final map = {
        'a': 'value',
        'b': '',
        'c': null,
        'd': 0,
        'e': -1,
        'f': 42,
      };

      expect(map.safe, {'a': 'value', 'f': 42});
    });

    test('recursively cleans nested maps', () {
      final map = {
        'outer': {
          'keep': 'value',
          'remove': null,
        },
      };

      expect(map.safe, {
        'outer': {'keep': 'value'},
      });
    });
  });
}
