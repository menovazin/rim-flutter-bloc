/// Url substitution util for Rick and Morty avatars.
class AvatarUrlUtils {
  const AvatarUrlUtils._();

  static String getCustomAvatarUrl(String originalUrl) {
    const originalBase = 'https://rickandmortyapi.com/api/character/avatar/';
    const customBase = 'https://semester.syazy.com/rickandmorty/';

    if (originalUrl.startsWith(originalBase)) {
      return originalUrl.replaceFirst(originalBase, customBase);
    }

    return originalUrl;
  }
}