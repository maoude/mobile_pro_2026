// =====================================================================
// Lecture 1.1, section 4.1: A responsive grid with LayoutBuilder
// =====================================================================
// WHAT YOU LEARN
//   * LayoutBuilder tells you how much SPACE the widget has (constraints),
//     so the layout can adapt: here 2 columns on a phone, 3 on a wide
//     screen (more than 600 logical pixels).
//   * GridView.builder creates grid items lazily (only the visible ones),
//     which keeps long lists fast.
//   * The lecture used Placeholder() for the cells and gave no itemCount
//     (which makes an endless grid). Here every cell is a numbered Card and
//     itemCount limits the grid to 12 cards.
//
// HOW TO RUN
//   flutter run -t lib/17_responsive_grid.dart   (try a wide window, e.g. -d windows or -d chrome)
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A grid of 12 cards labelled "Card 0" ... "Card 11".
//   Window narrower than 600 px  -> 2 cards per row.
//   Window wider than 600 px     -> 3 cards per row (resize the window to
//                                   see it change instantly).
// =====================================================================

import 'package:flutter/material.dart';

class BusinessCardGrid extends StatelessWidget {
  const BusinessCardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // constraints.maxWidth = the width available to this widget.
        final count = constraints.maxWidth > 600 ? 3 : 2;
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count, // number of columns
            crossAxisSpacing: 16, // horizontal gap between cards
            mainAxisSpacing: 16, // vertical gap between cards
            childAspectRatio: 0.8, // width / height of each cell
          ),
          itemCount: 12,
          itemBuilder: (_, i) => Card(child: Center(child: Text('Card $i'))),
        );
      },
    );
  }
}

// ---------------- Demo app (only used when this file is run) ----------------
void main() => runApp(const GridApp());

class GridApp extends StatelessWidget {
  const GridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: BusinessCardGrid()));
  }
}
