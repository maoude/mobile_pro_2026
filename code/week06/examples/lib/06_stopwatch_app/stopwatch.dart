// The stopwatch screen. It receives the runner's name and email from the
// login screen through its constructor, and adds to example 00:
//   * a PlatformAlert with the total time when the stopwatch stops (03),
//   * a modal bottom sheet with the details of a lap when it is tapped (05),
//   * a Log out button that asks for confirmation with a dialog that returns
//     a bool (04), then replaces this screen by the login screen (02).

import 'dart:async';

import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'platform_alert.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key, required this.name, required this.email});

  final String name;
  final String email;

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

    // The finished laps plus the lap that was running.
    final totalRuntime = _laps.fold(_milliseconds, (total, lap) => total + lap);
    PlatformAlert(
      title: 'Run completed!',
      message: 'Total run time is ${_secondsText(totalRuntime)}.',
    ).show(context);
  }

  void _lap() {
    setState(() {
      _laps.add(_milliseconds);
      _milliseconds = 0;
    });
    _scrollToEnd();
  }

  // Every row is itemHeight tall, so the end of the list is known exactly
  // (example 00).
  void _scrollToEnd() {
    if (!_scrollController.hasClients) return;
    final visibleHeight = _scrollController.position.viewportDimension;
    final end = itemHeight * _laps.length - visibleHeight;
    if (end <= 0) return;
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

  void _showLapDetails(int index) {
    final time = _laps[index];
    final fastest = _laps.reduce((a, b) => a < b ? a : b);
    final behind = time - fastest;
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Lap ${index + 1}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(_secondsText(time)),
              Text(
                behind == 0
                    ? 'Fastest lap'
                    : '${_secondsText(behind)} slower than the fastest lap',
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logOut() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out?'),
        content: Text('The laps of ${widget.name} will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: _logOut,
          ),
        ],
      ),
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
            onTap: () => _showLapDetails(index),
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
