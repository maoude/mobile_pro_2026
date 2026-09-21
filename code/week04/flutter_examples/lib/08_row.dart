// =====================================================================
// Week 4 - Slide 24: Arranging widgets horizontally with Row
// =====================================================================
// WHAT YOU LEARN
//   * Row places widgets side by side; it is the horizontal version of
//     Column. Rows and columns can be NESTED: here a Row is one of the
//     children of a Column.
//   * mainAxisAlignment says how the children are spread along the main
//     axis (left to right for a Row). MainAxisAlignment.spaceEvenly leaves
//     equal space between and around the children.
//
// HOW TO RUN
//   flutter run -t lib/08_row.dart      (this is also what "flutter run" starts)
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   App bar "Home Page". Under it, the lines
//       Text 1
//       Text 2
//   centered, and below them ONE line with three texts spread evenly:
//       Text 3      Text 4      Text 5
// =====================================================================

import 'package:flutter/material.dart';

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
          children: <Widget>[
            SizedBox(height: 16.0),
            MyTextWidget(text: 'Text 1'),
            SizedBox(height: 16.0),
            MyTextWidget(text: 'Text 2'),
            SizedBox(height: 16.0),
            // A Row nested inside the Column.
            Row(
              // Spread the three children evenly across the width.
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MyTextWidget(text: 'Text 3'),
                MyTextWidget(text: 'Text 4'),
                MyTextWidget(text: 'Text 5'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//#endregion notes
