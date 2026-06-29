import '../../domain/entities/character.dart';
import '../../utils/avatar_url_utils.dart';

/// Maps JSON responses from Rick & Morty REST API to [Character] domain entities.
class CharacterMapper {
  /// Parses a single character JSON object into a [Character].
  static Character fromJson(Map<String, dynamic> json) {
    final origin = json['origin'] as Map<String, dynamic>? ?? {};
    final location = json['location'] as Map<String, dynamic>? ?? {};
    final episodes = (json['episode'] as List?) ?? [];

    return Character(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      status: json['status'] as String? ?? '',
      species: json['species'] as String? ?? '',
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      image: AvatarUrlUtils.getCustomAvatarUrl(json['image'] as String? ?? ''),
      originName: origin['name'] as String? ?? '',
      originUrl: origin['url'] as String? ?? '',
      locationName: location['name'] as String? ?? '',
      locationUrl: location['url'] as String? ?? '',
      episodeIds: episodes
          .map((e) => int.tryParse(e.toString().split('/').last) ?? 0)
          .where((id) => id > 0)
          .toList(),
    );
  }

  /// Parses a list of character JSON objects into a list of [Character].
  static List<Character> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }
}