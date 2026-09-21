// =====================================================================
// Week 4, part 3 - Recipe: Expanded shares the free space equally
// =====================================================================
// WHAT YOU LEARN
//   * You do not need to ask the screen for its size. Inside a Column (or a
//     Row), an Expanded child fills the space that the other children leave.
//   * When several children are Expanded and you give no "flex", they all
//     have flex 1: they share the free space EQUALLY. (Example 12 of
//     flutter_examples shows how flex changes the shares.)
//   * A child that is NOT Expanded, like the text here, keeps its own size,
//     and the Expanded children share what is left.
//   * RichText with a TextSpan shows a text whose parts can have different
//     styles. Here there is only one span; a span can have "children" spans.
//   * An Expanded with no child in the colored Container leaves a gap: the
//     Container has no color, so the page background shows through.
//
// HOW TO RUN
//   flutter run -t lib/04_expanded_flag.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   Under the app bar "Expanded Widget", one column, from top to bottom:
//   a red area, an empty (white) area, the bold grey word  Luxembourg,
//   another empty area and a blue area. The four areas have exactly the same
//   height; together with the word they fill the whole screen. Resize the
//   window: they stay equal.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Expanded Widget';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: const MyExpandedWidget(),
      ),
    );
  }
}

class MyExpandedWidget extends StatelessWidget {
  const MyExpandedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            key: const ValueKey('area1'),
            color: Colors.red,
          ),
        ),
        Expanded(
          child: Container(
            key: const ValueKey('area2'),
          ),
        ),
        RichText(
          text: const TextSpan(
            text: 'Luxembourg',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Container(
            key: const ValueKey('area3'),
          ),
        ),
        Expanded(
          child: Container(
            key: const ValueKey('area4'),
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
