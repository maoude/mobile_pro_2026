// =====================================================================
// Week 5, part 2 - Gestures: horizontal drag and vertical drag
// =====================================================================
// WHAT YOU LEARN
//   * A drag is: touch the screen, move the finger, release. Flutter has
//     two kinds of drag, each with three callbacks (start, update, end):
//       horizontal   onHorizontalDragStart / Update / End   (left - right)
//       vertical     onVerticalDragStart   / Update / End   (up - down)
//     A horizontal drag ignores the vertical part of the movement.
//   * The update callback is called again and again while the finger moves.
//     It receives a DragUpdateDetails: details.delta is how far the finger
//     moved since the previous call (delta.dx horizontally, delta.dy
//     vertically). Adding the deltas moves a widget after the finger.
//   * The end callback receives DragEndDetails: details.primaryVelocity is the
//     speed of the finger when it was lifted, in pixels per second.
//   * clamp(min, max) keeps a value between two limits: the box cannot leave
//     its track.
//   * The position is data that changes: the page is stateful and moves the
//     box inside setState.
//
// HOW TO RUN
//   flutter run -t lib/02_drag_gestures.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   Two tracks. A horizontal track with a red square that you can drag left
//   and right, and a vertical track with a green square that you can drag up
//   and down. The texts show their position (both start at 0) and the last
//   drag event (none at first). While you drag, the position changes and the
//   last event is onHorizontalDragUpdate (or onVerticalDragUpdate); when you
//   release, it is ...DragEnd. The squares stop at the ends of their tracks.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DragGesturesPage(),
    );
  }
}

class DragGesturesPage extends StatefulWidget {
  const DragGesturesPage({super.key});

  @override
  State<DragGesturesPage> createState() => _DragGesturesPageState();
}

class _DragGesturesPageState extends State<DragGesturesPage> {
  static const double _track = 240; // length of a track
  static const double _size = 60; // size of a square

  double _x = 0; // position of the red square along its track
  double _y = 0; // position of the green square along its track
  String _last = 'none';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drag gestures'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Horizontal: x = ${_x.toStringAsFixed(0)}'),
            Text('Vertical: y = ${_y.toStringAsFixed(0)}'),
            Text('Last event: $_last', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),

            // The horizontal track.
            Container(
              width: _track + _size,
              height: _size,
              color: Colors.grey[300],
              child: Stack(
                children: [
                  Positioned(
                    left: _x,
                    child: GestureDetector(
                      onHorizontalDragStart: (details) {
                        setState(() => _last = 'onHorizontalDragStart');
                      },
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _x = (_x + details.delta.dx).clamp(0, _track).toDouble();
                          _last = 'onHorizontalDragUpdate';
                        });
                      },
                      onHorizontalDragEnd: (details) {
                        setState(() => _last = 'onHorizontalDragEnd');
                      },
                      child: Container(
                        key: const ValueKey('horizontal'),
                        width: _size,
                        height: _size,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // The vertical track.
            Container(
              width: _size,
              height: _track + _size,
              color: Colors.grey[300],
              child: Stack(
                children: [
                  Positioned(
                    top: _y,
                    child: GestureDetector(
                      onVerticalDragStart: (details) {
                        setState(() => _last = 'onVerticalDragStart');
                      },
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          _y = (_y + details.delta.dy).clamp(0, _track).toDouble();
                          _last = 'onVerticalDragUpdate';
                        });
                      },
                      onVerticalDragEnd: (details) {
                        setState(() => _last = 'onVerticalDragEnd');
                      },
                      child: Container(
                        key: const ValueKey('vertical'),
                        width: _size,
                        height: _size,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
