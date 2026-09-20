// =====================================================================
// Lecture 1.1, section 3.2: Stateless vs Stateful widgets
// =====================================================================
// WHAT YOU LEARN
//   * StatelessWidget: pure UI, nothing inside it changes.
//   * StatefulWidget: has a State object that stores data that CHANGES
//     while the app runs (here: the click counter).
//   * The widget class is immutable; the mutable data lives in the State.
//   * setState(() { ... }) changes the data AND tells Flutter to call
//     build() again. Changing _count without setState would not redraw.
//
// HOW TO RUN
//   flutter run -t lib/15_counter_button.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A button in the centre labelled "Count: 0".
//   Every tap adds 1: "Count: 1", "Count: 2", "Count: 3", ...
// =====================================================================

import 'package:flutter/material.dart';

// The widget itself: immutable, it only creates its State.
class CounterButton extends StatefulWidget {
  const CounterButton({super.key});

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

// The State: keeps the data that changes. The leading "_" makes the class
// private to this file.
class _CounterButtonState extends State<CounterButton> {
  int _count = 0; // the changing data

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // setState runs the function, then rebuilds the widget with the new
      // value of _count.
      onPressed: () => setState(() => _count++),
      child: Text('Count: $_count'),
    );
  }
}

// ---------------- Demo app (only used when this file is run) ----------------
void main() => runApp(const CounterApp());

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: CounterButton())),
    );
  }
}
