// =====================================================================
// Week 4 - Slide 23: Arranging widgets vertically with Column
// =====================================================================
// WHAT YOU LEARN
//   * Column places several widgets one below the other. Its "children"
//     field is a LIST of widgets (<Widget>[ ... ], see week 2).
//   * SizedBox(height: 16.0) is an empty box that adds vertical space
//     between widgets.
//   * The custom MyTextWidget of the previous example is reused twice with
//     different texts: that is the point of making it a widget.
//
// HOW TO RUN
//   flutter run -t lib/07_column.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   App bar "Home Page". Under it, two purple lines centered horizontally,
//   one below the other, with a gap above each:
//       Text 1
//       Text 2
// =====================================================================

import 'package:flutter/material.dart';

// Reuse the custom widget from the previous example.
import '06_custom_widget.dart' show MyTextWidget;

void main() => runApp(const MyApp());

//#region notes
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Home Page'), centerTitle: true),
        body: Column(
          // The widgets of the column, from top to bottom.
          children: <Widget>[
            SizedBox(height: 16.0), // 16 logical pixels of empty space
            MyTextWidget(text: 'Text 1'),
            SizedBox(height: 16.0),
            MyTextWidget(text: 'Text 2'),
          ],
        ),
      ),
    );
  }
}

//#endregion notes
