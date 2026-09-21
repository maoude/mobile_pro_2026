// =====================================================================
// Week 4, part 2 - Widget types: visible widgets and layout widgets
// =====================================================================
// WHAT YOU LEARN
//   * Widgets fall into two big families:
//       VISIBLE widgets show something or take input:
//           Text, buttons, Image, Icon
//       LAYOUT widgets are invisible; they place and size other widgets:
//           Column, Row, Center, Padding, Stack, Scaffold
//   * Text: textAlign and style (font size, weight, color...).
//   * Buttons: ElevatedButton, TextButton and OutlinedButton. Each one has
//     a "child" (its label) and an "onPressed" function that runs on a tap.
//     (Older tutorials use FlatButton and RaisedButton: they were replaced
//     long ago by TextButton and ElevatedButton.)
//   * Image: Image.asset (a file in your project), Image.network (a URL),
//     Image.file (a file on the device) and Image.memory (bytes in memory).
//     An asset image must be listed under "assets:" in pubspec.yaml.
//   * Icon: one of the built-in icons, with a size and a color.
//   * Padding adds space around a widget; Stack draws widgets ON TOP of each
//     other. You do not write "new" before a widget: Dart does not need it.
//
// HOW TO RUN
//   flutter run -t lib/13_widget_types.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A scrollable page with two parts.
//   "Visible widgets": a bold centered text  Hello, Flutter!, three buttons
//   (Elevated, Text, Outlined), the small blue logo image, a red heart icon,
//   and a line  Last button: none. Tapping a button changes that line to
//   Last button: ElevatedButton (or TextButton, OutlinedButton).
//   "Layout widgets": a Row of three padded labels, and a Stack: a red
//   square drawn on top of a bigger blue square, with the word Stack on top.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const WidgetTypesApp());

class WidgetTypesApp extends StatelessWidget {
  const WidgetTypesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Widget types')),
        body: const SingleChildScrollView(child: WidgetGallery()),
      ),
    );
  }
}

//#region notes
// Stateful, because the page remembers which button was tapped last.
class WidgetGallery extends StatefulWidget {
  const WidgetGallery({super.key});

  @override
  State<WidgetGallery> createState() => _WidgetGalleryState();
}

class _WidgetGalleryState extends State<WidgetGallery> {
  String _lastButton = 'none';

  void _tapped(String name) => setState(() => _lastButton = name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16), // space around the whole page
      child: Column(
        children: [
          // ---------------- Visible widgets ----------------
          const Text(
            'Hello, Flutter!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _tapped('ElevatedButton'),
                child: const Text('Elevated'),
              ),
              TextButton(
                onPressed: () => _tapped('TextButton'),
                child: const Text('Text'),
              ),
              OutlinedButton(
                onPressed: () => _tapped('OutlinedButton'),
                child: const Text('Outlined'),
              ),
            ],
          ),
          // An image from the project's assets folder.
          Image.asset('assets/logo.png', width: 64, height: 64),
          const Icon(Icons.favorite, color: Colors.red, size: 35),
          Text('Last button: $_lastButton'),

          // ---------------- Layout widgets ----------------
          const SizedBox(height: 24),
          // Row: side by side. Padding: space around each label.
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(padding: EdgeInsets.all(8), child: Text('Row 1')),
              Padding(padding: EdgeInsets.all(8), child: Text('Row 2')),
              Padding(padding: EdgeInsets.all(8), child: Text('Row 3')),
            ],
          ),
          // Stack: the children are drawn on top of each other, in order.
          Stack(
            alignment: Alignment.center, // centre the smaller ones
            children: [
              Container(width: 120, height: 120, color: Colors.blue),
              Container(width: 70, height: 70, color: Colors.red.shade300),
              const Text('Stack', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}

//#endregion notes
