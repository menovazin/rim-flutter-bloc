abstract class ApiConstants {
  static const host = 'alpha.syazy.com:1180';
  static const baseUrl = 'https://$host/api';
  static const refreshEndpoint = '$baseUrl/auth/refresh';

  static const characterEndpoint = '$baseUrl/character';
  static const episodeEndpoint = '$baseUrl/episode';
  static const locationEndpoint = '$baseUrl/location';

  // Relative paths (Dio is configured with [baseUrl] already).
  static const characterPath = '/character';
  static const episodePath = '/episode';
  static const locationPath = '/location';
}
