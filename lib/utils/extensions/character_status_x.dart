import 'package:flutter/material.dart';

import '../../domain/entities/character.dart';
import '../../themes/extensions/custom_designs.dart';

/// UI helpers for a character's `status` field (Alive / Dead / unknown).
extension CharacterStatusX on Character {
  /// Status indicator color from [CustomDesigns] palette.
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'alive':
        return CustomDesigns.statusAliveColor;
      case 'dead':
        return CustomDesigns.statusDeadColor;
      default:
        return CustomDesigns.statusUnknownColor;
    }
  }

  /// Theme-aware status color (same palette as [statusColor] today).
  Color statusColorOf(CustomDesigns designs) {
    switch (status.toLowerCase()) {
      case 'alive':
        return designs.statusAlive;
      case 'dead':
        return designs.statusDead;
      default:
        return designs.statusUnknown;
    }
  }
}
