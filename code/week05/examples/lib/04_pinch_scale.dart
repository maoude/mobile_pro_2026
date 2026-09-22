// =====================================================================
// Week 5, part 2 - Gestures: pinch to zoom (scale)
// =====================================================================
// WHAT YOU LEARN
//   * A pinch is two fingers that come closer or move apart, to zoom out or
//     in. Flutter calls this gesture SCALE, and it also gives the rotation of
//     the two fingers. Its callbacks:
//       onScaleStart   the gesture starts
//       onScaleUpdate  called again and again; details.scale is the zoom
//                      since the START of the gesture (1.0 = no change,
//                      2.0 = twice as big), details.rotation is the angle in
//                      radians
//       onScaleEnd     the fingers are lifted
//   * details.scale always starts again at 1.0 for a new gesture. To keep the
//     size from one pinch to the next, remember the size at onScaleStart and
//     multiply: new size = size at start * details.scale.
//   * Scale also reports a single finger (scale 1.0), so it replaces pan: do
//     not set onPanUpdate and onScaleUpdate on the same GestureDetector.
//   * Transform.scale and Transform.rotate change how a widget is drawn, without
//     changing the layout around it.
//   * For real zooming of images and maps, Flutter has a ready-made widget,
//     InteractiveViewer, which handles pinch, pan and rotation for you.
//
// HOW TO RUN
//   flutter run -t lib/04_pinch_scale.dart
//   (see ../README.md the first time: run "flutter create ." once)
//   On a computer without a touch screen you can simulate a pinch with the
//   Ctrl key held down and the mouse wheel in a browser, or use an emulator
//   (Ctrl + drag shows two fingers).
//
// EXPECTED RESULT (on screen)
//   A blue square in the middle of the page and the texts "Scale: 1.00" and
//   "Rotation: 0 degrees". Pinch apart: the square grows (up to 3 times);
//   pinch together: it shrinks (down to half). Turn the two fingers: it rotates.
//   The RESET button restores size 1 and no rotation.
// =====================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PinchScalePage(),
    );
  }
}

class PinchScalePage extends StatefulWidget {
  const PinchScalePage({super.key});

  @override
  State<PinchScalePage> createState() => _PinchScalePageState();
}

class _PinchScalePageState extends State<PinchScalePage> {
  double _scale = 1.0; // the current size of the square
  double _rotation = 0.0; // the current angle, in radians

  // The values at the START of the gesture (see the header).
  double _startScale = 1.0;
  double _startRotation = 0.0;

  @override
  Widget build(BuildContext context) {
    final degrees = (_rotation * 180 / math.pi).round();
    return Scaffold(
      appBar: AppBar(title: const Text('Pinch'), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Text('Scale: ${_scale.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18)),
          Text('Rotation: $degrees degrees'),
          Expanded(
            child: Center(
              child: GestureDetector(
                onScaleStart: (details) {
                  _startScale = _scale;
                  _startRotation = _rotation;
                },
                onScaleUpdate: (details) {
                  setState(() {
                    _scale = (_startScale * details.scale)
                        .clamp(0.5, 3.0)
                        .toDouble();
                    _rotation = _startRotation + details.rotation;
                  });
                },
                child: Transform.rotate(
                  angle: _rotation,
                  child: Transform.scale(
                    scale: _scale,
                    child: Container(
                      key: const ValueKey('square'),
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: const Text(
                        'Pinch me',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _scale = 1.0;
                _rotation = 0.0;
              });
            },
            child: const Text('RESET'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
