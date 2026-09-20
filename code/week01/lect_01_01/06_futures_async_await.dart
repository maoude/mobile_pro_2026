// =====================================================================
// Lecture 1.1, section 2.3: Futures, async/await and Future.wait
// =====================================================================
// WHAT YOU LEARN
//   * A Future<T> is a value that will arrive LATER (e.g. from the network).
//   * "async" marks a function that can wait; "await" pauses it until the
//     Future is ready, WITHOUT freezing the app.
//   * Future.wait runs several Futures in parallel: total time = the
//     slowest one, not the sum of all.
//   * try / catch / finally handle errors from awaited calls.
//
// The lecture fetched data with package:http. To keep this file runnable
// without any package or internet, the network calls are SIMULATED with
// Future.delayed (each one takes 300 ms). The real version looks like:
//
//   final r = await http.get(Uri.parse('https://api.example.com/users/$id'));
//   if (r.statusCode == 200) return r.body;
//   throw HttpException('Failed: ${r.statusCode}');
//
// HOW TO RUN
//   dart run 06_futures_async_await.dart
//
// EXPECTED OUTPUT
//   1) One awaited call
//      got: User#42
//   2) Three calls in parallel with Future.wait
//      user=User#42, prefs={theme: dark}, activity=[login, view_profile]
//      finished in under 600 ms (parallel): true
//   3) Type-safe version with a record of Futures (Dart 3)
//      USER#42 has 2 activities and theme dark
//   4) Error handling
//      caught: userId must not be empty
//      (finally always runs)
// =====================================================================

// A simulated slow network call: it "waits" 300 ms, then returns a value.
Future<String> fetchUserData(String userId) async {
  await Future<void>.delayed(const Duration(milliseconds: 300));
  if (userId.isEmpty) {
    // Throwing inside an async function makes the Future complete with
    // an error, which the caller can catch.
    throw ArgumentError('userId must not be empty');
  }
  return 'User#$userId';
}

Future<Map<String, String>> fetchUserPreferences(String userId) async {
  await Future<void>.delayed(const Duration(milliseconds: 300));
  return {'theme': 'dark'};
}

Future<List<String>> fetchUserActivity(String userId) async {
  await Future<void>.delayed(const Duration(milliseconds: 300));
  return ['login', 'view_profile'];
}

// main() is async too, so it can use await.
Future<void> main() async {
  // ---- 1) A single call ----
  print('1) One awaited call');
  final one = await fetchUserData('42'); // waits ~300 ms
  print('   got: $one');

  // ---- 2) Three calls in PARALLEL with Future.wait ----
  print('2) Three calls in parallel with Future.wait');
  final watch = Stopwatch()..start();
  final results = await Future.wait<Object>([
    fetchUserData('42'),
    fetchUserPreferences('42'),
    fetchUserActivity('42'),
  ]);
  // A list pattern takes the list apart. Each element has type Object
  // because the three Futures return different types.
  final [userData, prefs, activity] = results;
  print('   user=$userData, prefs=$prefs, activity=$activity');
  // One after another this would take about 900 ms; in parallel about 300 ms.
  print(
    '   finished in under 600 ms (parallel): ${watch.elapsedMilliseconds < 600}',
  );

  // ---- 3) The type-safe way: a RECORD of Futures + .wait (Dart 3) ----
  // Every value keeps its own type: u is a String, p a Map, a a List.
  print('3) Type-safe version with a record of Futures (Dart 3)');
  final (u, p, a) = await (
    fetchUserData('42'),
    fetchUserPreferences('42'),
    fetchUserActivity('42'),
  ).wait;
  print(
    '   ${u.toUpperCase()} has ${a.length} activities and theme ${p['theme']}',
  );

  // ---- 4) Error handling ----
  print('4) Error handling');
  try {
    await fetchUserData(''); // this Future completes with an error
  } on ArgumentError catch (e) {
    // "on Type catch" handles only errors of that type.
    print('   caught: ${e.message}');
  } finally {
    // finally runs whether or not an error happened (good for cleanup).
    print('   (finally always runs)');
  }
}
