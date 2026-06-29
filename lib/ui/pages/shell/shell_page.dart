import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawer_menu/flutter_drawer_menu.dart';

import '../../../di/di.dart';
import '../../../routes/router.dart';
import '../../../services/storage/token/token_service.dart';
import '../../../themes/app_theme.dart';

/// Main shell with a left navigation menu (`flutter_drawer_menu`).
///
/// Uses [AutoTabsRouter] so each section (Characters / Episodes / Locations)
/// keeps its widget state alive — which preserves the scroll position and the
/// loaded data when switching between sections via the left menu.
@RoutePage()
class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  final _menuController = DrawerMenuController();

  static const _titles = ['Персонажи', 'Эпизоды', 'Локации'];
  static const _icons = [
    Icons.people_alt_outlined,
    Icons.movie_outlined,
    Icons.public_outlined,
  ];

  Future<void> _logout() async {
    await locator<TokenService>().clear();
    if (!mounted) return;
    await context.router.replaceAll([const LoginRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return AutoTabsRouter(
      routes: const [
        CharactersRoute(),
        EpisodesRoute(),
        LocationsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return DrawerMenu(
          controller: _menuController,
          backgroundColor: designs.background,
          scrimColor: Colors.black.withValues(alpha: 0.4),
          menu: _Menu(
            activeIndex: tabsRouter.activeIndex,
            titles: _titles,
            icons: _icons,
            onSelect: (index) {
              tabsRouter.setActiveIndex(index);
              _menuController.close();
            },
            onLogout: () {
              _menuController.close();
              _logout();
            },
          ),
          body: Scaffold(
            backgroundColor: designs.background,
            appBar: AppBar(
              backgroundColor: designs.background,
              leading: IconButton(
                icon: Icon(Icons.menu, color: designs.textPrimary),
                onPressed: () => _menuController.open(),

              ),
              title: Text(
                _titles[tabsRouter.activeIndex],
                style: context.textTheme.titleLarge?.copyWith(
                  color: designs.textPrimary,
                ),
              ),
            ),
            body: child,
          ),
        );
      },
    );
  }
}

class _Menu extends StatelessWidget {
  final int activeIndex;
  final List<String> titles;
  final List<IconData> icons;
  final ValueChanged<int> onSelect;
  final VoidCallback onLogout;

  const _Menu({
    required this.activeIndex,
    required this.titles,
    required this.icons,
    required this.onSelect,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return ColoredBox(
      // Sidebar token from styles.css (darkest teal).
      color: const Color(0xFF0B1618),
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
                      'Rick & Morty',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: designs.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: designs.textSecondary.withValues(alpha: 0.15)),
            for (var i = 0; i < titles.length; i++)
              _MenuItem(
                icon: icons[i],
                title: titles[i],
                active: i == activeIndex,
                onTap: () => onSelect(i),
              ),
            const Spacer(),
            Divider(color: designs.textSecondary.withValues(alpha: 0.15)),
            _MenuItem(
              icon: Icons.logout,
              title: 'Выйти',
              active: false,
              onTap: onLogout,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool active;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final color = active ? designs.primary : designs.textSecondary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
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
        ),
      ),
    );
  }
}
