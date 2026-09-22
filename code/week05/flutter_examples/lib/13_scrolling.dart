// =====================================================================
// Week 5 - Scrolling: ListView.builder, scroll physics, and constraints
// =====================================================================
// WHAT YOU LEARN
//   * ListView.builder builds the rows only when they are about to appear on
//     the screen. For a list of 1000 items, only the 10 or 20 rows that are
//     visible exist. ListView(children: [...]) (example 12) creates all the
//     widgets of the list at once: fine for a few items, wasteful for a long
//     list. Give the builder itemCount and an itemBuilder(context, index).
//   * Scrolling is platform aware: this is ScrollPhysics. On iOS the list
//     bounces at its ends, on Android it stops (with a glow), on the web and on
//     the desktop it is different again. The default follows the platform. You
//     can force a behaviour with the physics field:
//         BouncingScrollPhysics()       bounces, as on iOS
//         ClampingScrollPhysics()       stops at the ends, as on Android
//         NeverScrollableScrollPhysics() the list does not scroll at all
//     Change the platform's behaviour only for a good reason: users expect their
//     platform's feel.
//   * A scrolling widget needs to know how much room it has (its parent's
//     constraints). Constraints go down, sizes go up. In a Column or a Row the
//     room is unlimited, so the ListView must be wrapped in Expanded (or
//     Flexible): it then gets the space left by the other children. Here the
//     header and the footer keep their size, and the list takes the rest.
//     Without Expanded: "Vertical viewport was given unbounded height".
//   * Reference: the main scrolling widgets
//       ListView                  a scrolling column (or row) of widgets
//       ListView.builder          the same, built lazily: long lists
//       ListView.separated        with a separator between the rows
//       GridView                  a scrolling grid
//       SingleChildScrollView     makes ONE big child scroll (a form, a page)
//       PageView                  swipe from page to page
//       CustomScrollView          slivers: app bars that collapse, mixed lists
//
// HOW TO RUN
//   flutter run -t lib/13_scrolling.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A drop-down "Physics" (default: Platform default), a list "Item 0",
//   "Item 1", ... of 1000 rows, and a footer line. Drag the list to scroll it. Choose
//   "Bouncing": the list springs back at the ends. Choose "Never": you can no
//   longer scroll it with your finger.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScrollingPage(),
    );
  }
}

class ScrollingPage extends StatefulWidget {
  const ScrollingPage({super.key});

  @override
  State<ScrollingPage> createState() => _ScrollingPageState();
}

class _ScrollingPageState extends State<ScrollingPage> {
  static const Map<String, ScrollPhysics?> _choices = {
    'Platform default': null,
    'Bouncing': BouncingScrollPhysics(),
    'Clamping': ClampingScrollPhysics(),
    'Never': NeverScrollableScrollPhysics(),
  };

  String _choice = 'Platform default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scrolling'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Physics: '),
                DropdownButton<String>(
                  value: _choice,
                  items: [
                    for (final name in _choices.keys)
                      DropdownMenuItem(value: name, child: Text(name)),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _choice = value);
                  },
                ),
              ],
            ),
          ),
          // Without Expanded, this ListView would fail: a Column gives its
          // children an unlimited height.
          Expanded(
            child: ListView.builder(
              physics: _choices[_choice], // null = the platform's default
              itemCount: 1000,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.label_outline),
                  title: Text('Item $index'),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text('Constraints go down. Sizes go up.'),
          ),
        ],
      ),
    );
  }
}
