import 'package:flutter/material.dart';

import '../../domain/entities/character.dart';

/// UI helpers for a character's `gender` field.
extension CharacterGenderX on Character {
  IconData get genderIcon {
    switch (gender.toLowerCase()) {
      case 'male':
        return Icons.male;
      case 'female':
        return Icons.female;
      case 'genderless':
        return Icons.transgender;
      default:
        return Icons.question_mark;
    }
  }
}