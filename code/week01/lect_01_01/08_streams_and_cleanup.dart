// Source: 002_lect_01_01.tex, section 2.3 Asynchronous Programming - Streams and Cleanup in Stateful Widgets
// Flutter widget.

import 'dart:async';
import 'package:flutter/material.dart';

class UserActivity {}

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
  late final UserActivityTracker _tracker;
  StreamSubscription<UserActivity>? _sub;

  @override
  void initState() {
    super.initState();
    _tracker = UserActivityTracker();
    _sub = _tracker.stream.listen((a) {
      // handle activity
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    _tracker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
