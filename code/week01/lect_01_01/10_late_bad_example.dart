// Source: 002_lect_01_01.tex, section 2.4 Null Safety and Modern Dart - Bad vs good: late (BAD)
// Flutter widget. Shows the crash risk of late.

class BadExample extends StatefulWidget {
  @override
  State<BadExample> createState() => _BadExampleState();
}

class _BadExampleState extends State<BadExample> {
  late String data; // [BAD] may be read before assigned
  @override
  Widget build(BuildContext context) => Text(data); // [CRASH RISK] if unassigned
}
