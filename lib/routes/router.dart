import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../domain/entities/character.dart';
import '../domain/entities/episode.dart';
import '../domain/entities/location.dart';
import '../ui/pages/auth/login_page.dart';
import '../ui/pages/characters/character_detail_page.dart';
import '../ui/pages/characters/characters_page.dart';
import '../ui/pages/episodes/episode_detail_page.dart';
import '../ui/pages/episodes/episodes_page.dart';
import '../ui/pages/locations/location_detail_page.dart';
import '../ui/pages/locations/locations_page.dart';
import '../ui/pages/shell/shell_page.dart';
import '../ui/pages/splash/splash_page.dart';

part 'router.gr.dart';

Widget _iosTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    )),
    child: SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-0.3, 0.0),
      ).animate(CurvedAnimation(
        parent: secondaryAnimation,
        curve: Curves.easeOut,
      )),
      child: child,
    ),
  );
}

@AutoRouterConfig(replaceInRouteName: 'Page|View|Tab|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
        transitionsBuilder: _iosTransitionBuilder,
        duration: const Duration(milliseconds: 350),
        reverseDuration: const Duration(milliseconds: 350),
        barrierColor: Colors.transparent,
      );

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: SplashRoute.page, path: '/'),
      AutoRoute(page: LoginRoute.page, path: '/login'),
      AutoRoute(
        page: ShellRoute.page,
        path: '/shell',
        children: [
          AutoRoute(page: CharactersRoute.page, path: 'characters', initial: true),
          AutoRoute(page: EpisodesRoute.page, path: 'episodes'),
          AutoRoute(page: LocationsRoute.page, path: 'locations'),
        ],
      ),
      AutoRoute(page: CharacterDetailRoute.page, path: '/character-detail'),
      AutoRoute(page: EpisodeDetailRoute.page, path: '/episode-detail'),
      AutoRoute(page: LocationDetailRoute.page, path: '/location-detail'),
    ];
  }
}
