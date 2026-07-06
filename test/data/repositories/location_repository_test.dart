import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:init/api/constants/api_constants.dart';
import 'package:init/data/repositories/location_repository.dart';

void main() {
  group('LocationRepository.getLocations', () {
    // spec: rest-data-layer / Получение списка локаций

    late Dio dio;
    late DioAdapter dioAdapter;
    late LocationRepository repository;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
      dioAdapter = DioAdapter(dio: dio);
      repository = LocationRepository(dio);
    });

    test('performs GET /location?page=N and returns PageResult', () async {
      final fixture = await _loadFixture('location_page_1.json');

      dioAdapter.onGet(
        ApiConstants.locationPath,
        (server) => server.replyCallback(
          200,
          (requestOptions) {
            expect(requestOptions.queryParameters['page'].toString(), '3');
            return fixture;
          },
        ),
      );

      final result = await repository.getLocations(3);

      expect(result.page, 3);
      expect(result.totalPages, 7);
      expect(result.hasNext, true);
      expect(result.items.length, 2);
      expect(result.items.first.id, 1);
      expect(result.items.last.id, 2);
    });
  });
}

Future<Map<String, dynamic>> _loadFixture(String name) async {
  final file = File('test/fixtures/$name');
  final text = await file.readAsString();
  return jsonDecode(text) as Map<String, dynamic>;
}
