// =====================================================================
// Week 5 - The stopwatch, step 2: Start and Stop buttons
// =====================================================================
// WHAT YOU LEARN
//   * Now the USER controls the timer with two buttons of two different
//     styles: an ElevatedButton (Start) and a TextButton (Stop). Buttons look
//     different but have the same API: a child and an onPressed function.
//     Other buttons: IconButton, FloatingActionButton, OutlinedButton,
//     FilledButton, DropdownButton, CupertinoButton.
//   * onPressed: null DISABLES a button (it turns grey and ignores touches).
//     A ternary expression chooses:
//         onPressed: _isTicking ? null : _startTimer     (Start)
//         onPressed: _isTicking ? _stopTimer : null      (Stop)
//     Only one of the two buttons is active at any time. _isTicking is state,
//     so changing it in setState redraws both buttons.
//   * _startTimer has NO parentheses: we pass the function, we do not call it.
//   * The Timer is now created by a button, not in initState, so it may not
//     exist yet when the screen closes. It is nullable (Timer?), and dispose
//     uses _timer?.cancel(). (With "late Timer timer" and no Start ever
//     pressed, dispose would stop the app with a LateInitializationError.)
//   * Two ways to style a button:
//       ElevatedButton.styleFrom(backgroundColor:, foregroundColor:)   simple
//       ButtonStyle(backgroundColor: WidgetStateProperty.all(color))   a
//           different value for each state (pressed, hovered, disabled...).
//     With .all(color) the SAME color is used when the button is disabled, so a
//     disabled button does not look disabled. styleFrom keeps the grey look.
//   * onPressed can be a method (as here) or a closure, () { ... }. Methods read
//     better as soon as the code is more than a line or two.
//
// HOW TO RUN
//   flutter run -t lib/11_stopwatch_buttons.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   "0 seconds" and two buttons: a green START and a grey (disabled) STOP.
//   Press START: the seconds go up once a second, START becomes grey and STOP
//   turns red. Press STOP: the count stops, START is active again. Press START
//   again: the count starts again from 0.
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
  bool _isTicking = false;
  Timer? _timer; // null until Start is pressed

  void _onTick(Timer time) {
    if (mounted) {
      setState(() {
        ++_seconds;
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    setState(() {
      _seconds = 0;
      _isTicking = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isTicking = false;
    });
  }

  String _secondsText() => _seconds == 1 ? 'second' : 'seconds';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stopwatch')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_seconds ${_secondsText()}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                // null disables the button.
                onPressed: _isTicking ? null : _startTimer,
                child: const Text('Start'),
              ),
              const SizedBox(width: 20),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: _isTicking ? _stopTimer : null,
                child: const Text('Stop'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
