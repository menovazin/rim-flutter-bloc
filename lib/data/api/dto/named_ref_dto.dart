import 'package:json_annotation/json_annotation.dart';

part 'named_ref_dto.g.dart';

@JsonSerializable()
class NamedRefDto {
  final String? name;
  final String? url;

  const NamedRefDto({this.name, this.url});

  factory NamedRefDto.fromJson(Map<String, dynamic> json) =>
      _$NamedRefDtoFromJson(json);
}
