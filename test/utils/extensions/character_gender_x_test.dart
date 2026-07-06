import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init/domain/entities/character.dart';
import 'package:init/utils/extensions/character_gender_x.dart';

void main() {
  group('CharacterGenderX', () {
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

    test('genderIcon returns male icon for male', () {
      expect(_base.genderIcon, Icons.male);
    });

    test('genderSymbol returns male symbol for male', () {
      expect(_base.genderSymbol, '♂');
    });

    test('genderIcon is case-insensitive', () {
      const maleUpper = Character(
        id: 1,
        name: 'Test',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: 'MALE',
        image: '',
        originName: '',
        originUrl: '',
        locationName: '',
        locationUrl: '',
        episodeIds: [],
      );
      expect(maleUpper.genderIcon, Icons.male);
    });

    test('returns question icon for unknown gender', () {
      const unknown = Character(
        id: 1,
        name: 'Test',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: 'Unknown',
        image: '',
        originName: '',
        originUrl: '',
        locationName: '',
        locationUrl: '',
        episodeIds: [],
      );
      expect(unknown.genderIcon, Icons.question_mark);
    });
  });
}
