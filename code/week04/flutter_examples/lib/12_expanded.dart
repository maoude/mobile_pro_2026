// =====================================================================
// Week 4 - Going further (not in the slides): sharing space with Expanded
// =====================================================================
// WHAT YOU LEARN
//   * SizedBox(height: 16.0) has a FIXED size, the same on every screen.
//     Sometimes you want a widget to use whatever space is LEFT instead.
//   * Expanded, placed inside a Column (or a Row), makes its child fill the
//     space that the other children do not use.
//   * flex says how the free space is shared. Three Expanded children with
//     flex 1, 2 and 1 receive 1/4, 2/4 and 1/4 of it. You never compute a
//     size yourself: Flutter does it, on any screen.
//   * Expanded works the same way inside a Row, horizontally.
//   * A very common beginner error: putting a ListView (a scrolling list)
//     directly inside a Column fails with a "vertical viewport was given
//     unbounded height" error. Wrapping the ListView in Expanded fixes it.
//     You will use this in the weeks about lists.
//
// HOW TO RUN
//   flutter run -t lib/12_expanded.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   Under the app bar, one column made of four colored areas:
//     * a grey strip of fixed height 60:  Fixed height: 60
//     * a red area   (flex 1): Expanded, flex 1
//     * a green area (flex 2): Expanded, flex 2   (twice as tall as the red)
//     * a blue area  (flex 1): Expanded, flex 1   (as tall as the red)
//   Together they fill the whole screen. Resize the window: the fixed strip
//   stays 60 tall and the three others stay in the ratio 1 : 2 : 1.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Expanded')),
        body: const ExpandedDemo(),
      ),
    );
  }
}

//#region notes
class ExpandedDemo extends StatelessWidget {
  const ExpandedDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Fixed size: always 60 logical pixels tall.
        Container(
          key: const ValueKey('fixed'),
          height: 60,
          color: Colors.grey.shade400,
          alignment: Alignment.center,
          child: const Text('Fixed height: 60'),
        ),
        // The three Expanded widgets share the REST of the height: 1 : 2 : 1.
        Expanded(
          flex: 1,
          child: Container(
            key: const ValueKey('box-a'),
            color: Colors.red.shade200,
            alignment: Alignment.center,
            child: const Text('Expanded, flex 1'),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            key: const ValueKey('box-b'),
            color: Colors.green.shade200,
            alignment: Alignment.center,
            child: const Text('Expanded, flex 2'),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            key: const ValueKey('box-c'),
            color: Colors.blue.shade200,
            alignment: Alignment.center,
            child: const Text('Expanded, flex 1'),
          ),
        ),
      ],
    );
  }
}

//#endregion notes
