// WHAT YOU LEARN: add/import intl and format numbers with an explicit locale.
// HOW TO RUN: flutter run -t lib/00_number_format.dart
// EXPECTED RESULT: US 1,234.57; German 1.234,57; area 12.3457.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const FormattingApp());

class FormattingApp extends StatelessWidget {
  const FormattingApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Week 7: intl')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'US: ${NumberFormat('#,##0.00', 'en_US').format(1234.567)}'),
                Text(
                    'German: ${NumberFormat('#,##0.00', 'de_DE').format(1234.567)}'),
                Text(
                    'Area: ${NumberFormat('0.####', 'en_US').format(12.34567)}'),
              ],
            ),
          ),
        ),
      );
}
