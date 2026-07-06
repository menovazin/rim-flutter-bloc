import 'package:flutter_test/flutter_test.dart';
import 'package:init/utils/avatar_url_utils.dart';

void main() {
  group('AvatarUrlUtils', () {
    test('getCustomAvatarUrl replaces original base with custom base', () {
      const original =
          'https://rickandmortyapi.com/api/character/avatar/1.jpeg';

      expect(
        AvatarUrlUtils.getCustomAvatarUrl(original),
        'https://semester.syazy.com/rickandmorty/1.jpeg',
      );
    });

    test('getCustomAvatarUrl returns unknown URL unchanged', () {
      const url = 'https://example.com/avatar.png';

      expect(AvatarUrlUtils.getCustomAvatarUrl(url), url);
    });

    test('getCustomAvatarUrl handles empty string', () {
      expect(AvatarUrlUtils.getCustomAvatarUrl(''), '');
    });

    test('avatarUrlFromId returns custom URL with id', () {
      expect(
        AvatarUrlUtils.avatarUrlFromId(42),
        'https://semester.syazy.com/rickandmorty/42.jpeg',
      );
    });
  });
}
