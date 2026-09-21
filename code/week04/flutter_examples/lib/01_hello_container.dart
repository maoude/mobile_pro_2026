// =====================================================================
// Week 4 - Slides 10 to 12: The smallest Flutter app
// =====================================================================
// WHAT YOU LEARN
//   * import 'package:flutter/material.dart' gives access to the widgets.
//   * main() calls runApp(widget): it makes that widget the root of the
//     app and fills the whole screen with it.
//   * "void main() => runApp(...)" is the arrow (lambda) form of a function
//     with one expression (week 2).
//   * MyApp is a StatelessWidget: its build() method returns the widget
//     to show. In Android Studio type "st" and choose "stless" to create it.
//   * "const" (const MyApp(), const constructor) lets Flutter reuse the
//     widget instead of rebuilding it, so the app runs faster.
//   * An EMPTY Container() shows a black screen; giving it a color, for
//     example Colors.white, paints it.
//
// HOW TO RUN
//   flutter run -t lib/01_hello_container.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A completely white screen (nothing else).
// =====================================================================

import 'package:flutter/material.dart';

// Start the app: MyApp is the root widget. The lambda form is the same as
//     void main() { runApp(const MyApp()); }
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  // Older tutorials write: const MyApp({Key? key}) : super(key: key);
  // "super.key" is the shorter form that current Flutter versions use.
  const MyApp({super.key});

  // build() describes what this widget looks like.
  @override
  Widget build(BuildContext context) {
    // A widget that fills the screen with a color.
    return Container(color: Colors.white);
  }
}
