import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/episode.dart';
import '../../domain/entities/page_result.dart';
import '../api/rick_and_morty_api.dart';
import '../mappers/episode_mapper.dart';

@lazySingleton
class EpisodeRepository extends BaseService {
  final RickAndMortyApi _api;

  const EpisodeRepository(this._api);

  Future<PageResult<Episode>> getEpisodes(int page) async {
    return errorParser(() async {
      final res = await _api.getEpisodes(page);
      return PageResult<Episode>(
        items: EpisodeMapper.fromJsonList(res.results),
        page: page,
        totalPages: res.info?.pages ?? page,
        hasNext: res.info?.next != null,
      );
    });
  }
}
