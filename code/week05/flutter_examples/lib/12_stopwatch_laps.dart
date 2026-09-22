// =====================================================================
// Week 5 - The stopwatch, step 3: laps and a scrolling list
// =====================================================================
// WHAT YOU LEARN
//   * The stopwatch now counts in tenths of a second (a tick every 100 ms), and
//     a Lap button stores the time of each lap in a list and starts the next one.
//   * A ListView shows a list of widgets one after another, like a Column, but
//     it SCROLLS when the content is taller than the space it has. Column does
//     not: it would overflow.
//   * Collection-for builds the widgets from the data, inside the list:
//         ListView(children: [ for (final ms in _laps) ListTile(...) ])
//   * A ListView needs a bounded height. Put directly in a Column, it gets an
//     unlimited height and Flutter stops with an error ("Vertical viewport was
//     given unbounded height"), and the list disappears. Wrap it in Expanded:
//     it gets the remaining height. Here two Expanded children share the
//     screen equally, the counter on top and the laps below.
//     Rule: "constraints go down, sizes go up".
//   * The build method got long, so we split it into small methods that return
//     a Widget: _buildCounter, _buildControls, _buildLapDisplay (in Android
//     Studio and VS Code: Extract Method / Extract Widget).
//   * The Lap button is active only while the stopwatch runs (onPressed: null
//     otherwise). Start clears the laps.
//   * The time is counted by adding 100 at each tick. A Timer is not exact, so
//     after a long time it drifts. For a precise stopwatch, use Dart's
//     Stopwatch class (it reads the clock) and let the Timer only redraw.
//
// HOW TO RUN
//   flutter run -t lib/12_stopwatch_laps.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The top half is a blue panel: "Lap 1", "0.0 seconds", and the buttons START
//   (green), LAP (yellow, grey when stopped) and STOP (red). The bottom half is
//   an empty list. Press START: the tenths of seconds run. Press LAP: a row
//   with "Lap 1" and its time, for example "3.2 seconds", is added to the list,
//   the panel says "Lap 2" and its time starts again from 0. After a few laps
//   the list scrolls. START clears the list.
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
  int _milliseconds = 0; // the time of the current lap
  bool _isTicking = false;
  Timer? _timer;
  final List<int> _laps = []; // the time of each finished lap

  void _onTick(Timer time) {
    if (mounted) {
      setState(() {
        _milliseconds += 100;
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
    setState(() {
      _milliseconds = 0;
      _laps.clear();
      _isTicking = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isTicking = false;
    });
  }

  void _lap() {
    setState(() {
      _laps.add(_milliseconds);
      _milliseconds = 0;
    });
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '${seconds.toStringAsFixed(1)} seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stopwatch')),
      body: Column(
        children: [
          // Each Expanded takes half of the screen.
          Expanded(child: _buildCounter(context)),
          Expanded(child: _buildLapDisplay()),
        ],
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .headlineSmall!
        .copyWith(color: Theme.of(context).colorScheme.onPrimary);
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Lap ${_laps.length + 1}', style: style),
          Text(_secondsText(_milliseconds), style: style),
          const SizedBox(height: 20),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          onPressed: _isTicking ? null : _startTimer,
          child: const Text('Start'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
          ),
          onPressed: _isTicking ? _lap : null,
          child: const Text('Lap'),
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
    );
  }

  Widget _buildLapDisplay() {
    return ListView(
      children: [
        // collection-for: one ListTile for each lap
        for (var i = 0; i < _laps.length; i++)
          ListTile(
            leading: Text('Lap ${i + 1}'),
            title: Text(_secondsText(_laps[i])),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
