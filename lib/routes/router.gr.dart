// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [CharacterDetailPage]
class CharacterDetailRoute extends PageRouteInfo<CharacterDetailRouteArgs> {
  CharacterDetailRoute({
    Key? key,
    required Character character,
    List<PageRouteInfo>? children,
  }) : super(
          CharacterDetailRoute.name,
          args: CharacterDetailRouteArgs(key: key, character: character),
          initialChildren: children,
        );

  static const String name = 'CharacterDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CharacterDetailRouteArgs>();
      return CharacterDetailPage(key: args.key, character: args.character);
    },
  );
}

class CharacterDetailRouteArgs {
  const CharacterDetailRouteArgs({this.key, required this.character});

  final Key? key;

  final Character character;

  @override
  String toString() {
    return 'CharacterDetailRouteArgs{key: $key, character: $character}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CharacterDetailRouteArgs) return false;
    return key == other.key && character == other.character;
  }

  @override
  int get hashCode => key.hashCode ^ character.hashCode;
}

/// generated route for
/// [CharactersPage]
class CharactersRoute extends PageRouteInfo<void> {
  const CharactersRoute({List<PageRouteInfo>? children})
      : super(CharactersRoute.name, initialChildren: children);

  static const String name = 'CharactersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CharactersPage();
    },
  );
}

/// generated route for
/// [EpisodeDetailPage]
class EpisodeDetailRoute extends PageRouteInfo<EpisodeDetailRouteArgs> {
  EpisodeDetailRoute({
    Key? key,
    required Episode episode,
    List<PageRouteInfo>? children,
  }) : super(
          EpisodeDetailRoute.name,
          args: EpisodeDetailRouteArgs(key: key, episode: episode),
          initialChildren: children,
        );

  static const String name = 'EpisodeDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EpisodeDetailRouteArgs>();
      return EpisodeDetailPage(key: args.key, episode: args.episode);
    },
  );
}

class EpisodeDetailRouteArgs {
  const EpisodeDetailRouteArgs({this.key, required this.episode});

  final Key? key;

  final Episode episode;

  @override
  String toString() {
    return 'EpisodeDetailRouteArgs{key: $key, episode: $episode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EpisodeDetailRouteArgs) return false;
    return key == other.key && episode == other.episode;
  }

  @override
  int get hashCode => key.hashCode ^ episode.hashCode;
}

/// generated route for
/// [EpisodesPage]
class EpisodesRoute extends PageRouteInfo<void> {
  const EpisodesRoute({List<PageRouteInfo>? children})
      : super(EpisodesRoute.name, initialChildren: children);

  static const String name = 'EpisodesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EpisodesPage();
    },
  );
}

/// generated route for
/// [LocationDetailPage]
class LocationDetailRoute extends PageRouteInfo<LocationDetailRouteArgs> {
  LocationDetailRoute({
    Key? key,
    required Location location,
    List<PageRouteInfo>? children,
  }) : super(
          LocationDetailRoute.name,
          args: LocationDetailRouteArgs(key: key, location: location),
          initialChildren: children,
        );

  static const String name = 'LocationDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LocationDetailRouteArgs>();
      return LocationDetailPage(key: args.key, location: args.location);
    },
  );
}

class LocationDetailRouteArgs {
  const LocationDetailRouteArgs({this.key, required this.location});

  final Key? key;

  final Location location;

  @override
  String toString() {
    return 'LocationDetailRouteArgs{key: $key, location: $location}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LocationDetailRouteArgs) return false;
    return key == other.key && location == other.location;
  }

  @override
  int get hashCode => key.hashCode ^ location.hashCode;
}

/// generated route for
/// [LocationsPage]
class LocationsRoute extends PageRouteInfo<void> {
  const LocationsRoute({List<PageRouteInfo>? children})
      : super(LocationsRoute.name, initialChildren: children);

  static const String name = 'LocationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LocationsPage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [ShellPage]
class ShellRoute extends PageRouteInfo<void> {
  const ShellRoute({List<PageRouteInfo>? children})
      : super(ShellRoute.name, initialChildren: children);

  static const String name = 'ShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ShellPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}
