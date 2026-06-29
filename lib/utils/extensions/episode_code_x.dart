/// Parses episode code strings like "S01E01" into season and episode numbers.
extension EpisodeCodeX on String {
  int get season => length >= 3 ? (int.tryParse(substring(1, 3)) ?? 0) : 0;
  int get episodeNumber => length >= 6 ? (int.tryParse(substring(4, 6)) ?? 0) : 0;
}