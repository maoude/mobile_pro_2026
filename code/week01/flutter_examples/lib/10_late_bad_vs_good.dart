// =====================================================================
// Lecture 1.1, section 2.4: "late" - the bad way and the good way
// =====================================================================
// WHAT YOU LEARN
//   * "late" promises Dart: "I will give this variable a value before I
//     read it". Dart then skips the null check at compile time and checks
//     at RUN time instead.
//   * BAD:  the value is never assigned -> reading it crashes
//           (LateInitializationError) the first time build() runs.
//   * GOOD: assign it in initState(), which always runs before build().
//
// HOW TO RUN
//   flutter run -t lib/10_late_bad_vs_good.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The demo shows GoodExample: the text  "ready"  in the middle.
//   To see the crash, change "GoodExample()" to "BadExample()" in
//   LateDemoApp below and hot restart: Flutter shows a red error screen
//   ("LateInitializationError: ... has not been initialized").
// =====================================================================

import 'package:flutter/material.dart';

// ---------------- BAD ----------------
class BadExample extends StatefulWidget {
  const BadExample({super.key});

  @override
  State<BadExample> createState() => _BadExampleState();
}

class _BadExampleState extends State<BadExample> {
  late String data; // [BAD] nothing ever assigns it

  @override
  Widget build(BuildContext context) {
    return Text(data); // [CRASH] data is read before it has a value
  }
}

// ---------------- GOOD ----------------
class GoodExample extends StatefulWidget {
  const GoodExample({super.key});

  @override
  State<GoodExample> createState() => _GoodExampleState();
}

class _GoodExampleState extends State<GoodExample> {
  late String data;

  @override
  void initState() {
    super.initState();
    data = 'ready'; // [GOOD] assigned before the first build()
  }

  @override
  Widget build(BuildContext context) {
    return Text(data);
  }
}

// ---------------- Demo app (only used when this file is run) ----------------
void main() => runApp(const LateDemoApp());

class LateDemoApp extends StatelessWidget {
  const LateDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        // Swap GoodExample() for BadExample() to see the crash.
        body: Center(child: GoodExample()),
      ),
    );
  }
}
