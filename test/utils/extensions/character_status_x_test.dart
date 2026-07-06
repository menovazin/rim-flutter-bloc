import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init/domain/entities/character.dart';
import 'package:init/utils/extensions/character_status_x.dart';

void main() {
  group('CharacterStatusX', () {
    const _base = Character(
      id: 1,
      name: 'Test',
      status: 'Alive',
      species: 'Human',
      type: '',
      gender: 'Male',
      image: '',
      originName: '',
      originUrl: '',
      locationName: '',
      locationUrl: '',
      episodeIds: [],
    );

    test('statusColor is green for alive', () {
      expect(_base.statusColor, const Color(0xFF34E27A));
    });

    test('statusColor is red for dead', () {
      const dead = Character(
        id: 1,
        name: 'Test',
        status: 'Dead',
        species: 'Human',
        type: '',
        gender: 'Male',
        image: '',
        originName: '',
        originUrl: '',
        locationName: '',
        locationUrl: '',
        episodeIds: [],
      );
      expect(dead.statusColor, const Color(0xFFE5484D));
    });

    test('statusColor is grey for unknown', () {
      const unknown = Character(
        id: 1,
        name: 'Test',
        status: 'Unknown',
        species: 'Human',
        type: '',
        gender: 'Male',
        image: '',
        originName: '',
        originUrl: '',
        locationName: '',
        locationUrl: '',
        episodeIds: [],
      );
      expect(unknown.statusColor, const Color(0xFF9DB5B1));
    });
  });
}
