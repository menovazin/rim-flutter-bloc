import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:init/data/mappers/episode_mapper.dart';
import 'package:init/domain/entities/episode.dart';

void main() {
  group('EpisodeMapper.fromJson', () {
    // spec: rest-data-layer / Маппинг эпизода

    test('parses full episode JSON', () async {
      final json = await _loadFixture('episode_full.json');

      final episode = EpisodeMapper.fromJson(json);

      expect(episode.id, 1);
      expect(episode.name, 'Pilot');
      expect(episode.episodeCode, 'S01E01');
      expect(episode.airDate, 'December 2, 2013');
      expect(episode.characterIds, [1, 2]);
    });

    test('handles missing characters array', () async {
      final json = await _loadFixture('episode_no_characters.json');

      final episode = EpisodeMapper.fromJson(json);

      expect(episode.characterIds, isEmpty);
    });

    test('filters out malformed character URLs', () {
      final json = {
        'id': 3,
        'name': 'Anatomy Park',
        'episode': 'S01E03',
        'air_date': 'December 16, 2013',
        'characters': [
          'https://rickandmortyapi.com/api/character/10',
          'invalid',
          'https://rickandmortyapi.com/api/character/',
        ],
      };

      final episode = EpisodeMapper.fromJson(json);

      expect(episode.characterIds, [10]);
    });
  });

  group('EpisodeMapper.fromJsonList', () {
    test('parses list of episodes', () async {
      final fixtures = [
        await _loadFixture('episode_full.json'),
        await _loadFixture('episode_no_characters.json'),
      ];

      final episodes = EpisodeMapper.fromJsonList(fixtures);

      expect(episodes.length, 2);
      expect(episodes.first.id, 1);
      expect(episodes.last.id, 2);
    });
  });
}

Future<Map<String, dynamic>> _loadFixture(String name) async {
  final file = File('test/fixtures/$name');
  final text = await file.readAsString();
  return jsonDecode(text) as Map<String, dynamic>;
}
