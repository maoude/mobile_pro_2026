// =====================================================================
// Week 5 - The stateful widget: two classes and setState
// =====================================================================
// WHAT YOU LEARN
//   * An interactive app reacts to the user WHILE it runs. In Flutter we
//     build one with a StatefulWidget.
//   * A stateful widget is made of TWO classes:
//       1. the widget class (extends StatefulWidget). It is immutable and only
//          has createState(), which returns the State object.
//       2. the State class (extends State<TheWidget>). It keeps the data that
//          changes, and it has the build method.
//     In Android Studio, type "stf" and choose "stful" to write both.
//   * The State class redraws the widget when its data changes. We tell
//     Flutter that the data changed by calling setState(() { ... }): Flutter
//     runs the function, then calls build again, and the screen is updated.
//   * The name of the State class starts with an underscore (_CounterPageState):
//     in Dart this makes it private to the file (week 3).
//
// HOW TO RUN
//   flutter run -t lib/00_stateful_counter.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   An app bar with the centered title "Counter". In the middle, the text
//   "Count: 0" and a button "Add 1". Each tap on the button adds 1 to the
//   number.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterPage(),
    );
  }
}

// 1. The widget class: immutable, it only creates its State.
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

// 2. The State class: it keeps the data that changes and builds the screen.
class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  void _increment() {
    // setState runs the function, then Flutter calls build again.
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Count: $_count', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _increment,
              child: const Text('Add 1'),
            ),
          ],
        ),
      ),
    );
  }
}
