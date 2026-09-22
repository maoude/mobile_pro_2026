// =====================================================================
// Week 5 - Our first interactive application: "You typed: ..."
// =====================================================================
// WHAT YOU LEARN
//   * The application of the slides: a Text and a TextField. What the user
//     types in the TextField is shown at once in the Text.
//   * How the pieces work together:
//       _text          a String in the State class: the text to show
//       updateText     a method that changes _text INSIDE setState
//       onChanged      the TextField calls updateText each time the text
//                      changes, giving it the new text
//   * The TextField is inside a SizedBox: a SizedBox gives its child a width
//     and a height (here 300 x 50 logical pixels). Without it, a TextField
//     inside a Column would try to be as wide as it can.
//   * This example has everything in ONE file. Example 05 puts the same kind
//     of app in several files (libraries).
//
// HOW TO RUN
//   flutter run -t lib/03_you_typed.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   An app bar "Home Page". Under it the text "You typed: " and a text field
//   with a frame and the hint "Enter some text". Type "Hello students": the
//   text changes after each letter to "You typed: Hello students".
// =====================================================================

import 'package:flutter/material.dart';

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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // A field to hold the TextField's text.
  String _text = '';

  // Called when the text of the TextField changes. We need setState so that
  // the State class redraws the widget.
  void updateText(String text) {
    setState(() {
      _text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Text('You typed: $_text', style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 300.0,
              height: 50.0,
              child: TextField(
                style: const TextStyle(fontSize: 18.0),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter some text',
                ),
                onChanged: (text) {
                  updateText(text); // call the updateText method
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
