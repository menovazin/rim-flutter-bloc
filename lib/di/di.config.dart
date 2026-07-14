// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:package_info_plus/package_info_plus.dart' as _i655;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../api/dio/dio_api.dart' as _i1023;
import '../api/interceptors/api_interceptors.dart' as _i956;
import '../api/request_tracker/request_tracker.dart' as _i250;
import '../core/characters/characters_bloc.dart' as _i175;
import '../core/episodes/episodes_bloc.dart' as _i1036;
import '../core/locations/locations_bloc.dart' as _i429;
import '../core/logs/logs_state.dart' as _i267;
import '../core/settings/settings_state.dart' as _i751;
import '../core/snack_messages/snack_messages_state.dart' as _i935;
import '../data/api/rick_and_morty_api.dart' as _i549;
import '../data/repositories/character_repository.dart' as _i388;
import '../data/repositories/episode_repository.dart' as _i47;
import '../data/repositories/location_repository.dart' as _i897;
import '../routes/module/route_module.dart' as _i402;
import '../routes/observer/app_observer.dart' as _i694;
import '../routes/router.dart' as _i393;
import '../services/other/app_info/app_info_service.dart' as _i810;
import '../services/other/url_launcher/url_launcher_service.dart' as _i792;
import '../services/storage/fonts/fonts_service.dart' as _i490;
import '../services/storage/locale/locale_service.dart' as _i247;
import '../services/storage/store_version/store_version_service.dart' as _i395;
import '../services/storage/theme/theme_service.dart' as _i977;
import '../services/storage/token/token_service.dart' as _i700;
import 'modules/di_module.dart' as _i831;

const String _dev = 'dev';

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final diModule = _$DiModule();
  final routeModule = _$RouteModule();
  final dioModule = _$DioModule();
  final rickAndMortyApiModule = _$RickAndMortyApiModule();
  gh.factory<_i558.FlutterSecureStorage>(() => diModule.secureStorage);
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => diModule.sharedPreferences(),
    preResolve: true,
  );
  await gh.factoryAsync<_i655.PackageInfo>(
    () => diModule.packageInfo(),
    preResolve: true,
  );
  gh.factory<_i833.DeviceInfoPlugin>(() => diModule.deviceInfo());
  gh.factory<_i694.AppObserver>(() => _i694.AppObserver());
  gh.singleton<_i267.LogsState>(() => _i267.LogsState());
  gh.singleton<_i935.SnackMessagesState>(() => _i935.SnackMessagesState());
  gh.lazySingleton<_i250.RequestTracker>(() => _i250.RequestTracker());
  gh.lazySingleton<_i393.AppRouter>(() => routeModule.router());
  gh.lazySingleton<_i792.UrlLauncherService>(
      () => const _i792.UrlLauncherService());
  gh.factory<_i490.FontsService>(
      () => _i490.FontsService(gh<_i460.SharedPreferences>()));
  gh.factory<_i247.LocaleService>(
      () => _i247.LocaleService(gh<_i460.SharedPreferences>()));
  gh.factory<_i977.ThemeService>(
      () => _i977.ThemeService(gh<_i460.SharedPreferences>()));
  gh.factory<_i700.TokenService>(
      () => _i700.TokenService(gh<_i558.FlutterSecureStorage>()));
  gh.lazySingleton<_i956.ApiInterceptor>(() => _i956.ApiInterceptor(
        gh<_i700.TokenService>(),
        gh<_i250.RequestTracker>(),
      ));
  gh.singleton<_i751.SettingsState>(() => _i751.SettingsState(
        gh<_i247.LocaleService>(),
        gh<_i977.ThemeService>(),
        gh<_i490.FontsService>(),
      ));
  gh.factory<_i395.StoreVersionService>(() => _i395.StoreVersionService(
        gh<_i460.SharedPreferences>(),
        gh<_i558.FlutterSecureStorage>(),
      ));
  gh.lazySingleton<_i361.Dio>(
      () => dioModule.client(gh<_i956.ApiInterceptor>()));
  gh.lazySingleton<_i810.AppInfoService>(
    () => _i810.AppInfoServiceDev(gh<_i655.PackageInfo>()),
    registerFor: {_dev},
  );
  gh.lazySingleton<_i549.RickAndMortyApi>(
      () => rickAndMortyApiModule.getInstance(gh<_i361.Dio>()));
  gh.lazySingleton<_i388.CharacterRepository>(
      () => _i388.CharacterRepository(gh<_i549.RickAndMortyApi>()));
  gh.lazySingleton<_i47.EpisodeRepository>(
      () => _i47.EpisodeRepository(gh<_i549.RickAndMortyApi>()));
  gh.lazySingleton<_i897.LocationRepository>(
      () => _i897.LocationRepository(gh<_i549.RickAndMortyApi>()));
  gh.factory<_i429.LocationsBloc>(
      () => _i429.LocationsBloc(gh<_i897.LocationRepository>()));
  gh.factory<_i175.CharactersBloc>(
      () => _i175.CharactersBloc(gh<_i388.CharacterRepository>()));
  gh.factory<_i1036.EpisodesBloc>(
      () => _i1036.EpisodesBloc(gh<_i47.EpisodeRepository>()));
  return getIt;
}

class _$DiModule extends _i831.DiModule {}

class _$RouteModule extends _i402.RouteModule {}

class _$DioModule extends _i1023.DioModule {}

class _$RickAndMortyApiModule extends _i549.RickAndMortyApiModule {}
