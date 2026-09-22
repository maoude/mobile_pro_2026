// =====================================================================
// Week 5 - The sum application, in several files (libraries)
// =====================================================================
// WHAT YOU LEARN
//   * A real app is not written in one file. Every .dart file is a LIBRARY,
//     and we spread the classes over several libraries:
//         main.dart           starts the app (this file)
//         home.dart           the page: the Home widget and its State
//         my_text_field.dart  our reusable text field
//   * import 'home.dart';  makes the classes of another file usable here. A
//     path without "package:" is relative to the current file. Files of the
//     Flutter SDK use "package:flutter/material.dart".
//   * Privacy is per LIBRARY, not per class (week 3): a name that starts
//     with an underscore, like _HomeState, can only be used inside its own
//     file. That is why home.dart can hide _HomeState from main.dart.
//   * The app: the user types X and Y in two text fields and presses the SUM
//     button; the sum is shown in a Text. It uses everything of this week:
//     a stateful page, the TextField, a callback, and ElevatedButton.
//
// HOW TO RUN
//   flutter run -t lib/05_sum_app/main.dart
//   (see ../../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   An app bar "Home Page". Under it the text "Sum: ", two text fields with
//   the hints "Enter X" and "Enter Y", and a button "SUM".
//     * Type 2.5 in X and 4 in Y, press SUM: the text becomes "Sum: 6.5".
//     * Leave a field empty, or type something that is not a number, and
//       press SUM: the text becomes "Sum: Please fill all fields".
// =====================================================================

import 'package:flutter/material.dart';

import 'home.dart'; // the Home widget is defined in home.dart

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CSCI410 Week 5',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
