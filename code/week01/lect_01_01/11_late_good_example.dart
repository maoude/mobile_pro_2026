// Source: 002_lect_01_01.tex, section 2.4 Null Safety and Modern Dart - Bad vs good: late (GOOD)
// Flutter widget. Needs an import of package:flutter/material.dart to run.

// [GOOD] assign before first build
class GoodExample extends StatefulWidget {
  @override
  State<GoodExample> createState() => _GoodExampleState();
}

class _GoodExampleState extends State<GoodExample> {
  late String data;
  @override
  void initState() {
    super.initState();
    data = 'ready'; // guaranteed before first build
  }

  @override
  Widget build(BuildContext context) => Text(data);
}
