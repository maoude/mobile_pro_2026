// =====================================================================
// Week 4 - Going further (not in the slides): more Scaffold features
// =====================================================================
// WHAT YOU LEARN
//   * A Scaffold has several "slots", each filled with one widget:
//       appBar               the bar at the top
//       body                 the main content
//       bottomNavigationBar  a bar at the bottom (here a BottomAppBar)
//     and settings such as backgroundColor.
//   * The Scaffold expands to fill the whole screen, and it adjusts by
//     itself when the on-screen keyboard appears: you write no extra code.
//   * Use ONE Scaffold per page, as the top-level structure of that page.
//     Do not nest a Scaffold inside another Scaffold.
//   * Card is a Material "card": a rectangle with rounded corners and a
//     small shadow, used to group content.
//   * Padding adds space around its child.
//
// HOW TO RUN
//   flutter run -t lib/11_scaffold_extras.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A page with a light blue-grey background:
//     * the app bar "Scaffold extras" at the top
//     * a white Card in the middle with the text  A Card in the body
//     * a bar at the bottom of the screen with the text  Bottom bar
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
        appBar: AppBar(title: const Text('Scaffold extras')),
        // The color behind everything else on the page.
        backgroundColor: Colors.blueGrey.shade50,
        body: const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24), // 24 logical pixels on every side
              child: Text('A Card in the body'),
            ),
          ),
        ),
        // A bar at the bottom of the page.
        bottomNavigationBar: const BottomAppBar(
          child: Center(child: Text('Bottom bar')),
        ),
      ),
    );
  }
}

//#endregion notes
