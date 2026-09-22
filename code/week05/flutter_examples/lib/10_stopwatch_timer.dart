// =====================================================================
// Week 5 - The stopwatch, step 1: state that changes by itself (a Timer)
// =====================================================================
// WHAT YOU LEARN
//   * From here to example 12 we build ONE app step by step: a stopwatch that
//     counts, starts and stops, and remembers laps. The first step is a
//     counter that goes up once a second, with no button.
//   * Until now the state changed when the USER did something (a tap, a
//     letter). Here it changes when TIME passes. A Timer.periodic calls a
//     function again and again. In that function we change the number inside
//     setState, and Flutter draws the new text.
//   * The three life cycle methods used (example 09):
//       initState  creates the Timer, once, when the State is created
//       build      draws the number
//       dispose    cancels the Timer when the screen is closed
//     Without dispose the Timer would keep ticking after the widget has been
//     destroyed: a memory leak, strange behaviour, sometimes a crash.
//   * "if (mounted)": a Timer can tick after the widget has left the tree.
//     Calling setState then stops the app with the error "setState() called
//     after dispose()". mounted is false in that case.
//   * "late final Timer _timer" says: I will give it a value before it is
//     used. It is safe here because initState always runs first. (In example
//     11 the Timer is created later, by a button, so it will be nullable.)
//   * The text uses the singular for one second: "1 second", "2 seconds".
//   * Theme.of(context).textTheme.headlineSmall is a ready-made text style
//     of the theme (the old name was headline5).
//
// HOW TO RUN
//   flutter run -t lib/10_stopwatch_timer.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   An app bar "Stopwatch" and, in the middle, "0 seconds". One second later
//   "1 second", then "2 seconds", "3 seconds", and so on, by itself.
// =====================================================================

import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const StopWatchApp());

class StopWatchApp extends StatelessWidget {
  const StopWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StopWatch(),
    );
  }
}

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int _seconds = 0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer time) {
    if (mounted) {
      setState(() {
        ++_seconds;
      });
    }
  }

  String _secondsText() => _seconds == 1 ? 'second' : 'seconds';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stopwatch')),
      body: Center(
        child: Text(
          '$_seconds ${_secondsText()}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // stop ticking when the screen is closed
    super.dispose();
  }
}
