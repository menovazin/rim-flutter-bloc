import '../../domain/entities/character.dart';
import '../../utils/avatar_url_utils.dart';
import '../api/dto/character_dto.dart';

/// Maps character DTOs from Rick & Morty REST API to [Character] domain entities.
class CharacterMapper {
  static Character fromDto(CharacterDto dto) {
    final episodes = dto.episode ?? const <String>[];

    return Character(
      id: dto.id ?? 0,
      name: dto.name ?? '',
      status: dto.status ?? '',
      species: dto.species ?? '',
      type: dto.type ?? '',
      gender: dto.gender ?? '',
      image: AvatarUrlUtils.getCustomAvatarUrl(dto.image ?? ''),
      originName: dto.origin?.name ?? '',
      originUrl: dto.origin?.url ?? '',
      locationName: dto.location?.name ?? '',
      locationUrl: dto.location?.url ?? '',
      episodeIds: episodes
          .map((e) => int.tryParse(e.split('/').last) ?? 0)
          .where((id) => id > 0)
          .toList(),
    );
  }

  static List<Character> fromDtoList(List<CharacterDto> list) =>
      list.map(fromDto).toList();
}
