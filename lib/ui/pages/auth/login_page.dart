import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../routes/router.dart';
import '../../../services/storage/token/token_service.dart';
import '../../../themes/app_theme.dart';

/// Fake login screen (no real authentication).
///
/// On "Войти" it generates a fake token, persists it in
/// `flutter_secure_storage` (via [TokenService]) and navigates to the main
/// shell — regardless of the entered name (or an empty one).
@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);

    final name = _nameController.text.trim();
    final token =
        'fake_${name.isEmpty ? 'guest' : name}_${DateTime.now().millisecondsSinceEpoch}';
    await locator<TokenService>().saveToken(token);

    if (!mounted) return;
    await context.router.replaceAll([const ShellRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return Scaffold(
      backgroundColor: designs.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.science_outlined,
                    size: 72,
                    color: designs.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Rick & Morty',
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: designs.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Войдите, чтобы открыть портал',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: designs.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _nameController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _onLogin(),
                    style: TextStyle(color: designs.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Имя',
                      labelStyle: TextStyle(color: designs.textSecondary),
                      filled: true,
                      fillColor: designs.surface,
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: designs.textSecondary,
                      ),
                      // React: input rounded-md (8px), border-input.
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: designs.textSecondary.withValues(alpha: 0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: designs.primary),
                      ),

                    ),
                  ),
                  const SizedBox(height: 24),
                  // React: Button size=lg -> h-10, rounded-md (8px),
                  // text-sm (14px) font-medium (500), px-8.
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _onLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: designs.primary,
                        foregroundColor: designs.onPrimary,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text(
                              'Войти',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
