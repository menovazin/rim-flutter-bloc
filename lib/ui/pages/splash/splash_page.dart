import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../routes/router.dart';
import '../../../services/storage/token/token_service.dart';
import '../../../themes/app_theme.dart';

/// Splash / entry gate.
///
/// Checks `flutter_secure_storage` for a token and redirects to the main shell
/// (token present) or to the fake login screen (no token).
@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _decideStartDestination();
  }

  Future<void> _decideStartDestination() async {
    final token = await locator<TokenService>().getToken();
    // Small delay so the splash is visible on fast devices.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    if (token.isNotEmpty) {
      await context.router.replaceAll([const ShellRoute()]);
    } else {
      await context.router.replaceAll([const LoginRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return Scaffold(
      backgroundColor: designs.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.science_outlined, size: 96, color: designs.primary),
            const SizedBox(height: 24),
            Text(
              'Rick & Morty',
              style: context.textTheme.headlineMedium?.copyWith(
                color: designs.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            CircularProgressIndicator(color: designs.primary),
          ],
        ),
      ),
    );
  }
}
