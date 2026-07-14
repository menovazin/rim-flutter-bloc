import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:init/api/constants/api_constants.dart';
import 'package:init/data/api/rick_and_morty_api.dart';
import 'package:init/data/repositories/character_repository.dart';

void main() {
  group('CharacterRepository.getCharacters', () {
    // spec: rest-data-layer / Получение списка персонажей

    late Dio dio;
    late DioAdapter dioAdapter;
    late CharacterRepository repository;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
      dioAdapter = DioAdapter(dio: dio);
      final api = RickAndMortyApi(dio, baseUrl: ApiConstants.baseUrl);
      repository = CharacterRepository(api);
    });

    test('performs GET /character?page=1 and returns PageResult', () async {
      final fixture = await _loadFixture('character_page_1.json');

      dioAdapter.onGet(
        ApiConstants.characterPath,
        (server) => server.replyCallback(
          200,
          (requestOptions) {
            expect(requestOptions.queryParameters['page'].toString(), '1');
            return fixture;
          },
        ),
      );

      final result = await repository.getCharacters(1);

      expect(result.page, 1);
      expect(result.totalPages, 42);
      expect(result.hasNext, true);
      expect(result.items.length, 2);
      expect(result.items.first.id, 1);
      expect(result.items.last.id, 2);
    });

    test('returns hasNext false when info.next is null', () async {
      final fixture = await _loadFixture('character_page_1.json');
      (fixture['info'] as Map<String, dynamic>)['next'] = null;

      dioAdapter.onGet(
        ApiConstants.characterPath,
        (server) => server.reply(200, fixture),
      );

      final result = await repository.getCharacters(1);

      expect(result.hasNext, false);
    });

    test('throws ApiException on connection timeout', () async {
      dioAdapter.onGet(
        ApiConstants.characterPath,
        (server) => server.throws(
          408,
          DioException(
            requestOptions: RequestOptions(path: ApiConstants.characterPath),
            type: DioExceptionType.connectionTimeout,
          ),
        ),
      );

      await expectLater(
        repository.getCharacters(1),
        throwsA(
          isA<ApiException>().having(
            (e) => e.message,
            'message',
            'Internet Connection Error',
          ),
        ),
      );
    });
  });
}

Future<Map<String, dynamic>> _loadFixture(String name) async {
  final file = File('test/fixtures/$name');
  final text = await file.readAsString();
  return jsonDecode(text) as Map<String, dynamic>;
}
