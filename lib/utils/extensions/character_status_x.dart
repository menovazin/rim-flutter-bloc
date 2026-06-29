import 'package:flutter/material.dart';

import '../../domain/entities/character.dart';

/// UI helpers for a character's `status` field (Alive / Dead / unknown).
extension CharacterStatusX on Character {
  /// Status indicator color: green (Alive), red (Dead), grey (unknown).
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'alive':
        return const Color(0xFF34E27A);
      case 'dead':
        return const Color(0xFFE5484D);
      default:
        return const Color(0xFF9DB5B1);
    }
  }
}
