import 'package:equatable/equatable.dart';

/// Domain entity representing a Rick & Morty character.
class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String originName;
  final String originUrl;
  final String locationName;
  final String locationUrl;
  final List<int> episodeIds;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.originName,
    required this.originUrl,
    required this.locationName,
    required this.locationUrl,
    required this.episodeIds,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        image,
        originName,
        originUrl,
        locationName,
        locationUrl,
        episodeIds,
      ];
}