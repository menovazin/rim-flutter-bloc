import 'package:flutter/material.dart';

@immutable
class CustomDesigns extends ThemeExtension<CustomDesigns> {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color error;
  final Color onPrimary;
  final Color onSecondary;
  final Color onBackground;
  final Color onSurface;
  final Color onError;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color statusAlive;
  final Color statusDead;
  final Color statusUnknown;
  final LinearGradient gradientButton;
  final LinearGradient gradientInactiveButton;
  final LinearGradient gradientAppBar;

  /// Semantic status palette (same values light/dark; used by [CharacterStatusX]).
  static const Color statusAliveColor = Color(0xFF34E27A);
  static const Color statusDeadColor = Color(0xFFE5484D);
  static const Color statusUnknownColor = Color(0xFF9DB5B1);

  const CustomDesigns._({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.error,
    required this.onPrimary,
    required this.onSecondary,
    required this.onBackground,
    required this.onSurface,
    required this.onError,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.statusAlive,
    required this.statusDead,
    required this.statusUnknown,
    required this.gradientButton,
    required this.gradientInactiveButton,
    required this.gradientAppBar,
  });

  factory CustomDesigns.light() {
    final base = BaseDesigns.instance;
    return CustomDesigns._(
      primary: const Color(0xFF28C76F), // slightly tweaked green for light theme
      secondary: base.spicedBrick, 
      background: const Color(0xFFF3F4F6), 
      surface: const Color(0xFFFFFFFF), 
      error: base.error,
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFFFFFFFF),
      onBackground: base.abyssBlack,
      onSurface: base.abyssBlack,
      onError: const Color(0xFFFFFFFF),
      textPrimary: base.abyssBlack, 
      textSecondary: const Color(0xFF6B7280), 
      textDisabled: const Color(0xFF9CA3AF),
      statusAlive: statusAliveColor,
      statusDead: statusDeadColor,
      statusUnknown: statusUnknownColor,
      gradientButton: LinearGradient(
        colors: [const Color(0xFF28C76F), base.spicedBrick],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      gradientInactiveButton: const LinearGradient(
        colors: [Color(0xFFE5E7EB), Color(0xFFD1D5DB)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      gradientAppBar: const LinearGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  factory CustomDesigns.dark() {
    final base = BaseDesigns.instance;
    return CustomDesigns._(
      primary: base.sunsetPeach, // portal green
      secondary: base.spicedBrick, // neon purple
      background: base.abyssBlack, // deep teal
      surface: base.burntMerlot, // card teal
      error: base.error,
      onPrimary: base.black, // dark text on green
      onSecondary: base.vanillaCream,
      onBackground: base.vanillaCream,
      onSurface: base.vanillaCream,
      onError: base.vanillaCream,
      textPrimary: base.vanillaCream,
      textSecondary: base.white, // muted foreground
      textDisabled: base.white.withValues(alpha: 0.5),
      statusAlive: statusAliveColor,
      statusDead: statusDeadColor,
      statusUnknown: statusUnknownColor,
      gradientButton: LinearGradient(
        colors: [base.sunsetPeach, base.spicedBrick],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      gradientInactiveButton: LinearGradient(
        colors: [base.burntMerlot, base.abyssBlack],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      gradientAppBar: LinearGradient(
        colors: [base.black, base.abyssBlack],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }


  @override
  ThemeExtension<CustomDesigns> copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? error,
    Color? onPrimary,
    Color? onSecondary,
    Color? onBackground,
    Color? onSurface,
    Color? onError,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
    Color? statusAlive,
    Color? statusDead,
    Color? statusUnknown,
    LinearGradient? gradientButton,
    LinearGradient? gradientInactiveButton,
    LinearGradient? gradientAppBar,
  }) {
    return CustomDesigns._(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      error: error ?? this.error,
      onPrimary: onPrimary ?? this.onPrimary,
      onSecondary: onSecondary ?? this.onSecondary,
      onBackground: onBackground ?? this.onBackground,
      onSurface: onSurface ?? this.onSurface,
      onError: onError ?? this.onError,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textDisabled: textDisabled ?? this.textDisabled,
      statusAlive: statusAlive ?? this.statusAlive,
      statusDead: statusDead ?? this.statusDead,
      statusUnknown: statusUnknown ?? this.statusUnknown,
      gradientButton: gradientButton ?? this.gradientButton,
      gradientInactiveButton:
          gradientInactiveButton ?? this.gradientInactiveButton,
      gradientAppBar: gradientAppBar ?? this.gradientAppBar,
    );
  }

  @override
  ThemeExtension<CustomDesigns> lerp(
    covariant ThemeExtension<CustomDesigns>? other,
    double t,
  ) {
    if (other is! CustomDesigns) {
      return this;
    }
    return CustomDesigns._(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      error: Color.lerp(error, other.error, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      statusAlive: Color.lerp(statusAlive, other.statusAlive, t)!,
      statusDead: Color.lerp(statusDead, other.statusDead, t)!,
      statusUnknown: Color.lerp(statusUnknown, other.statusUnknown, t)!,
      gradientButton: gradientButton,
      gradientInactiveButton: gradientInactiveButton,
      gradientAppBar: gradientAppBar,
    );
  }
}

@immutable
class BaseDesigns extends ThemeExtension<BaseDesigns> {
  final Color vanillaCream;
  final Color sunsetPeach;
  final Color spicedBrick;
  final Color burntMerlot;
  final Color abyssBlack;
  final Color error;
  final Color black;
  final Color white;

  const BaseDesigns._({
    required this.vanillaCream,
    required this.sunsetPeach,
    required this.spicedBrick,
    required this.burntMerlot,
    required this.abyssBlack,
    required this.error,
    required this.black,
    required this.white,
  });

  /// Rick & Morty palette derived from design-refs/react-source/styles.css
  /// (oklch tokens converted to sRGB).
  /// - vanillaCream  -> foreground   oklch(0.96 0.02 150)  near-white green
  /// - sunsetPeach   -> primary      oklch(0.82 0.22 145)  portal green
  /// - spicedBrick   -> secondary    oklch(0.55 0.18 305)  neon purple
  /// - burntMerlot   -> card/surface oklch(0.22 0.035 200) dark teal card
  /// - abyssBlack    -> background   oklch(0.18 0.03 200)  deep teal
  /// - error         -> destructive  oklch(0.62 0.24 25)
  /// - black         -> sidebar      oklch(0.15 0.025 200) darkest teal
  /// - white         -> muted-fg     oklch(0.72 0.04 180)
  static BaseDesigns get instance {
    return const BaseDesigns._(
      vanillaCream: Color(0xFFEAF6EC),
      sunsetPeach: Color(0xFF34E27A),
      spicedBrick: Color(0xFF9B53D6),
      burntMerlot: Color(0xFF16272B),
      abyssBlack: Color(0xFF0E1B1F),
      error: Color(0xFFE5484D),
      black: Color(0xFF0B1618),
      white: Color(0xFF9DB5B1),
    );
  }


  @override
  ThemeExtension<BaseDesigns> copyWith({
    Color? vanillaCream,
    Color? sunsetPeach,
    Color? spicedBrick,
    Color? burntMerlot,
    Color? abyssBlack,
    Color? error,
    Color? black,
    Color? white,
  }) {
    return BaseDesigns._(
      vanillaCream: vanillaCream ?? this.vanillaCream,
      sunsetPeach: sunsetPeach ?? this.sunsetPeach,
      spicedBrick: spicedBrick ?? this.spicedBrick,
      burntMerlot: burntMerlot ?? this.burntMerlot,
      abyssBlack: abyssBlack ?? this.abyssBlack,
      error: error ?? this.error,
      black: black ?? this.black,
      white: white ?? this.white,
    );
  }

  @override
  ThemeExtension<BaseDesigns> lerp(
    covariant ThemeExtension<BaseDesigns>? other,
    double t,
  ) {
    if (other is! BaseDesigns) {
      return this;
    }
    return BaseDesigns._(
      vanillaCream: Color.lerp(vanillaCream, other.vanillaCream, t)!,
      sunsetPeach: Color.lerp(sunsetPeach, other.sunsetPeach, t)!,
      spicedBrick: Color.lerp(spicedBrick, other.spicedBrick, t)!,
      burntMerlot: Color.lerp(burntMerlot, other.burntMerlot, t)!,
      abyssBlack: Color.lerp(abyssBlack, other.abyssBlack, t)!,
      error: Color.lerp(error, other.error, t)!,
      black: Color.lerp(black, other.black, t)!,
      white: Color.lerp(white, other.white, t)!,
    );
  }
}
