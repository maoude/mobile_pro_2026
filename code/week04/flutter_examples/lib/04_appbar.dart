// =====================================================================
// Week 4 - Slide 17: Adding an AppBar
// =====================================================================
// WHAT YOU LEARN
//   * The Scaffold's "appBar" field takes an AppBar widget: the bar at the
//     top of the page.
//   * AppBar(title: ...) sets the title. centerTitle: true centers it (the
//     default depends on the platform).
//   * A Scaffold has several named "slots" (appBar, body, ...); each takes
//     one widget. This is the named parameters of week 2 in action.
//
// HOW TO RUN
//   flutter run -t lib/04_appbar.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A bar at the top of the page with the centered title  Home Page,
//   and the words  Hello World  in the middle of the page.
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
        appBar: AppBar(
          title: Text('Home Page'),
          centerTitle: true, // put the title in the middle of the bar
        ),
        body: Center(child: Text('Hello World')),
      ),
    );
  }
}

//#endregion notes
