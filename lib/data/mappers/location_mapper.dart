import '../../domain/entities/location.dart';
import '../api/dto/location_dto.dart';

/// Maps location DTOs from Rick & Morty REST API to [Location] domain entities.
class LocationMapper {
  static Location fromDto(LocationDto dto) {
    final residents = dto.residents ?? const <String>[];

    return Location(
      id: dto.id ?? 0,
      name: dto.name ?? '',
      type: dto.type ?? '',
      dimension: dto.dimension ?? '',
      residentIds: residents
          .map((e) => int.tryParse(e.split('/').last) ?? 0)
          .where((id) => id > 0)
          .toList(),
    );
  }

  static List<Location> fromDtoList(List<LocationDto> list) =>
      list.map(fromDto).toList();
}
