import 'package:injectable/injectable.dart';

import '../../core/base/rim_base_service.dart';
import '../../domain/entities/character.dart';
import '../../domain/entities/page_result.dart';
import '../api/rick_and_morty_api.dart';
import '../mappers/character_mapper.dart';

@lazySingleton
class CharacterRepository extends RimBaseService {
  final RickAndMortyApi _api;

  const CharacterRepository(this._api);

  Future<PageResult<Character>> getCharacters(int page) async {
    return errorParser(() async {
      final res = await _api.getCharacters(page);
      return PageResult<Character>(
        items: CharacterMapper.fromJsonList(res.results),
        page: page,
        totalPages: res.info?.pages ?? page,
        hasNext: res.info?.next != null,
      );
    });
  }
}
