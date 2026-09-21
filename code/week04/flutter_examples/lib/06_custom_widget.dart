// =====================================================================
// Week 4 - Slides 19 to 22: Creating a custom widget
// =====================================================================
// WHAT YOU LEARN
//   * You can turn a piece of UI into your own widget class, so it can be
//     reused. In Android Studio: right-click the widget, Refactor, "Extract
//     Flutter Widget". In VS Code: put the cursor on the widget, press
//     Ctrl+. (Quick Fix) and choose "Extract Widget".
//   * A widget can take parameters. Here MyTextWidget has a "text" field
//     and a required named parameter, so the caller chooses the words:
//         MyTextWidget(text: 'Text 1')
//   * "required this.text" is the constructor shorthand of week 3.
//
// HOW TO RUN
//   flutter run -t lib/06_custom_widget.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   App bar "Home Page". Under it, the words  Text 1  centered horizontally,
//   in size-24 deep purple (the style of the previous example).
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

//#region notes
// The custom widget: it shows any text in the purple style.
class MyTextWidget extends StatelessWidget {
  final String text; // we add a field called text
  // ...and make it a required parameter of the constructor
  const MyTextWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text, // the field replaces the fixed 'Hello World'
        style: TextStyle(fontSize: 24, color: Colors.deepPurple),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Home Page'), centerTitle: true),
        // now we can pass any text to the widget
        body: MyTextWidget(text: 'Text 1'),
      ),
    );
  }
}

//#endregion notes
