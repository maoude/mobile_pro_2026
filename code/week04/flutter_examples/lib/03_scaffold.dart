// =====================================================================
// Week 4 - Slide 16: Adding a Scaffold
// =====================================================================
// WHAT YOU LEARN
//   * Scaffold gives a page its basic Material Design structure: a
//     background, and (later) an app bar, buttons, drawers and so on.
//   * Text placed inside a Scaffold gets a normal, readable style: the
//     yellow-underlined warning style of the previous example is gone.
//   * The Scaffold's "body" field holds the main content of the page.
//
// HOW TO RUN
//   flutter run -t lib/03_scaffold.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A light page with the words  Hello World  in the middle, in a small,
//   normal dark text (no red, no underline).
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

//#region notes
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // "body" is the main content of the Scaffold.
        body: Center(child: Text('Hello World')),
      ),
    );
  }
}

//#endregion notes
