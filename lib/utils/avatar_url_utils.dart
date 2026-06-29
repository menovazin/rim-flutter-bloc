/// Url substitution util for Rick and Morty avatars.
class AvatarUrlUtils {
  const AvatarUrlUtils._();

  static const _customBase = 'https://semester.syazy.com/rickandmorty';

  static String getCustomAvatarUrl(String originalUrl) {
    const originalBase = 'https://rickandmortyapi.com/api/character/avatar/';

    if (originalUrl.startsWith(originalBase)) {
      return originalUrl.replaceFirst(originalBase, '$_customBase/');
    }

    return originalUrl;
  }

  static String avatarUrlFromId(int id) => '$_customBase/$id.jpeg';
}
