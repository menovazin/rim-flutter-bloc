import 'package:json_annotation/json_annotation.dart';

part 'episode_dto.g.dart';

@JsonSerializable()
class EpisodeDto {
  final int? id;
  final String? name;
  final String? episode;
  @JsonKey(name: 'air_date')
  final String? airDate;
  final List<String>? characters;

  const EpisodeDto({
    this.id,
    this.name,
    this.episode,
    this.airDate,
    this.characters,
  });

  factory EpisodeDto.fromJson(Map<String, dynamic> json) =>
      _$EpisodeDtoFromJson(json);
}
