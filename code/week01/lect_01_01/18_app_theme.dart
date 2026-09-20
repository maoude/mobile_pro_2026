// Source: 002_lect_01_01.tex, section 4.2 Theming
// Flutter; needs an import of package:flutter/material.dart.

class AppTheme {
  static ThemeData light() => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
  );
}
