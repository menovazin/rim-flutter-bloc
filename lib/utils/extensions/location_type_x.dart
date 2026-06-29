import 'package:flutter/material.dart';

/// Maps Rick & Morty location type strings to Material icons.
extension LocationTypeX on String {
  IconData get locationIcon {
    switch (toLowerCase()) {
      case 'planet':
        return Icons.public;
      case 'space station':
        return Icons.rocket_launch_outlined;
      case 'microverse':
        return Icons.grain;
      case 'dream':
        return Icons.cloud_outlined;
      case 'tv':
        return Icons.tv_outlined;
      case 'resort':
        return Icons.pool_outlined;
      case 'fantasy town':
        return Icons.castle_outlined;
      case 'cluster':
        return Icons.bubble_chart_outlined;
      default:
        return Icons.location_on_outlined;
    }
  }
}