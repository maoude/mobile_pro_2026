// =====================================================================
// Week 4 - Slides 13 to 15: Displaying text with Text, Center, MaterialApp
// =====================================================================
// WHAT YOU LEARN
//   * Text('...') shows a line of text.
//   * MaterialApp is the root of an app that uses Material Design. Its
//     required field "home" is the widget shown on the screen.
//   * Center centers its "child" widget. Without it the text sits in the
//     top-left corner of the screen.
//   * Widgets are nested: MaterialApp -> Center -> Text.
//   * Careful: MaterialApp alone gives the text NO style. Flutter then uses
//     a warning style (red, underlined in yellow) to tell the developer that
//     the text should be inside a Material widget such as Scaffold. The next
//     example (03_scaffold.dart) fixes it.
//
// HOW TO RUN
//   flutter run -t lib/02_hello_text.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The words  Hello World  in the middle of the screen, in an ugly style:
//   large red text with a double yellow underline. On a black background
//   on some devices.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

//#region notes
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // "home" is the widget shown on the screen.
      home: Center(
        // "child" is the widget that Center places in the middle.
        child: Text('Hello World'),
      ),
    );
  }
}

//#endregion notes
