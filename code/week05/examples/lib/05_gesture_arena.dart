// =====================================================================
// Week 5, part 2 - Gestures: several detectors at the same place (the arena)
// =====================================================================
// WHAT YOU LEARN
//   * Often two GestureDetectors are at the same place on the screen: a big
//     parent and a small child inside it, both with onTap. When the user taps
//     the child, who receives the tap?
//   * Flutter runs an ARENA: every detector under the finger enters a
//     competition, and only ONE wins the gesture. For a tap in the child, the
//     innermost (deepest) detector wins: the child gets onTap, the parent gets
//     nothing. This is the default, and it is what you want most of the time
//     (a button inside a card must not also trigger the card).
//   * If you really want both to react, you must change the rules with a
//     RawGestureDetector. It takes a map of "gesture factories" and lets you
//     use your own GestureRecognizer. Here AllowMultipleGestureRecognizer is a
//     TapGestureRecognizer that, when it loses the arena, accepts the gesture
//     anyway (rejectGesture calls acceptGesture): so the child AND the parent
//     both get their onTap.
//   * GestureRecognizerFactoryWithHandlers has two functions: one creates the
//     recognizer, the other sets its callbacks (onTap ...).
//   * The results are shown on the screen with counters (a real app prints to
//     the console, but you cannot see the console on a phone).
//
// HOW TO RUN
//   flutter run -t lib/05_gesture_arena.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   Two demos side by side, each a yellow square with an orange square inside.
//     Left  "Default":  tap the orange square: the "child" counter goes up, the
//                       "parent" counter does not. Tap the yellow border: only
//                       "parent" goes up.
//     Right "Multiple": tap the orange square: BOTH counters go up. Tap the
//                       yellow border: only "parent" goes up.
// =====================================================================

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Gesture arena'), centerTitle: true),
        body: const GestureArenaPage(),
      ),
    );
  }
}

// A tap recognizer that also accepts the gesture when it LOSES the arena.
class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}

class GestureArenaPage extends StatefulWidget {
  const GestureArenaPage({super.key});

  @override
  State<GestureArenaPage> createState() => _GestureArenaPageState();
}

class _GestureArenaPageState extends State<GestureArenaPage> {
  int _defaultParent = 0, _defaultChild = 0;
  int _multipleParent = 0, _multipleChild = 0;

  // A RawGestureDetector whose only gesture is our tap recognizer.
  Widget _multipleTap({required VoidCallback onTap, required Widget child}) {
    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: {
        AllowMultipleGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<AllowMultipleGestureRecognizer>(
          () => AllowMultipleGestureRecognizer(), // creates the recognizer
          (instance) {
            instance.onTap = onTap; // sets its callbacks
          },
        ),
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Default: the child wins, the parent gets nothing.
        Column(
          children: [
            const SizedBox(height: 16),
            const Text('Default',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('parent: $_defaultParent'),
            Text('child: $_defaultChild'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => setState(() => _defaultParent++),
              child: Container(
                key: const ValueKey('defaultParent'),
                width: 160,
                height: 220,
                color: Colors.yellow,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => setState(() => _defaultChild++),
                  child: Container(
                    key: const ValueKey('defaultChild'),
                    width: 100,
                    height: 120,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
          ],
        ),

        // 2. Multiple: both the child and the parent get the tap.
        Column(
          children: [
            const SizedBox(height: 16),
            const Text('Multiple',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('parent: $_multipleParent'),
            Text('child: $_multipleChild'),
            const SizedBox(height: 8),
            _multipleTap(
              onTap: () => setState(() => _multipleParent++),
              child: Container(
                key: const ValueKey('multipleParent'),
                width: 160,
                height: 220,
                color: Colors.yellow,
                alignment: Alignment.center,
                child: _multipleTap(
                  onTap: () => setState(() => _multipleChild++),
                  child: Container(
                    key: const ValueKey('multipleChild'),
                    width: 100,
                    height: 120,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
