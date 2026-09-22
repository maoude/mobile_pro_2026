// =====================================================================
// Week 5, part 3 - The DropdownButton widget
// =====================================================================
// WHAT YOU LEARN
//   * DropdownButton<T> lets the user pick ONE value from a fixed list, shown
//     as a menu when tapped. Its main fields:
//       items       a List<DropdownMenuItem<T>>: one entry per choice
//       value       the CURRENTLY selected value (it must be one of items'
//                   values, or null)
//       onChanged   called with the new value when the user picks one
//       iconSize    the size of the little arrow on the right
//   * You rarely write the items by hand. You build them from a list of data
//     with .map(...).toList():
//       _cities.map((city) => DropdownMenuItem(value: city, child: Text(city)))
//              .toList()
//     One DropdownMenuItem<String> is created for each String of _cities.
//   * DropdownButton is STATELESS by itself: it does not remember what is
//     selected. YOU keep the selected value in the page's state, and give it
//     back as `value`; onChanged only reports the user's choice, with
//     setState you store it and the button redraws showing the new value.
//     This is the same "data down, events up" idea as example 04 (a callback).
//   * The callback's parameter is NULLABLE, ValueChanged<String?>: passing a
//     non-nullable String there does not compile (verified: it is a type
//     error, not a style nitpick). A dropdown can be genuinely empty (no
//     value picked yet), so Flutter's API allows null.
//   * initState sets the first value, once, before the first build: without it
//     `value` would start at null, and if null is not in `items`, Flutter
//     shows nothing selected.
//
// HOW TO RUN
//   flutter run -t lib/10_dropdown_button.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The text "You live in: Calcutta" and, below it, a dropdown showing
//   "Calcutta" with an arrow. Tap it: a menu with Calcutta, Delhi, Mumbai,
//   Chennai, Bangalore opens. Pick "Mumbai": the menu closes, the dropdown now
//   shows "Mumbai", and the text above updates to "You live in: Mumbai".
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DropdownPage(),
    );
  }
}

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  State<DropdownPage> createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  final List<String> _cities = [
    'Calcutta',
    'Delhi',
    'Mumbai',
    'Chennai',
    'Bangalore',
  ];

  late String _selectedCity;

  @override
  void initState() {
    super.initState();
    _selectedCity = _cities[0]; // the first item is selected at the start
  }

  void _selectCity(String? city) {
    setState(() {
      if (city != null) _selectedCity = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dropdown')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You live in: $_selectedCity',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedCity,
              iconSize: 32,
              items: _cities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: _selectCity,
            ),
          ],
        ),
      ),
    );
  }
}
