// =====================================================================
// Week 5 - Why setState? Changing a variable is not enough
// =====================================================================
// WHAT YOU LEARN
//   * The screen shows what build returned the LAST time it ran. Changing a
//     variable of the State class does not run build again: the screen keeps
//     showing the old value.
//   * setState(() { ... }) changes the variable AND tells Flutter to call
//     build again. Only then does the screen show the new value.
//   * This page has two buttons that both add 1 to _value:
//       "Add 1 (with setState)"     changes the variable inside setState
//       "Add 1 (without setState)"  changes the variable only
//     The second button changes the data, but you see nothing. The change
//     appears later, when another setState makes Flutter build the page again.
//   * Rule: whenever the data shown on the screen changes, do it in setState.
//
// HOW TO RUN
//   flutter run -t lib/01_setstate_needed.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The text "Value: 0" and two buttons.
//     * Tap "Add 1 (without setState)" three times: the text stays "Value: 0".
//     * Then tap "Add 1 (with setState)" once: the text jumps to "Value: 4"
//       (the three hidden additions and this one).
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SetStateDemo(),
    );
  }
}

class SetStateDemo extends StatefulWidget {
  const SetStateDemo({super.key});

  @override
  State<SetStateDemo> createState() => _SetStateDemoState();
}

class _SetStateDemoState extends State<SetStateDemo> {
  int _value = 0;

  void _addWithSetState() {
    setState(() {
      _value++;
    });
  }

  void _addWithoutSetState() {
    _value++; // the variable changes, but build is NOT called again
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('setState'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Value: $_value', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addWithSetState,
              child: const Text('Add 1 (with setState)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _addWithoutSetState,
              child: const Text('Add 1 (without setState)'),
            ),
          ],
        ),
      ),
    );
  }
}
