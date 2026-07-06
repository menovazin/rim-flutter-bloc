import 'package:flutter_test/flutter_test.dart';
import 'package:init/utils/extensions/episode_code_x.dart';

void main() {
  group('EpisodeCodeX', () {
    test('parses season and episode from S01E01', () {
      expect('S01E01'.season, 1);
      expect('S01E01'.episodeNumber, 1);
    });

    test('parses double-digit season and episode', () {
      expect('S12E34'.season, 12);
      expect('S12E34'.episodeNumber, 34);
    });

    test('returns 0 for malformed season', () {
      expect('SxxE01'.season, 0);
    });

    test('returns 0 for malformed episode', () {
      expect('S01Exx'.episodeNumber, 0);
    });

    test('returns 0 for too short string', () {
      expect('S0'.season, 0);
      expect('S0'.episodeNumber, 0);
    });
  });
}
