import 'package:dio/dio.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:injectable/injectable.dart';

import '../../api/constants/api_constants.dart';
import '../../domain/entities/character.dart';
import '../../domain/entities/page_result.dart';
import '../mappers/character_mapper.dart';

/// Repository encapsulating REST access to Rick & Morty characters.
///
/// Performs `GET /character?page=N` and returns domain [Character] models
/// together with pagination info, never raw JSON.
@lazySingleton
class CharacterRepository extends BaseService {
  final Dio _dio;

  const CharacterRepository(this._dio);

  Future<PageResult<Character>> getCharacters(int page) async {
    return errorParser(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.characterPath,
        queryParameters: {'page': page},
      );

      final data = response.data ?? const {};
      final info = (data['info'] as Map<String, dynamic>?) ?? const {};
      final results = (data['results'] as List?) ?? const [];

      return PageResult<Character>(
        items: CharacterMapper.fromJsonList(results),
        page: page,
        totalPages: info['pages'] as int? ?? page,
        hasNext: info['next'] != null,
      );
    });
  }
}
