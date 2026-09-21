// =====================================================================
// Week 4, part 3 - Recipe: a ListView inside an Expanded
// =====================================================================
// WHAT YOU LEARN
//   * A ListView is a scrolling list. By itself it tries to take ALL the
//     height it can get. Put in a Column, next to other widgets, it is given
//     an unlimited height and Flutter stops with the error
//         "Vertical viewport was given unbounded height".
//   * Wrap the ListView in Expanded: it then takes exactly the REMAINING
//     height, the part that the other children do not use, and scrolls
//     inside it.
//   * ListTile is a ready-made row for lists: leading, title, subtitle,
//     trailing. ListView.builder creates the rows only when they are about
//     to be seen, so it works for long lists.
//   * The widgets outside the Expanded (the header above and the footer
//     below) keep their own size and stay on screen while the list scrolls.
//
// HOW TO RUN
//   flutter run -t lib/05_expanded_listview.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   Under the app bar "ListView in Expanded": the header  Countries  at
//   the top, the footer  Scroll the list  at the bottom, and between them a
//   list of 20 rows  Country 1, Country 2, ... with an icon and a subtitle.
//   The list fills all the space between the header and the footer and
//   scrolls; the header and the footer do not move.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ListView in Expanded')),
        body: const CountryList(),
      ),
    );
  }
}

class CountryList extends StatelessWidget {
  const CountryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          key: ValueKey('header'),
          padding: EdgeInsets.all(12),
          child: Text(
            'Countries',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        // Without Expanded, this ListView would fail: a Column gives its
        // children an unlimited height.
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.flag),
                title: Text('Country ${index + 1}'),
                subtitle: const Text('A row of the list'),
              );
            },
          ),
        ),
        const Padding(
          key: ValueKey('footer'),
          padding: EdgeInsets.all(12),
          child: Text('Scroll the list'),
        ),
      ],
    );
  }
}
