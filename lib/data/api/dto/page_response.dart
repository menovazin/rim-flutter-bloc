import 'package:json_annotation/json_annotation.dart';

part 'page_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PageResponse<T> {
  final InfoResponse? info;

  @JsonKey(defaultValue: [])
  final List<T> results;

  const PageResponse({this.info, this.results = const []});

  factory PageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PageResponseFromJson(json, fromJsonT);
}

@JsonSerializable()
class InfoResponse {
  final int? pages;
  final String? next;
  final String? prev;
  final int? count;

  const InfoResponse({this.pages, this.next, this.prev, this.count});

  factory InfoResponse.fromJson(Map<String, dynamic> json) =>
      _$InfoResponseFromJson(json);
}
