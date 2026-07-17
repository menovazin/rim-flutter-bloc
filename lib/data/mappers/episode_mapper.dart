import '../../domain/entities/episode.dart';
import '../api/dto/episode_dto.dart';

/// Maps episode DTOs from Rick & Morty REST API to [Episode] domain entities.
class EpisodeMapper {
  static Episode fromDto(EpisodeDto dto) {
    final characters = dto.characters ?? const <String>[];

    return Episode(
      id: dto.id ?? 0,
      name: dto.name ?? '',
      episodeCode: dto.episode ?? '',
      airDate: dto.airDate ?? '',
      characterIds: characters
          .map((e) => int.tryParse(e.split('/').last) ?? 0)
          .where((id) => id > 0)
          .toList(),
    );
  }

  static List<Episode> fromDtoList(List<EpisodeDto> list) =>
      list.map(fromDto).toList();
}
