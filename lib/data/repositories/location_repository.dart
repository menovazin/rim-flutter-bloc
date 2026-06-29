import 'package:dio/dio.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:injectable/injectable.dart';

import '../../api/constants/api_constants.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/page_result.dart';
import '../mappers/location_mapper.dart';

/// Repository encapsulating REST access to Rick & Morty locations.
///
/// Performs `GET /location?page=N` and returns domain [Location] models
/// together with pagination info, never raw JSON.
@lazySingleton
class LocationRepository extends BaseService {
  final Dio _dio;

  const LocationRepository(this._dio);

  Future<PageResult<Location>> getLocations(int page) async {
    return errorParser(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.locationPath,
        queryParameters: {'page': page},
      );

      final data = response.data ?? const {};
      final info = (data['info'] as Map<String, dynamic>?) ?? const {};
      final results = (data['results'] as List?) ?? const [];

      return PageResult<Location>(
        items: LocationMapper.fromJsonList(results),
        page: page,
        totalPages: info['pages'] as int? ?? page,
        hasNext: info['next'] != null,
      );
    });
  }
}
