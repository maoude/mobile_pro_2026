// =====================================================================
// Lecture 1.1, section 2.3: Streams and cleanup
// =====================================================================
// WHAT YOU LEARN
//   * A Stream delivers MANY values over time (a Future delivers one).
//   * StreamController lets you push values into a stream with add().
//   * A "broadcast" stream can have several listeners.
//   * ALWAYS clean up: cancel the subscription and close the controller
//     when you are done, otherwise the program leaks memory.
//     (In Flutter this cleanup goes in State.dispose(); see the Flutter
//     version of this example in ../flutter_examples/lib/08_stream_cleanup.dart)
//
// HOW TO RUN
//   dart run 08_streams_and_cleanup.dart
//
// EXPECTED OUTPUT
//   listener got: login
//   listener got: open_profile
//   after cancel: the listener no longer receives events
//   tracker closed: true
// =====================================================================

import 'dart:async'; // StreamController, StreamSubscription

// A tiny event object.
class UserActivity {
  const UserActivity(this.action);
  final String action;
}

class UserActivityTracker {
  // .broadcast() allows more than one listener at the same time.
  final _controller = StreamController<UserActivity>.broadcast();

  // Other code only gets the read-only Stream, not the controller.
  Stream<UserActivity> get stream => _controller.stream;

  // Push an event into the stream.
  void add(UserActivity a) => _controller.add(a);

  // Closing the controller ends the stream and frees its resources.
  void dispose() => _controller.close();

  bool get isClosed => _controller.isClosed;
}

Future<void> main() async {
  final tracker = UserActivityTracker();

  // listen() returns a StreamSubscription: keep it so you can cancel it.
  final StreamSubscription<UserActivity> sub = tracker.stream.listen(
    (a) => print('listener got: ${a.action}'),
  );

  tracker.add(const UserActivity('login'));
  tracker.add(const UserActivity('open_profile'));
  // Stream events are delivered asynchronously. Waiting for one "turn" of
  // the event loop lets the listener run before we continue.
  await Future<void>.delayed(Duration.zero);

  // CLEANUP step 1: stop listening.
  await sub.cancel();
  tracker.add(const UserActivity('ignored')); // nobody is listening: no output
  await Future<void>.delayed(Duration.zero);
  print('after cancel: the listener no longer receives events');

  // CLEANUP step 2: close the controller.
  tracker.dispose();
  print('tracker closed: ${tracker.isClosed}');
}
