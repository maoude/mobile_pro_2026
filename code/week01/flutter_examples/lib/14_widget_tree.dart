// =====================================================================
// Lecture 1.1, section 3.1: The widget tree - "everything is a widget"
// =====================================================================
// WHAT YOU LEARN
//   * runApp() takes ONE widget: the root of the widget tree.
//   * The tree here is:
//         MaterialApp            (app-wide settings: title, theme, ...)
//           -> Scaffold          (basic page structure)
//                -> Center       (centres its child)
//                     -> Text    (the words on screen)
//   * Widgets are immutable configuration objects: to change the UI you
//     build a new tree and Flutter updates only what changed.
//   * useMaterial3: true selects the current Material Design look.
//
// HOW TO RUN
//   flutter run                          (lib/main.dart runs this example)
//   flutter run -t lib/14_widget_tree.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A white page with the word  Hello  in the centre.
//   The window / task title is "Business Card App".
// =====================================================================

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Card App', // used by the operating system
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(body: Center(child: Text('Hello'))),
    );
  }
}

// main() starts the app by giving Flutter the root widget.
void main() => runApp(const MyApp());
