import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../api/request_tracker/request_tracker.dart';
import '../core/characters/characters_bloc.dart';
import '../core/episodes/episodes_bloc.dart';
import '../core/locations/locations_bloc.dart';
import '../core/logs/logs_state.dart';
import '../core/settings/settings_state.dart';
import '../core/snack_messages/snack_messages_state.dart';
import '../data/repositories/character_repository.dart';
import '../data/repositories/episode_repository.dart';
import '../data/repositories/location_repository.dart';
import '../routes/router.dart';
import '../services/storage/token/token_service.dart';
import 'di.config.dart';

final GetIt _getIt = GetIt.instance;

class Di {
  Dio get dio => _getIt<Dio>();

  AppRouter get appRouter => _getIt<AppRouter>();

  CharactersBloc get charactersBloc => _getIt<CharactersBloc>();

  EpisodesBloc get episodesBloc => _getIt<EpisodesBloc>();

  LocationsBloc get locationsBloc => _getIt<LocationsBloc>();

  TokenService get tokenService => _getIt<TokenService>();

  SettingsState get settingsState => _getIt<SettingsState>();

  SnackMessagesState get snackMessagesState => _getIt<SnackMessagesState>();

  LogsState get logsState => _getIt<LogsState>();

  RequestTracker get requestTracker => _getIt<RequestTracker>();

  CharacterRepository get characterRepository => _getIt<CharacterRepository>();

  EpisodeRepository get episodeRepository => _getIt<EpisodeRepository>();

  LocationRepository get locationRepository => _getIt<LocationRepository>();
}

final di = Di();

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<GetIt> configureDependencies(Environment environment) {
  return $initGetIt(_getIt, environment: environment.name);
}