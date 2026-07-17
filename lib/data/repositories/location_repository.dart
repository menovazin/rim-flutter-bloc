import 'package:injectable/injectable.dart';

import '../../core/base/rim_base_service.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/page_result.dart';
import '../api/rick_and_morty_api.dart';
import '../mappers/location_mapper.dart';

@lazySingleton
class LocationRepository extends RimBaseService {
  final RickAndMortyApi _api;

  const LocationRepository(this._api);

  Future<PageResult<Location>> getLocations(int page) async {
    return errorParser(() async {
      final res = await _api.getLocations(page);
      return PageResult<Location>(
        items: LocationMapper.fromDtoList(res.results),
        page: page,
        totalPages: res.info?.pages ?? page,
        hasNext: res.info?.next != null,
      );
    });
  }
}
