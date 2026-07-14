import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init/domain/entities/character.dart';
import 'package:init/domain/entities/episode.dart';
import 'package:init/domain/entities/location.dart';
import 'package:init/l10n/localization_helper.dart';
import 'package:init/themes/app_theme.dart';
import 'package:init/ui/pages/auth/login_page.dart';
import 'package:init/ui/pages/characters/character_detail_page.dart';
import 'package:init/ui/pages/episodes/episode_detail_page.dart';
import 'package:init/ui/pages/locations/location_detail_page.dart';
import 'package:init/utils/extensions/character_status_x.dart';
import 'package:init/utils/extensions/episode_code_x.dart';

import '../helpers/path_provider_mock.dart';

const _kFontFamilyNunito = 'Nunito';

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _MockHttpClient();
  }
}

class _MockHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    throw const SocketException('Network disabled in golden tests');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const episode = Episode(
    id: 1,
    name: 'Pilot',
    episodeCode: 'S01E01',
    airDate: 'December 2, 2013',
    characterIds: [1, 2],
  );

  const locationWithResidents = Location(
    id: 3,
    name: 'Citadel of Ricks',
    type: 'Space station',
    dimension: 'unknown',
    residentIds: [1, 2],
  );

  const locationEmpty = Location(
    id: 20,
    name: 'Earth (C-137)',
    type: 'Planet',
    dimension: 'Dimension C-137',
    residentIds: [],
  );

  const character = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Male',
    image: 'https://example.com/rick.jpeg',
    originName: 'Earth',
    originUrl: '',
    locationName: 'Earth',
    locationUrl: '',
    episodeIds: [1],
  );

  const characterForDetail = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Male',
    image: 'https://example.com/rick.jpeg',
    originName: 'Earth (C-137)',
    originUrl: '',
    locationName: 'Citadel of Ricks',
    locationUrl: '',
    episodeIds: [1, 2, 3],
  );

  setUpAll(() {
    setUpPathProviderMock();
    HttpOverrides.global = _TestHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  Widget wrap(Widget child, {required bool dark}) {
    return MaterialApp(
      theme: ThemeType.light.themeData(fontFamily: _kFontFamilyNunito),
      darkTheme: ThemeType.dark.themeData(fontFamily: _kFontFamilyNunito),
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: child,
    );
  }

  Future<void> pumpGolden(
    WidgetTester tester,
    Widget child, {
    required bool dark,
    Size size = const Size(400, 900),
  }) async {
    await tester.binding.setSurfaceSize(size);
    await tester.pumpWidget(wrap(child, dark: dark));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  group('detail screens', () {
    for (final dark in [false, true]) {
      final suffix = dark ? 'dark' : 'light';

      testWidgets('Episode detail golden $suffix', (tester) async {
        await pumpGolden(
          tester,
          EpisodeDetailPage(episode: episode),
          dark: dark,
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/episode_detail_screen_$suffix.png'),
        );
      }, tags: ['golden']);

      testWidgets('Location detail with residents golden $suffix', (tester) async {
        await pumpGolden(
          tester,
          LocationDetailPage(location: locationWithResidents),
          dark: dark,
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile(
            'goldens/location_detail_with_residents_$suffix.png',
          ),
        );
      }, tags: ['golden']);

      testWidgets('Location detail empty residents golden $suffix', (tester) async {
        await pumpGolden(
          tester,
          LocationDetailPage(location: locationEmpty),
          dark: dark,
          size: const Size(430, 900),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile(
            'goldens/location_detail_empty_residents_$suffix.png',
          ),
        );
      }, tags: ['golden']);

      testWidgets('Character detail golden $suffix', (tester) async {
        await pumpGolden(
          tester,
          CharacterDetailPage(character: characterForDetail),
          dark: dark,
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/character_detail_screen_$suffix.png'),
        );
      }, tags: ['golden']);
    }
  });

  group('login screen', () {
    for (final dark in [false, true]) {
      final suffix = dark ? 'dark' : 'light';

      testWidgets('Login screen golden $suffix', (tester) async {
        await pumpGolden(
          tester,
          const LoginPage(),
          dark: dark,
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/login_screen_$suffix.png'),
        );
      }, tags: ['golden']);
    }
  });

  group('catalog widgets', () {
    for (final dark in [false, true]) {
      final suffix = dark ? 'dark' : 'light';

      testWidgets('Character card golden $suffix', (tester) async {
        await pumpGolden(
          tester,
          Scaffold(
            body: Center(
              child: SizedBox(
                width: 180,
                height: 250,
                child: _GoldenCharacterCard(character: character),
              ),
            ),
          ),
          dark: dark,
          size: const Size(220, 300),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/character_card_$suffix.png'),
        );
      }, tags: ['golden']);

      testWidgets('Episode list item golden $suffix', (tester) async {
        await pumpGolden(
          tester,
          Scaffold(
            body: _GoldenEpisodeListItem(episode: episode),
          ),
          dark: dark,
          size: const Size(400, 120),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/episode_list_item_$suffix.png'),
        );
      }, tags: ['golden']);
    }
  });

  group('shell drawer', () {
    for (final dark in [false, true]) {
      final suffix = dark ? 'dark' : 'light';

      testWidgets('Shell drawer menu golden $suffix', (tester) async {
        await pumpGolden(
          tester,
          const _GoldenShellDrawerPreview(),
          dark: dark,
          size: const Size(320, 500),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/shell_drawer_$suffix.png'),
        );
      }, tags: ['golden']);
    }
  });
}

class _GoldenCharacterCard extends StatelessWidget {
  final Character character;

  const _GoldenCharacterCard({required this.character});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;

    return Container(
      decoration: BoxDecoration(
        color: designs.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: character.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => ColoredBox(
                color: designs.background,
                child: const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => ColoredBox(
                color: designs.background,
                child: Icon(Icons.broken_image, color: designs.textSecondary),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: designs.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: character.statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '${character.status} • ${character.species}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: designs.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GoldenEpisodeListItem extends StatelessWidget {
  final Episode episode;

  const _GoldenEpisodeListItem({required this.episode});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final s = episode.episodeCode.season;
    final e = episode.episodeCode.episodeNumber;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: designs.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: designs.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'S${s.toString().padLeft(2, '0')}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: designs.primary,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              Text(
                'E${e.toString().padLeft(2, '0')}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: designs.primary.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          episode.name,
          style: context.textTheme.titleSmall?.copyWith(
            color: designs.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          episode.airDate,
          style: context.textTheme.bodySmall?.copyWith(
            color: designs.textSecondary,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: designs.textSecondary),
      ),
    );
  }
}

class _GoldenShellDrawerPreview extends StatelessWidget {
  const _GoldenShellDrawerPreview();

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final l10n = context.strings;

    return ColoredBox(
      color: designs.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Row(
                children: [
                  Icon(Icons.science_outlined, color: designs.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.loginTitle,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: designs.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.dark_mode_outlined,
                    color: designs.textPrimary,
                    size: 24,
                  ),
                ],
              ),
            ),
            Divider(color: designs.textSecondary.withValues(alpha: 0.15)),
            _drawerItem(
              context,
              icon: Icons.people_alt_outlined,
              title: l10n.tabCharacters,
              active: true,
            ),
            _drawerItem(
              context,
              icon: Icons.movie_outlined,
              title: l10n.tabEpisodes,
              active: false,
            ),
            _drawerItem(
              context,
              icon: Icons.public_outlined,
              title: l10n.tabLocations,
              active: false,
            ),
            const Spacer(),
            Divider(color: designs.textSecondary.withValues(alpha: 0.15)),
            _drawerItem(
              context,
              icon: Icons.logout,
              title: l10n.menuSignOut,
              active: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool active,
  }) {
    final designs = context.designs;
    final color = active ? designs.primary : designs.textSecondary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: active
            ? designs.primary.withValues(alpha: 0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 14),
          Text(
            title,
            style: context.textTheme.titleSmall?.copyWith(
              color: active ? designs.textPrimary : designs.textSecondary,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}