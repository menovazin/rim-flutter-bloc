import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init/utils/extensions/location_type_x.dart';

void main() {
  group('LocationTypeX', () {
    test('planet maps to public icon', () {
      expect('Planet'.locationIcon, Icons.public);
    });

    test('space station maps to rocket icon', () {
      expect('Space station'.locationIcon, Icons.rocket_launch_outlined);
    });

    test('tv maps to tv icon', () {
      expect('TV'.locationIcon, Icons.tv_outlined);
    });

    test('unknown type maps to location pin icon', () {
      expect('Unknown'.locationIcon, Icons.location_on_outlined);
    });

    test('icon lookup is case-insensitive', () {
      expect('PLANET'.locationIcon, Icons.public);
    });
  });
}
