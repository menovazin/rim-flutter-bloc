import 'package:flutter_test/flutter_test.dart';
import 'package:init/api/constants/api_constants.dart';
import 'package:init/utils/avatar_url_utils.dart';

void main() {
  group('AvatarUrlUtils', () {
    test('getCustomAvatarUrl prepends baseUrl for relative paths', () {
      const relative = '/api/character/avatar/1.jpeg';

      expect(
        AvatarUrlUtils.getCustomAvatarUrl(relative),
        '${ApiConstants.baseUrl}$relative',
      );
    });

    test('getCustomAvatarUrl returns absolute URL unchanged', () {
      const url = 'https://rickandmortyapi.com/api/character/avatar/1.jpeg';

      expect(AvatarUrlUtils.getCustomAvatarUrl(url), url);
    });

    test('getCustomAvatarUrl returns empty string unchanged', () {
      expect(AvatarUrlUtils.getCustomAvatarUrl(''), '');
    });

    test('avatarUrlFromId returns URL based on ApiConstants.baseUrl', () {
      expect(
        AvatarUrlUtils.avatarUrlFromId(42),
        '${ApiConstants.baseUrl}/character/avatar/42.jpeg',
      );
    });
  });
}
