import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/logs/logs_state.dart';
import 'core/providers.dart';
import 'core/settings/settings_state.dart';
import 'core/snack_messages/snack_messages_view.dart';
import 'di/di.dart';
import 'l10n/localization_helper.dart';
import 'di/models/di_environment.dart';
import 'routes/observer/app_observer.dart';
import 'routes/router.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await configureDependencies(DiEnvironment.dev.env);

  await KitInitializer.initialize();

  LogsState.instance.initialize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0x00000000),
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const AppRoot());
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late final _router = di.appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: App(router: _router),
    );
  }
}

class App extends StatelessWidget {
  final AppRouter router;

  const App({super.key, required this.router});

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