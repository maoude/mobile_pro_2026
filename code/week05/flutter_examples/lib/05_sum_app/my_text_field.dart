// A reusable text field, with the design written once.
// See main.dart for what this example teaches.

import 'package:flutter/material.dart';

// The keyboard for a number that may have decimals and a minus sign.
const TextInputType numberKeyboard =
    TextInputType.numberWithOptions(decimal: true, signed: true);

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.hint,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  final String hint; // the hintText of the TextField
  final ValueChanged<String> onChanged; // the callback function
  final TextInputType keyboardType; // which keyboard a phone shows

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      height: 50.0,
      child: TextField(
        style: const TextStyle(fontSize: 18.0),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
        ),
        onChanged: onChanged, // call the callback with the new text
      ),
    );
  }
}
