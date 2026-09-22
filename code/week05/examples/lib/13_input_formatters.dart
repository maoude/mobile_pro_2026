// =====================================================================
// Week 5, part 3 - Restricting what can be typed: inputFormatters
// =====================================================================
// WHAT YOU LEARN
//   * A validator (examples 11, 12) rejects a WRONG value after it has been
//     typed. An inputFormatter goes further: it stops the WRONG CHARACTER from
//     ever appearing in the field. The two are complementary: use formatters to
//     guide typing, and a validator to check the final result (for example
//     "not empty", which a formatter cannot express).
//   * TextField (and TextFormField) take a list of TextInputFormatter:
//       inputFormatters: [ ... ],
//     They run in order, each one adjusting what was just typed.
//   * FilteringTextInputFormatter.allow(pattern) keeps only the characters
//     that MATCH a pattern (typically a RegExp); .deny(pattern) removes the
//     characters that match. FilteringTextInputFormatter.digitsOnly is a
//     ready-made shortcut for .allow(RegExp(r'[0-9]')).
//   * LengthLimitingTextInputFormatter(n) stops the field at n characters:
//     typing a 7th digit in a 6-digit code field does nothing.
//   * keyboardType: TextInputType.number asks a phone for a numeric keyboard
//     (week 5, part 1); it is a HINT for the on-screen keyboard, not a
//     restriction by itself - a physical keyboard can still type letters,
//     which is why the formatter is still needed.
//
// HOW TO RUN
//   flutter run -t lib/13_input_formatters.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A field with the hint "6-digit code" and the line "You typed: ". Try to
//   type letters: nothing appears (the formatter denies them). Type digits:
//   they appear, and "You typed: ..." follows. Type more than 6 digits: typing
//   stops at 6, the 7th (and later) digit is refused.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InputFormattersPage(),
    );
  }
}

class InputFormattersPage extends StatefulWidget {
  const InputFormattersPage({super.key});

  @override
  State<InputFormattersPage> createState() => _InputFormattersPageState();
}

class _InputFormattersPageState extends State<InputFormattersPage> {
  String _code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input formatters')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 160,
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // only 0-9
                  LengthLimitingTextInputFormatter(6), // at most 6 characters
                ],
                decoration: const InputDecoration(
                  hintText: '6-digit code',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) => setState(() => _code = text),
              ),
            ),
            const SizedBox(height: 16),
            Text('You typed: $_code', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
