// =====================================================================
// Week 5 - Going further (not in the slides): reading numbers safely
// =====================================================================
// WHAT YOU LEARN
//   * A TextField always gives a String. To use it as a number, you convert
//     it, and the user can type anything:
//         double.parse('abc')     stops the app: FormatException
//         double.tryParse('abc')  returns null: no crash
//     ALWAYS use tryParse for text typed by a user, then test for null.
//   * The sum app of the slides uses -1 to mean "empty", so the user cannot
//     add the number -1. A nullable variable (double?) is better: null means
//     "no valid number" and every real number stays possible (week 1: null
//     safety).
//   * Help the user to type numbers:
//       keyboardType  TextInputType.numberWithOptions(decimal: true,
//                     signed: true) shows a numeric keyboard on a phone.
//       errorText     a field of InputDecoration: a red message under the
//                     field. It is null (nothing shown) when the text is fine.
//   * Tell the user the button cannot be used yet: onPressed is null (the
//     button is grey) until both fields hold a valid number.
//   * The page is stateful: the two texts are kept in the State class, the
//     errors and the button are computed from them each time build runs.
//
// HOW TO RUN
//   flutter run -t lib/08_safe_number_input.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The line "Sum: ", two fields "X" and "Y", and a grey (disabled) button SUM.
//     * Type "abc" in X: a red message "Not a number" appears under it, the
//       button stays grey.
//     * Type 2.5 in X and -4 in Y: no message, the button becomes active.
//       Press it: "Sum: -1.5".
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeSum(),
    );
  }
}

class SafeSum extends StatefulWidget {
  const SafeSum({super.key});

  @override
  State<SafeSum> createState() => _SafeSumState();
}

class _SafeSumState extends State<SafeSum> {
  String _x = '';
  String _y = '';
  String _result = '';

  // null when the text is empty or is not a number.
  double? get _xValue => double.tryParse(_x.trim());
  double? get _yValue => double.tryParse(_y.trim());

  // The message under a field: only when something was typed and it is wrong.
  String? _errorOf(String text) {
    if (text.trim().isEmpty) return null;
    return double.tryParse(text.trim()) == null ? 'Not a number' : null;
  }

  void _sum() {
    final x = _xValue;
    final y = _yValue;
    if (x == null || y == null) return; // the button is disabled anyway
    setState(() {
      _result = (x + y).toString();
    });
  }

  Widget _field(String label, ValueChanged<String> onChanged, String? error) {
    return SizedBox(
      width: 300,
      child: TextField(
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: true),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          errorText: error,
        ),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool ready = _xValue != null && _yValue != null;
    return Scaffold(
      appBar: AppBar(title: const Text('Safe input'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text('Sum: $_result', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            _field('X', (text) => setState(() => _x = text), _errorOf(_x)),
            const SizedBox(height: 20),
            _field('Y', (text) => setState(() => _y = text), _errorOf(_y)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ready ? _sum : null, // null: disabled
              child: const Text('SUM', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}
