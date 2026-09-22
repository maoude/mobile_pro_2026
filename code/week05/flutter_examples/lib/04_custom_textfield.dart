// =====================================================================
// Week 5 - A custom TextField widget and a callback function
// =====================================================================
// WHAT YOU LEARN
//   * We turn the TextField (with its SizedBox, its border and its font)
//     into our own widget, MyTextField. Then we can use the same design many
//     times, and change it in ONE place.
//   * MyTextField is a StatelessWidget: it keeps no data of its own. It is
//     given two things when it is created:
//       hint       the hintText of the TextField (a String)
//       onChanged  a FUNCTION that takes a String. It is called every time
//                  the text changes.
//   * A function passed to a widget, to be called later, is a CALLBACK.
//     The page passes its updateText method:
//         MyTextField(onChanged: updateText, hint: 'Enter some text')
//     There are no parentheses after updateText: we pass the function itself,
//     we do not call it (week 2: functions are objects).
//   * The type of the callback is ValueChanged<String>, the name Flutter gives
//     to "a function that takes a String". The slides write Function(String).
//   * The fields are final, and the constructor uses named parameters
//     marked required (week 2).
//
// HOW TO RUN
//   flutter run -t lib/04_custom_textfield.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The same screen as example 03: the text "You typed: ", and a text field
//   with the hint "Enter some text". The text follows what you type.
//   The difference is in the code: the field is now MyTextField.
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

// A reusable text field: the design is written once.
class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.hint,
    required this.onChanged,
  });

  final String hint; // the hintText of the TextField
  final ValueChanged<String> onChanged; // the callback function

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      height: 50.0,
      child: TextField(
        style: const TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
        ),
        onChanged: onChanged, // call the callback with the new text
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _text = '';

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
            // We pass the function updateText (no parentheses) and the hint.
            MyTextField(onChanged: updateText, hint: 'Enter some text'),
          ],
        ),
      ),
    );
  }
}
