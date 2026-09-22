// =====================================================================
// Week 5, part 2 - Gestures, level 2: GestureDetector, tap, double tap and
// long press
// =====================================================================
// WHAT YOU LEARN
//   * GestureDetector is an INVISIBLE widget that listens to the pointer
//     events of its child and recognises gestures: tap, double tap, long
//     press, drag, pan, scale (pinch). You give it a function for each gesture
//     you want. The gestures it looks for are the ones whose callback is NOT
//     null.
//   * A tap (touch the screen briefly, then release) has four callbacks:
//       onTapDown    the finger touches the screen
//       onTapUp      the finger is released
//       onTap        the tap is complete: down, then up
//       onTapCancel  the tap did not happen (for example the finger moved
//                    away, or another gesture won)
//   * onDoubleTap: two taps in a short time. onLongPress: the finger stays on
//     the screen for about half a second.
//   * A callback receives a "details" object with the data of the gesture,
//     for example TapDownDetails.localPosition.
//   * Gestures COMPETE: the detector does not know yet what the finger is
//     doing, so the recognisers wait for each other. Careful: when onDoubleTap
//     is set, Flutter has to see whether a second tap follows, so the whole tap
//     (onTapDown, onTapUp and onTap) arrives about 0.3 s AFTER the finger was
//     lifted. If you do not need a double tap, do not set onDoubleTap: a tap is
//     then instant. In the same way, a long press "wins" against the tap: it
//     sends onLongPress, and the tap is cancelled (onTapCancel).
//   * Every callback here changes the counters inside setState (week 5).
//
// HOW TO RUN
//   flutter run -t lib/01_tap_gestures.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A blue-grey box "Click me" and a list of counters, all 0: onTapDown,
//   onTapUp, onTap, onTapCancel, onDoubleTap, onLongPress. The first line says
//   which event happened last. Tap once: after a short pause (0.3 s) onTapDown,
//   onTapUp and onTap all go to 1. Tap twice quickly: onDoubleTap goes to 1.
//   Press and hold: onLongPress goes to 1, and the tap is cancelled
//   (onTapDown and onTapCancel go to 1). Press, move your finger out of the box
//   and release: onTapDown and onTapCancel go to 1.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TapGesturesPage(),
    );
  }
}

class TapGesturesPage extends StatefulWidget {
  const TapGesturesPage({super.key});

  @override
  State<TapGesturesPage> createState() => _TapGesturesPageState();
}

class _TapGesturesPageState extends State<TapGesturesPage> {
  static const List<String> _names = [
    'onTapDown',
    'onTapUp',
    'onTap',
    'onTapCancel',
    'onDoubleTap',
    'onLongPress',
  ];

  final Map<String, int> _counts = {for (final n in _names) n: 0};
  String _last = 'none';

  void _happened(String name) {
    setState(() {
      _counts[name] = _counts[name]! + 1;
      _last = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tap gestures'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Last event: $_last', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            for (final name in _names) Text('$name: ${_counts[name]}'),
            const SizedBox(height: 24),
            // GestureDetector is invisible: the Container is what you see.
            GestureDetector(
              onTapDown: (details) => _happened('onTapDown'),
              onTapUp: (details) => _happened('onTapUp'),
              onTap: () => _happened('onTap'),
              onTapCancel: () => _happened('onTapCancel'),
              onDoubleTap: () => _happened('onDoubleTap'),
              onLongPress: () => _happened('onLongPress'),
              child: Container(
                key: const ValueKey('box'),
                height: 62,
                width: 110,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Center(
                  child: Text('Click me', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
