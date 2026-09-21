// =====================================================================
// Week 4 - Slides 2 to 4: Everything is a widget (stateless vs stateful)
// =====================================================================
// WHAT YOU LEARN
//   * A Flutter app is a tree of WIDGETS. A widget is a Dart class that
//     describes a piece of the screen (text, icon, button, checkbox...).
//   * Every widget you write extends one of two classes:
//       StatelessWidget  - has fixed content. To show something different,
//                          a parent must build a new widget. Examples:
//                          Text, Icon, ElevatedButton.
//       StatefulWidget   - keeps data that changes while the app runs and
//                          redraws itself with setState(). Examples:
//                          Checkbox, Radio, TextField.
//   * Below: Greeting is stateless (it only shows its name), AcceptTerms is
//     stateful (it remembers whether the checkbox is ticked).
//
// HOW TO RUN
//   flutter run -t lib/00_stateless_vs_stateful.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A page with the text  Hello, Rami  and, under it, an unticked checkbox
//   with the text  Not accepted.
//   Tapping the checkbox ticks it and the text changes to  Accepted;
//   tapping again goes back to  Not accepted.
// =====================================================================

import 'package:flutter/material.dart';

// ---------------- Stateless: the content never changes by itself ----------------
class Greeting extends StatelessWidget {
  final String name; // fixed input: set once, never modified
  const Greeting({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text('Hello, $name');
  }
}

// ---------------- Stateful: the content changes at run time ----------------
// The widget class is immutable; the changing data lives in its State object.
class AcceptTerms extends StatefulWidget {
  const AcceptTerms({super.key});

  @override
  State<AcceptTerms> createState() => _AcceptTermsState();
}

class _AcceptTermsState extends State<AcceptTerms> {
  bool _accepted = false; // the data that changes

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: _accepted,
          // setState changes the data AND makes Flutter call build() again.
          onChanged: (value) => setState(() => _accepted = value ?? false),
        ),
        Text(_accepted ? 'Accepted' : 'Not accepted'),
      ],
    );
  }
}

// ---------------- Demo app (only used when this file is run) ----------------
void main() => runApp(const StatelessStatefulApp());

class StatelessStatefulApp extends StatelessWidget {
  const StatelessStatefulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Greeting(name: 'Rami'), AcceptTerms()],
          ),
        ),
      ),
    );
  }
}
