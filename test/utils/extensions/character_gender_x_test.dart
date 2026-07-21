import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init/domain/entities/character.dart';
import 'package:init/utils/extensions/character_gender_x.dart';

void main() {
  group('CharacterGenderX', () {
    Character characterWithGender(String gender) {
      return Character(
        id: 1,
        name: 'Test',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: gender,
        image: '',
        originName: '',
        originUrl: '',
        locationName: '',
        locationUrl: '',
        episodeIds: const [],
      );
    }

    test('genderIcon returns male icon for male', () {
      expect(characterWithGender('Male').genderIcon, Icons.male);
    });

    test('genderIcon returns female icon for female', () {
      expect(characterWithGender('Female').genderIcon, Icons.female);
    });

    test('genderIcon returns transgender icon for genderless', () {
      expect(
        characterWithGender('Genderless').genderIcon,
        Icons.transgender,
      );
    });

    test('genderIcon returns question mark for unknown', () {
      expect(
        characterWithGender('unknown').genderIcon,
        Icons.question_mark,
      );
    });

    test('genderIcon is case-insensitive', () {
      expect(characterWithGender('MALE').genderIcon, Icons.male);
      expect(characterWithGender('female').genderIcon, Icons.female);
    });
  });
}
