import 'package:json_annotation/json_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable()
class LocationDto {
  final int? id;
  final String? name;
  final String? type;
  final String? dimension;
  final List<String>? residents;

  const LocationDto({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.residents,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
}
