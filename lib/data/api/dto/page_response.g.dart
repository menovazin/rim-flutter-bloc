// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponse _$PageResponseFromJson(Map<String, dynamic> json) => PageResponse(
      info: json['info'] == null
          ? null
          : InfoResponse.fromJson(json['info'] as Map<String, dynamic>),
      results: json['results'] as List<dynamic>? ?? [],
    );

Map<String, dynamic> _$PageResponseToJson(PageResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };

InfoResponse _$InfoResponseFromJson(Map<String, dynamic> json) => InfoResponse(
      pages: (json['pages'] as num?)?.toInt(),
      next: json['next'] as String?,
      prev: json['prev'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InfoResponseToJson(InfoResponse instance) =>
    <String, dynamic>{
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
      'count': instance.count,
    };
