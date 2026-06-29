import 'package:dio/dio.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:injectable/injectable.dart';

import '../../api/constants/api_constants.dart';
import '../../domain/entities/episode.dart';
import '../../domain/entities/page_result.dart';
import '../mappers/episode_mapper.dart';

/// Repository encapsulating REST access to Rick & Morty episodes.
///
/// Performs `GET /episode?page=N` and returns domain [Episode] models
/// together with pagination info, never raw JSON.
@lazySingleton
class EpisodeRepository extends BaseService {
  final Dio _dio;

  const EpisodeRepository(this._dio);

  Future<PageResult<Episode>> getEpisodes(int page) async {
    return errorParser(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.episodePath,
        queryParameters: {'page': page},
      );

      final data = response.data ?? const {};
      final info = (data['info'] as Map<String, dynamic>?) ?? const {};
      final results = (data['results'] as List?) ?? const [];

      return PageResult<Episode>(
        items: EpisodeMapper.fromJsonList(results),
        page: page,
        totalPages: info['pages'] as int? ?? page,
        hasNext: info['next'] != null,
      );
    });
  }
}
