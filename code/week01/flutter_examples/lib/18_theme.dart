// =====================================================================
// Lecture 1.1, section 4.2: Theming
// =====================================================================
// WHAT YOU LEARN
//   * One ThemeData defines the look of the whole app (colours, fonts,
//     shapes) in ONE place, instead of styling every widget by hand.
//   * ColorScheme.fromSeed(seedColor: ...) generates a full, harmonious
//     colour palette from a single colour (Material 3).
//   * Widgets read the theme automatically: the AppBar and the button below
//     get their colours from it without any colour code of their own.
//
// HOW TO RUN
//   flutter run -t lib/18_theme.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A page with a blue-tinted app bar titled "Theming" and, in the centre,
//   a button labelled "Themed button". All colours are shades generated
//   from the blue seed colour 0xFF1976D2.
// =====================================================================

import 'package:flutter/material.dart';

class AppTheme {
  // A static method: call it without creating an AppTheme object.
  static ThemeData light() => ThemeData(
        useMaterial3: true,
        // The seed colour is 0xAARRGGBB: AA=FF (opaque), then red/green/blue.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
      );
}

// ---------------- Demo app (only used when this file is run) ----------------
void main() => runApp(const ThemeDemoApp());

class ThemeDemoApp extends StatelessWidget {
  const ThemeDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(), // the whole app uses this theme
      home: Scaffold(
        appBar: AppBar(title: const Text('Theming')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Themed button'),
          ),
        ),
      ),
    );
  }
}
