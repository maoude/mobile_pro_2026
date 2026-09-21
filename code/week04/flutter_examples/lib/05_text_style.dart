// =====================================================================
// Week 4 - Slide 18: Changing the text style
// =====================================================================
// WHAT YOU LEARN
//   * The Text widget has a "style" field. Give it a TextStyle to change
//     the font size, the color, the weight...
//   * fontSize is measured in LOGICAL pixels (see 09_logical_pixels.dart).
//   * Colors.deepPurple is one of the ready-made colors of Flutter.
//
// HOW TO RUN
//   flutter run -t lib/05_text_style.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   Same page as before (app bar "Home Page"), but the words  Hello World
//   are now larger (size 24) and deep purple.
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
        appBar: AppBar(title: Text('Home Page'), centerTitle: true),
        body: Center(
          child: Text(
            'Hello World',
            style: TextStyle(fontSize: 24, color: Colors.deepPurple),
          ),
        ),
      ),
    );
  }
}

//#endregion notes
