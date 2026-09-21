// =====================================================================
// Week 4, part 2 - Gestures and state: GestureDetector
// =====================================================================
// WHAT YOU LEARN
//   * GestureDetector is an INVISIBLE widget that listens to touches on its
//     child: tap, long press, drag, scale (pinch)... It draws nothing; the
//     child decides what is seen and how big the touch area is.
//   * You give it functions: onTap, onLongPress, onPanUpdate, ...
//   * Because the count changes while the app runs, the widget is STATEFUL.
//     setState() tells Flutter to build it again with the new value: Flutter
//     compares the new widgets with the old ones and updates only the parts
//     that changed.
//   * Stack draws widgets on top of each other; Positioned places a child of
//     a Stack at a chosen spot.
//
// HOW TO RUN
//   flutter run -t lib/14_gestures.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A light indigo square in the middle of the page with the text
//   Taps: 0  and a small hand icon in its top-right corner, and under it
//   the hint  Tap = +1, long press = reset.
//   Each tap on the square adds 1 (Taps: 1, Taps: 2, ...).
//   A long press (press and hold) sets it back to Taps: 0.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const GestureApp());

class GestureApp extends StatelessWidget {
  const GestureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Gestures')),
        body: const Center(child: TapCounterBox()),
      ),
    );
  }
}

//#region notes
class TapCounterBox extends StatefulWidget {
  const TapCounterBox({super.key});

  @override
  State<TapCounterBox> createState() => _TapCounterBoxState();
}

class _TapCounterBoxState extends State<TapCounterBox> {
  int _taps = 0; // the state: it changes while the app runs

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The GestureDetector listens to touches on everything inside it.
        GestureDetector(
          key: const ValueKey('touch-area'),
          onTap: () => setState(() => _taps++),
          onLongPress: () => setState(() => _taps = 0),
          child: Stack(
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.indigo.shade100,
                alignment: Alignment.center,
                child:
                    Text('Taps: $_taps', style: const TextStyle(fontSize: 24)),
              ),
              // Positioned puts the icon in the top-right corner of the Stack.
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.touch_app),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text('Tap = +1, long press = reset'),
      ],
    );
  }
}

//#endregion notes
