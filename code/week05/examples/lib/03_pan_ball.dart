// =====================================================================
// Week 5, part 2 - Gestures: pan (a drag in any direction)
// =====================================================================
// WHAT YOU LEARN
//   * A pan is a drag that can go in ANY direction: horizontal and vertical
//     at the same time. It has three callbacks:
//       onPanStart   the finger starts to move
//       onPanUpdate  called again and again; details.delta is an Offset with
//                    both the horizontal (dx) and the vertical (dy) movement
//       onPanEnd     the finger is lifted
//   * Use horizontal/vertical drag when only one direction matters (a slider,
//     a swipe to delete); use pan to move something freely, like this ball.
//   * Do not mix pan with other drag gestures on the SAME GestureDetector:
//     Flutter refuses a pan together with a scale (scale is a superset of pan),
//     and a pan together with BOTH a horizontal and a vertical drag (the two
//     drags catch every movement, so the pan would never be called). When you
//     need different gestures, give each one its own GestureDetector.
//   * A Stack with a Positioned child places a widget at exact coordinates
//     (left, top) inside the Stack: changing them in setState moves the ball.
//   * We keep the ball inside its playground with clamp.
//
// HOW TO RUN
//   flutter run -t lib/03_pan_ball.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A grey square playground with an orange ball in its middle. The text shows
//   the position of the ball, (125, 125), and the pan state: idle. Drag the
//   ball in any direction: it follows the finger, the position changes and the
//   state says panning; it stops at the borders of the square. When you lift
//   your finger the state is idle again. The RESET button puts the ball back in
//   the middle.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PanBallPage(),
    );
  }
}

class PanBallPage extends StatefulWidget {
  const PanBallPage({super.key});

  @override
  State<PanBallPage> createState() => _PanBallPageState();
}

class _PanBallPageState extends State<PanBallPage> {
  static const double _field = 300; // side of the playground
  static const double _ball = 50; // diameter of the ball
  static const Offset _center = Offset(125, 125);

  Offset _position = _center; // top left corner of the ball
  bool _panning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pan'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Position: (${_position.dx.toStringAsFixed(0)}, '
              '${_position.dy.toStringAsFixed(0)})',
              style: const TextStyle(fontSize: 18),
            ),
            Text('Pan state: ${_panning ? 'panning' : 'idle'}'),
            const SizedBox(height: 16),
            Container(
              width: _field,
              height: _field,
              color: Colors.grey[300],
              child: Stack(
                children: [
                  Positioned(
                    left: _position.dx,
                    top: _position.dy,
                    child: GestureDetector(
                      onPanStart: (details) {
                        setState(() => _panning = true);
                      },
                      onPanUpdate: (details) {
                        setState(() {
                          // delta has dx AND dy: the ball moves in both.
                          final next = _position + details.delta;
                          _position = Offset(
                            next.dx.clamp(0, _field - _ball).toDouble(),
                            next.dy.clamp(0, _field - _ball).toDouble(),
                          );
                        });
                      },
                      onPanEnd: (details) {
                        setState(() => _panning = false);
                      },
                      child: Container(
                        key: const ValueKey('ball'),
                        width: _ball,
                        height: _ball,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => _position = _center),
              child: const Text('RESET'),
            ),
          ],
        ),
      ),
    );
  }
}
