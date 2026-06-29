import '../../domain/entities/episode.dart';

/// Maps JSON responses from Rick & Morty REST API to [Episode] domain entities.
class EpisodeMapper {
  static Episode fromJson(Map<String, dynamic> json) {
    final characters = (json['characters'] as List?) ?? [];

    return Episode(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      episodeCode: json['episode'] as String? ?? '',
      airDate: json['air_date'] as String? ?? '',
      characterIds: characters
          .map((e) => int.tryParse(e.toString().split('/').last) ?? 0)
          .where((id) => id > 0)
          .toList(),
    );
  }

  static List<Episode> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
