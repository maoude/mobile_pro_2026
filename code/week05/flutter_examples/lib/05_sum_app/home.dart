// The page of the sum application: a stateful widget (Home) and its State.
// See main.dart for what this example teaches.

import 'package:flutter/material.dart';

import 'my_text_field.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _text = '';

  // The numbers typed by the user. null means: empty, or not a number.
  // (The slides use -1 for "empty"; null does not forbid the value -1.)
  double? _x, _y;

  // Called when the SUM button is pressed.
  void updateText() {
    setState(() {
      final x = _x;
      final y = _y;
      if (x == null || y == null) {
        _text = 'Please fill all fields';
      } else {
        _text = (x + y).toString();
      }
    });
  }

  // Called each time the text of a field changes. They only store the number:
  // the screen does not change until the button calls setState.
  // double.tryParse returns null for a text that is not a number, where
  // double.parse would stop the app with a FormatException.
  void updateX(String x) {
    _x = double.tryParse(x.trim());
  }

  void updateY(String y) {
    _y = double.tryParse(y.trim());
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
            Text('Sum: $_text', style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 20.0),
            MyTextField(
              onChanged: updateX,
              hint: 'Enter X',
              keyboardType: numberKeyboard,
            ),
            const SizedBox(height: 20.0),
            MyTextField(
              onChanged: updateY,
              hint: 'Enter Y',
              keyboardType: numberKeyboard,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                updateText();
              },
              child: const Text('SUM', style: TextStyle(fontSize: 24.0)),
            ),
          ],
        ),
      ),
    );
  }
}
