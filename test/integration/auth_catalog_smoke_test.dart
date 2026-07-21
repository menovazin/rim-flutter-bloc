import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:init/core/characters/characters_bloc.dart';
import 'package:init/core/episodes/episodes_bloc.dart';
import 'package:init/core/locations/locations_bloc.dart';
import 'package:init/data/repositories/character_repository.dart';
import 'package:init/data/repositories/episode_repository.dart';
import 'package:init/data/repositories/location_repository.dart';
import 'package:init/domain/entities/character.dart';
import 'package:init/domain/entities/episode.dart';
import 'package:init/domain/entities/location.dart';
import 'package:init/domain/entities/page_result.dart';
import 'package:init/l10n/generated/app_localizations.dart';
import 'package:init/routes/router.dart';
import 'package:init/services/storage/token/token_service.dart';
import 'package:init/themes/app_theme.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/path_provider_mock.dart';

class _MockTokenService extends Mock implements TokenService {}

class _MockCharacterRepository extends Mock implements CharacterRepository {}

class _MockEpisodeRepository extends Mock implements EpisodeRepository {}

class _MockLocationRepository extends Mock implements LocationRepository {}

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _MockHttpClient();
  }
}

class _MockHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    throw const SocketException('Network disabled in smoke tests');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _MockTokenService tokenService;
  late _MockCharacterRepository characterRepository;
  late _MockEpisodeRepository episodeRepository;
  late _MockLocationRepository locationRepository;
  String? storedToken;

  const tCharacter = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Male',
    image: 'https://example.com/rick.jpeg',
    originName: '',
    originUrl: '',
    locationName: '',
    locationUrl: '',
    episodeIds: [],
  );

  setUpAll(() {
    setUpPathProviderMock();
    HttpOverrides.global = _TestHttpOverrides();
  });

  setUp(() async {
    await GetIt.I.reset();
    storedToken = null;
    tokenService = _MockTokenService();
    characterRepository = _MockCharacterRepository();
    episodeRepository = _MockEpisodeRepository();
    locationRepository = _MockLocationRepository();

    when(() => tokenService.getToken()).thenAnswer((_) async => storedToken ?? '');
    when(() => tokenService.saveToken(any())).thenAnswer((invocation) async {
      storedToken = invocation.positionalArguments.first as String;
    });
    when(() => tokenService.clear()).thenAnswer((_) async {
      storedToken = null;
    });

    when(() => characterRepository.getCharacters(any())).thenAnswer(
      (_) async => const PageResult(
        items: [tCharacter],
        page: 1,
        totalPages: 1,
        hasNext: false,
      ),
    );
    when(() => episodeRepository.getEpisodes(any())).thenAnswer(
      (_) async => const PageResult(
        items: <Episode>[],
        page: 1,
        totalPages: 1,
        hasNext: false,
      ),
    );
    when(() => locationRepository.getLocations(any())).thenAnswer(
      (_) async => const PageResult(
        items: <Location>[],
        page: 1,
        totalPages: 1,
        hasNext: false,
      ),
    );

    GetIt.I
      ..registerSingleton<TokenService>(tokenService)
      ..registerFactory<CharactersBloc>(
        () => CharactersBloc(characterRepository),
      )
      ..registerFactory<EpisodesBloc>(
        () => EpisodesBloc(episodeRepository),
      )
      ..registerFactory<LocationsBloc>(
        () => LocationsBloc(locationRepository),
      );
  });

  tearDown(() async {
    await GetIt.I.reset();
  });

  // spec: fake-login / Нажатие кнопки входа
  // spec: characters-catalog / Characters catalog
  testWidgets(
    'smoke: Login → Shell → Characters content (no token cold start)',
    (tester) async {
      final router = AppRouter();

      await tester.pumpWidget(
        MaterialApp.router(
          theme: ThemeType.light.themeData(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router.config(
            deepLinkBuilder: (_) => const DeepLink([LoginRoute()]),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sign In'), findsOneWidget);
      expect(storedToken, isNull);

      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      expect(storedToken, isNotEmpty);
      expect(find.text('Characters'), findsWidgets);
      expect(find.text('Rick Sanchez'), findsOneWidget);
      verify(() => characterRepository.getCharacters(1)).called(1);
    },
  );
}
