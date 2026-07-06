import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:init/data/mappers/location_mapper.dart';
import 'package:init/domain/entities/location.dart';

void main() {
  group('LocationMapper.fromJson', () {
    // spec: rest-data-layer / Маппинг локации

    test('parses full location JSON', () async {
      final json = await _loadFixture('location_full.json');

      final location = LocationMapper.fromJson(json);

      expect(location.id, 1);
      expect(location.name, 'Earth (C-137)');
      expect(location.type, 'Planet');
      expect(location.dimension, 'Dimension C-137');
      expect(location.residentIds, [1, 2]);
    });

    test('handles missing residents array', () async {
      final json = await _loadFixture('location_no_residents.json');

      final location = LocationMapper.fromJson(json);

      expect(location.residentIds, isEmpty);
    });

    test('filters out malformed resident URLs', () {
      final json = {
        'id': 3,
        'name': 'Citadel of Ricks',
        'type': 'Space station',
        'dimension': 'unknown',
        'residents': [
          'https://rickandmortyapi.com/api/character/7',
          'bad-url',
          'https://rickandmortyapi.com/api/character/',
        ],
      };

      final location = LocationMapper.fromJson(json);

      expect(location.residentIds, [7]);
    });
  });

  group('LocationMapper.fromJsonList', () {
    test('parses list of locations', () async {
      final fixtures = [
        await _loadFixture('location_full.json'),
        await _loadFixture('location_no_residents.json'),
      ];

      final locations = LocationMapper.fromJsonList(fixtures);

      expect(locations.length, 2);
      expect(locations.first.id, 1);
      expect(locations.last.id, 2);
    });
  });
}

Future<Map<String, dynamic>> _loadFixture(String name) async {
  final file = File('test/fixtures/$name');
  final text = await file.readAsString();
  return jsonDecode(text) as Map<String, dynamic>;
}
