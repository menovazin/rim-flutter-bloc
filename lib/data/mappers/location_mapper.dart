import '../../domain/entities/location.dart';

/// Maps JSON responses from Rick & Morty REST API to [Location] domain entities.
class LocationMapper {
  static Location fromJson(Map<String, dynamic> json) {
    final residents = (json['residents'] as List?) ?? [];

    return Location(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      dimension: json['dimension'] as String? ?? '',
      residentIds: residents
          .map((e) => int.tryParse(e.toString().split('/').last) ?? 0)
          .where((id) => id > 0)
          .toList(),
    );
  }

  static List<Location> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
