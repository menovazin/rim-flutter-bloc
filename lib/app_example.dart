import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/settings/settings_state.dart';
import 'core/snack_messages/snack_messages_view.dart';
import 'l10n/localization_helper.dart';
import 'routes/observer/app_observer.dart';
import 'routes/router.dart';


class AppExample extends StatelessWidget {
  final AppRouter router;

  const AppExample({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SettingsState>();
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(state.textScaleFactor),
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: state.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: state.themeType.themeData(fontFamily: state.fontFamily),
        routerConfig: router.config(
          navigatorObservers: () => [AppObserver()],
          // Always start at the splash gate; it reads the token from
          // flutter_secure_storage and redirects to Shell or Login.
          deepLinkBuilder: (deepLink) async {
            return const DeepLink([SplashRoute()]);
          },
        ),

        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(child: child),
              const SnackMessagesView(),
            ],
          );
        },
      ),
    );
  }
}
