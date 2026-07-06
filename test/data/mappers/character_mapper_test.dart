import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:init/data/mappers/character_mapper.dart';
import 'package:init/domain/entities/character.dart';

void main() {
  group('CharacterMapper.fromJson', () {
    // spec: rest-data-layer / Маппинг персонажа

    test('parses full character JSON', () async {
      final json = await _loadFixture('character_full.json');

      final character = CharacterMapper.fromJson(json);

      expect(character.id, 1);
      expect(character.name, 'Rick Sanchez');
      expect(character.status, 'Alive');
      expect(character.species, 'Human');
      expect(character.type, '');
      expect(character.gender, 'Male');
      expect(
        character.image,
        'https://semester.syazy.com/rickandmorty/1.jpeg',
      );
      expect(character.originName, 'Earth (C-137)');
      expect(
        character.originUrl,
        'https://rickandmortyapi.com/api/location/1',
      );
      expect(character.locationName, 'Citadel of Ricks');
      expect(
        character.locationUrl,
        'https://rickandmortyapi.com/api/location/3',
      );
      expect(character.episodeIds, [1, 2]);
    });

    test('handles missing origin and location', () async {
      final json = await _loadFixture('character_missing_origin.json');

      final character = CharacterMapper.fromJson(json);

      expect(character.originName, '');
      expect(character.originUrl, '');
      expect(character.locationName, '');
      expect(character.locationUrl, '');
      expect(character.episodeIds, isEmpty);
    });

    test('handles missing episode array', () async {
      final json = await _loadFixture('character_no_episodes.json');

      final character = CharacterMapper.fromJson(json);

      expect(character.episodeIds, isEmpty);
    });

    test('filters out malformed episode URLs', () {
      final json = {
        'id': 4,
        'name': 'Beth Smith',
        'status': 'Alive',
        'species': 'Human',
        'type': '',
        'gender': 'Female',
        'image': '',
        'origin': {'name': '', 'url': ''},
        'location': {'name': '', 'url': ''},
        'episode': [
          'https://rickandmortyapi.com/api/episode/5',
          'not-a-url',
          'https://rickandmortyapi.com/api/episode/',
        ],
      };

      final character = CharacterMapper.fromJson(json);

      expect(character.episodeIds, [5]);
    });
  });

  group('CharacterMapper.fromJsonList', () {
    test('parses list of characters', () async {
      final fixtures = [
        await _loadFixture('character_full.json'),
        await _loadFixture('character_missing_origin.json'),
      ];

      final characters = CharacterMapper.fromJsonList(fixtures);

      expect(characters.length, 2);
      expect(characters.first.id, 1);
      expect(characters.last.id, 2);
    });
  });
}

Future<Map<String, dynamic>> _loadFixture(String name) async {
  final file = File('test/fixtures/$name');
  final text = await file.readAsString();
  return jsonDecode(text) as Map<String, dynamic>;
}
