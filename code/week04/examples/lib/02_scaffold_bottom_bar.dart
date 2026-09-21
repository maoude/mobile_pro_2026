// =====================================================================
// Week 4, part 3 - Recipe: the Scaffold, a bottom bar and a floating button
// =====================================================================
// WHAT YOU LEARN
//   * A Scaffold is the top-level container of a Material page. It EXPANDS to
//     fill the screen, and it adapts by itself when the screen changes. When
//     the on-screen keyboard opens, the body gets smaller: you write no code
//     for that (Scaffold.resizeToAvoidBottomInset is true by default).
//   * Use ONE Scaffold per page, at the top, inside MaterialApp. Do not nest
//     a Scaffold inside another Scaffold.
//   * The slots used here:
//       appBar               the bar at the top
//       backgroundColor      the color of the whole page
//       body                 the content
//       bottomNavigationBar  a bar at the bottom: a BottomAppBar
//       floatingActionButton the round button that floats over the content
//   * A BottomAppBar has a color and a shape. With CircularNotchedRectangle
//     the bar has a round notch, and a floating button placed with
//     FloatingActionButtonLocation.centerDocked sits in that notch.
//   * A floating button usually changes something on the page (here a
//     counter). Data that changes means a StatefulWidget and setState.
//
// HOW TO RUN
//   flutter run -t lib/02_scaffold_bottom_bar.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A blue-grey page with the app bar "Scaffold Example". In the middle, a
//   white card that says  Taps: 0  and has a text field. At the bottom, a
//   blue bar with the label bottomNavigationBar on the left and a round
//   "+" button docked in the middle of the bar. Each tap on the "+" adds 1
//   to the counter. Tap the text field on a phone or in a small window:
//   when the keyboard opens, the card moves up so that it stays visible.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Example';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: ScaffoldDemo(),
    );
  }
}

class ScaffoldDemo extends StatefulWidget {
  const ScaffoldDemo({super.key});

  @override
  State<ScaffoldDemo> createState() => _ScaffoldDemoState();
}

class _ScaffoldDemoState extends State<ScaffoldDemo> {
  int _taps = 0;

  void _addTap() {
    setState(() {
      _taps++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scaffold Example')),
      backgroundColor: Colors.blueGrey,
      body: Center(child: _buildCardWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTap,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        color: Colors.blueAccent,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('bottomNavigationBar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardWidget() {
    return SizedBox(
      height: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Taps: $_taps'),
              const SizedBox(height: 12),
              const SizedBox(
                width: 240,
                child: TextField(
                  decoration: InputDecoration(labelText: 'Type here'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
