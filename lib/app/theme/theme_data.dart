import 'package:flutter/material.dart';
import 'theme_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ThemeColors.background,
      colorScheme: _colorScheme,
      appBarTheme: _appBarTheme,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ThemeColors.accent,
        linearTrackColor: Color(0xFF2A2A2A),
        linearMinHeight: 8,
      ),
    );
  }

  static final _colorScheme = ColorScheme.fromSeed(
    seedColor: ThemeColors.accent,
    brightness: Brightness.dark,
    surface: ThemeColors.surface,
  );

  static final _appBarTheme = AppBarTheme(
    toolbarHeight: 50,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: ThemeColors.white,
    ),
    backgroundColor: ThemeColors.background,
  );
}