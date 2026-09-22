// =====================================================================
// Week 5, part 2 - Gestures, level 1: pointer events (the Listener widget)
// =====================================================================
// WHAT YOU LEARN
//   * Flutter handles user touches in TWO levels. The lowest level is made of
//     POINTER events: raw data about a finger, a mouse or a pen: where it is
//     and how it moves. The widget that listens to them is Listener.
//   * A pointer that touches the screen sends a sequence of events:
//       onPointerDown    the pointer touches the screen at a position
//       onPointerMove    it moves from one position to another
//       onPointerUp      it leaves the screen
//       onPointerCancel  the interaction was interrupted (for example the
//                        system took over the touch)
//   * Each event has a position: event.position is on the whole screen and
//     event.localPosition is inside the widget that listens.
//   * Listener sees EVERY pointer event and cannot stop it. To react to a
//     "tap" or a "drag" you use the second level, GestureDetector (examples
//     01 to 05), which builds those actions from the pointer events.
//   * behavior: HitTestBehavior.opaque makes the whole box receive events,
//     even where it has nothing to draw.
//
// HOW TO RUN
//   flutter run -t lib/00_pointer_events.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A blue-grey square and, above it, the last pointer event, the position of
//   the pointer inside the square, and four counters:
//   Down, Move, Up and Cancel, all 0. Touch the square (or click it): the
//   last event becomes PointerDownEvent. Move while pressing: the position and
//   the Move counter change. Release: PointerUpEvent.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PointerEventsPage(),
    );
  }
}

class PointerEventsPage extends StatefulWidget {
  const PointerEventsPage({super.key});

  @override
  State<PointerEventsPage> createState() => _PointerEventsPageState();
}

class _PointerEventsPageState extends State<PointerEventsPage> {
  String _last = 'none';
  Offset _position = Offset.zero;
  int _down = 0, _move = 0, _up = 0, _cancel = 0;

  // One method for the four events: it stores what happened.
  void _record(String name, PointerEvent event, VoidCallback count) {
    setState(() {
      _last = name;
      _position = event.localPosition;
      count();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pointer events'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Last event: $_last', style: const TextStyle(fontSize: 18)),
            Text(
              'Position: (${_position.dx.toStringAsFixed(0)}, '
              '${_position.dy.toStringAsFixed(0)})',
              style: const TextStyle(fontSize: 18),
            ),
            Text('Down: $_down   Move: $_move   Up: $_up   Cancel: $_cancel'),
            const SizedBox(height: 16),
            Listener(
              behavior: HitTestBehavior.opaque,
              onPointerDown: (e) => _record('PointerDownEvent', e, () => _down++),
              onPointerMove: (e) => _record('PointerMoveEvent', e, () => _move++),
              onPointerUp: (e) => _record('PointerUpEvent', e, () => _up++),
              onPointerCancel: (e) =>
                  _record('PointerCancelEvent', e, () => _cancel++),
              child: Container(
                key: const ValueKey('area'),
                width: 240,
                height: 240,
                color: Colors.blueGrey,
                alignment: Alignment.center,
                child: const Text(
                  'Touch me',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
