// Source: 002_lect_01_01.tex, section 3.2 Stateless vs Stateful
// Flutter widget; needs an import of package:flutter/material.dart.

class CounterButton extends StatefulWidget {
  const CounterButton({super.key});
  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setState(() => _count++),
      child: Text('Count: $_count'),
    );
  }
}
