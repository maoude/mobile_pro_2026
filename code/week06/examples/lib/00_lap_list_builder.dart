// =====================================================================
// Week 6, part 2 - The stopwatch, step 4: a lap list that can grow forever
// =====================================================================
// WHAT YOU LEARN
//   * Week 5 built the lap list with ListView(children: [...]): Flutter creates
//     a widget for EVERY lap, even the ones far off screen. ListView.builder
//     creates only the rows that are visible (plus a few around them), and asks
//     for the others when the user scrolls:
//         ListView.builder(
//           itemCount: _laps.length,             // how many rows in total
//           itemBuilder: (context, index) => ... // builds row number index
//         )
//     Without itemCount the list is INFINITE: itemBuilder is called with
//     index = _laps.length and _laps[index] throws a RangeError.
//   * itemExtent fixes the height of every row (here 60). Flutter no longer has
//     to measure each row, and the position of row n is simply n * 60.
//   * Scrollbar shows where you are in a long list. When the list has its own
//     ScrollController, give the SAME controller to the Scrollbar, so that
//     both follow the same scroll position.
//   * A ScrollController lets your code move the list: here, every new lap
//     scrolls the list to the bottom with animateTo. Like a Timer or a
//     TextEditingController, a ScrollController must be disposed in dispose().
//   * Where is the end of the list? Because every row is itemHeight tall, the
//     list is itemHeight * _laps.length tall, and its last row is fully
//     visible when we scroll to that height minus the height of the visible
//     part (position.viewportDimension). This is exact, and known even before
//     Flutter has built the new row: one more advantage of itemExtent.
//
// HOW TO RUN
//   flutter run -t lib/00_lap_list_builder.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The stopwatch of week 5: a blue panel on top with "Lap 1", "0.0 seconds"
//   and the buttons START, LAP and STOP, and a list below. Press START, then
//   LAP many times: each lap is a row "Lap n ... 1.3 seconds", the list
//   slides down by itself so the newest lap is always visible, and a
//   scrollbar appears on the right while you scroll.
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
  static const double itemHeight = 60;

  int _milliseconds = 0;
  bool _isTicking = false;
  Timer? _timer;
  final List<int> _laps = [];
  final ScrollController _scrollController = ScrollController();

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
    _scrollToEnd();
  }

  void _scrollToEnd() {
    if (!_scrollController.hasClients) return; // the list is not on screen
    final visibleHeight = _scrollController.position.viewportDimension;
    final end = itemHeight * _laps.length - visibleHeight;
    if (end <= 0) return; // every lap fits on the screen: nothing to do
    _scrollController.animateTo(
      end,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
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
    return Scrollbar(
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        itemExtent: itemHeight,
        itemCount: _laps.length,
        itemBuilder: (context, index) {
          final milliseconds = _laps[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50),
            title: Text('Lap ${index + 1}'),
            trailing: Text(_secondsText(milliseconds)),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }
}
