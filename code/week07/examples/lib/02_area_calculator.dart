// WHAT YOU LEARN: import a local package, validate dimensions and format results.
// HOW TO RUN: flutter run -t lib/02_area_calculator.dart
// EXPECTED RESULT: 4 x 3 gives 12 (rectangle) or 6 (triangle); invalid input is shown.
import 'package:area/area.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AreaApp());

class AreaApp extends StatelessWidget {
  const AreaApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: AreaPage());
}

class AreaPage extends StatefulWidget {
  const AreaPage({super.key});

  @override
  State<AreaPage> createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> {
  final _width = TextEditingController();
  final _height = TextEditingController();
  String _result = 'Enter positive dimensions.';

  void _calculate({required bool triangle}) {
    final width = double.tryParse(_width.text.trim());
    final height = double.tryParse(_height.text.trim());
    try {
      if (width == null || height == null) {
        throw ArgumentError('Enter two numbers.');
      }
      final value =
          triangle ? triangleArea(width, height) : rectangleArea(width, height);
      setState(() => _result = 'Area: ${formatArea(value)} square units');
    } on ArgumentError {
      setState(() =>
          _result = 'Enter finite, positive dimensions of a supported size.');
    }
  }

  @override
  void dispose() {
    _width.dispose();
    _height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Week 7: local area package')),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextField(
              controller: _width,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Width / base'),
            ),
            TextField(
              controller: _height,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Height'),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(
                    onPressed: () => _calculate(triangle: false),
                    child: const Text('Rectangle')),
                ElevatedButton(
                    onPressed: () => _calculate(triangle: true),
                    child: const Text('Triangle')),
              ],
            ),
            const SizedBox(height: 16),
            Text(_result),
          ],
        ),
      );
}
