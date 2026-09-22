// =====================================================================
// Week 5 - The TextField widget: its main fields and its two events
// =====================================================================
// WHAT YOU LEARN
//   * TextField lets the user type text. Its main fields:
//       style         a TextStyle: the font of the typed text
//       decoration    an InputDecoration: what surrounds the text
//                       border      OutlineInputBorder() draws a frame
//                       hintText    grey text shown while the field is empty
//                       labelText   a label that moves above the text
//                       prefixIcon  an icon inside the field, at the left
//       onChanged     a function that takes the new text (a String). It runs
//                     EVERY TIME the text changes: after each letter.
//       onSubmitted   a function that takes the text. It runs ONCE, when the
//                     user finishes: Enter on a computer, the check mark (or
//                     "done" key) on a phone.
//   * Both are anonymous functions with one parameter (week 2):
//       onChanged: (text) { ... }
//   * The page is stateful: the two Text lines below the field show the last
//     values, so we change them inside setState.
//
// HOW TO RUN
//   flutter run -t lib/02_textfield_events.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A field with a frame, the label "Name", a person icon and, when empty,
//   the hint "Type your name". Under it two lines: "Changed: " and
//   "Submitted: ". While you type, the first line follows every letter. When
//   you press Enter, the second line shows the final text.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextFieldEvents(),
    );
  }
}

class TextFieldEvents extends StatefulWidget {
  const TextFieldEvents({super.key});

  @override
  State<TextFieldEvents> createState() => _TextFieldEventsState();
}

class _TextFieldEventsState extends State<TextFieldEvents> {
  String _changed = '';
  String _submitted = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField events'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Type your name',
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (text) {
                  setState(() {
                    _changed = text;
                  });
                },
                onSubmitted: (text) {
                  setState(() {
                    _submitted = text;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Text('Changed: $_changed', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Submitted: $_submitted',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
