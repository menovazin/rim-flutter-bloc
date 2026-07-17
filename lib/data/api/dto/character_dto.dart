import 'package:json_annotation/json_annotation.dart';

import 'named_ref_dto.dart';

part 'character_dto.g.dart';

@JsonSerializable()
class CharacterDto {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final String? image;
  final NamedRefDto? origin;
  final NamedRefDto? location;
  final List<String>? episode;

  const CharacterDto({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.image,
    this.origin,
    this.location,
    this.episode,
  });

  factory CharacterDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterDtoFromJson(json);
}
