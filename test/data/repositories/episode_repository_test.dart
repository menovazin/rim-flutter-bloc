import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:init/api/constants/api_constants.dart';
import 'package:init/data/repositories/episode_repository.dart';

void main() {
  group('EpisodeRepository.getEpisodes', () {
    // spec: rest-data-layer / Получение списка эпизодов

    late Dio dio;
    late DioAdapter dioAdapter;
    late EpisodeRepository repository;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
      dioAdapter = DioAdapter(dio: dio);
      repository = EpisodeRepository(dio);
    });

    test('performs GET /episode?page=N and returns PageResult', () async {
      final fixture = await _loadFixture('episode_page_1.json');

      dioAdapter.onGet(
        ApiConstants.episodePath,
        (server) => server.replyCallback(
          200,
          (requestOptions) {
            expect(requestOptions.queryParameters['page'].toString(), '2');
            return fixture;
          },
        ),
      );

      final result = await repository.getEpisodes(2);

      expect(result.page, 2);
      expect(result.totalPages, 3);
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
