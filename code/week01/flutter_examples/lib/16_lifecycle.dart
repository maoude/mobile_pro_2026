// =====================================================================
// Lecture 1.1, section 3.3: Widget lifecycle and resource management
// =====================================================================
// WHAT YOU LEARN
//   * initState()  : runs once when the State is created -> start timers,
//                    listeners, controllers here.
//   * dispose()    : runs once when the State is removed -> release EVERYTHING
//                    you started in initState (cancel timers, remove
//                    observers). Forgetting this leaks resources.
//   * WidgetsBindingObserver lets a State hear about app-level events such
//     as "the app went to the background" (didChangeAppLifecycleState).
//
// (The lecture left the resource comments empty; a real Timer and a
//  lifecycle display were added here so the example does something.)
//
// HOW TO RUN
//   flutter run -t lib/16_lifecycle.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   Two lines of text in the centre:
//     Ticks: 0   -> goes up by 1 every second: Ticks: 1, Ticks: 2, ...
//     Lifecycle: unknown
//   When you put the app in the background and bring it back, the second
//   line changes (for example to "Lifecycle: paused", then "resumed").
// =====================================================================

import 'dart:async';

import 'package:flutter/material.dart';

class TimerDemo extends StatefulWidget {
  const TimerDemo({super.key});

  @override
  State<TimerDemo> createState() => _TimerDemoState();
}

class _TimerDemoState extends State<TimerDemo> with WidgetsBindingObserver {
  Timer? _timer; // a resource that MUST be released
  int _ticks = 0;
  AppLifecycleState? _lifecycle;

  @override
  void initState() {
    super.initState();
    // Start listening to app lifecycle events.
    WidgetsBinding.instance.addObserver(this);
    // Start a timer that fires every second.
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() => _ticks++),
    );
  }

  // Called by Flutter (because of WidgetsBindingObserver) when the app
  // moves between foreground and background.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() => _lifecycle = state);
  }

  @override
  void dispose() {
    // Release what initState started, in any order, before super.dispose().
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Ticks: $_ticks'),
        Text('Lifecycle: ${_lifecycle?.name ?? 'unknown'}'),
      ],
    );
  }
}

// ---------------- Demo app (only used when this file is run) ----------------
void main() => runApp(const LifecycleApp());

class LifecycleApp extends StatelessWidget {
  const LifecycleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: TimerDemo())),
    );
  }
}
