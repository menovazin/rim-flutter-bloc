import '../api/constants/api_constants.dart';

/// Url substitution util for Rick and Morty avatars.
class AvatarUrlUtils {
  const AvatarUrlUtils._();

  static String getCustomAvatarUrl(String originalUrl) {

    if (originalUrl.startsWith('/')) {
      return '${ApiConstants.baseUrl}$originalUrl';
    }

    return originalUrl;
  }

  static String avatarUrlFromId(int id) => '${ApiConstants.baseUrl}/character/avatar/$id.jpeg';
}
