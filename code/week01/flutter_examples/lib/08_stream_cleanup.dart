// =====================================================================
// Lecture 1.1, section 2.3: Streams and cleanup in a StatefulWidget
// =====================================================================
// WHAT YOU LEARN
//   * A StatefulWidget keeps data that changes (its State object).
//   * initState() runs once when the widget is created: start listening.
//   * dispose() runs once when the widget is removed: ALWAYS cancel the
//     subscription and close the controller, or you leak memory.
//   * setState() tells Flutter the data changed, so build() runs again.
//
// (The lecture's version drew nothing; a counter and a button were added
//  here so you can SEE the stream working.)
//
// HOW TO RUN
//   flutter run -t lib/08_stream_cleanup.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   Start:   "Activities received: 0"   and   "Last activity: none"
//   Each tap on the round + button sends one event through the stream:
//   after the 1st tap:  "Activities received: 1"  /  "Last activity: tap #1"
//   after the 2nd tap:  "Activities received: 2"  /  "Last activity: tap #2"
// =====================================================================

import 'dart:async';

import 'package:flutter/material.dart';

class UserActivity {
  const UserActivity(this.action);
  final String action;
}

class UserActivityTracker {
  final _controller = StreamController<UserActivity>.broadcast();
  Stream<UserActivity> get stream => _controller.stream;
  void add(UserActivity a) => _controller.add(a);
  void dispose() => _controller.close();
}

class ActivityTrackerView extends StatefulWidget {
  const ActivityTrackerView({super.key});

  @override
  State<ActivityTrackerView> createState() => _ActivityTrackerViewState();
}

class _ActivityTrackerViewState extends State<ActivityTrackerView> {
  // "late final": created in initState, exactly once.
  late final UserActivityTracker _tracker;
  StreamSubscription<UserActivity>? _sub;
  int _count = 0;
  String _last = 'none';

  @override
  void initState() {
    super.initState();
    _tracker = UserActivityTracker();
    // Start listening. Every event updates the state and redraws the UI.
    _sub = _tracker.stream.listen((a) {
      setState(() {
        _count++;
        _last = a.action;
      });
    });
  }

  @override
  void dispose() {
    // CLEANUP: stop listening, then close the stream. Order matters little,
    // but forgetting either one is a memory leak.
    _sub?.cancel();
    _tracker.dispose();
    super.dispose(); // always call super.dispose() last
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Streams and cleanup')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Activities received: $_count'),
            Text('Last activity: $_last'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Sending an event: the listener above receives it.
        onPressed: () => _tracker.add(UserActivity('tap #${_count + 1}')),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ---------------- Demo app (only used when this file is run) ----------------
void main() => runApp(const ActivityTrackerApp());

class ActivityTrackerApp extends StatelessWidget {
  const ActivityTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ActivityTrackerView());
  }
}
