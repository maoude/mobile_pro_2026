// =====================================================================
// Lecture 1.1, section 2.4: Records, patterns and sealed classes (Dart 3)
// =====================================================================
// WHAT YOU LEARN
//   * A record groups several values without writing a class:
//       positional (1080, 1920)   or   named (name: 'Ali', age: 30)
//   * A sealed class has a FIXED set of subclasses. A switch over it must
//     handle every subclass, or the code does not compile. That means you
//     can never forget a case (loading, success, failure...).
//
// The lecture returned Flutter widgets from the switch. Here it returns
// text so the file runs with plain Dart; the widget version is in
// ../flutter_examples/lib/13_load_state_ui.dart
//
// HOW TO RUN
//   dart run 13_records_and_sealed_classes.dart
//
// EXPECTED OUTPUT
//   name=Ali, age=30
//   size: 1080 x 1920
//   Loading...
//   Data: 42
//   Error: timeout
// =====================================================================

// ---------------- Records ----------------
// A typedef gives a name to a record shape.
typedef UserInfo = ({String name, int age});

// Build a record with named fields.
UserInfo mk(String n, int a) => (name: n, age: a);

// A function can return several values at once with a positional record.
(int, int) screenSize() => (1080, 1920);

// ---------------- Sealed classes ----------------
// "sealed": only classes in THIS file can extend LoadState, so the
// compiler knows every possible case.
sealed class LoadState<T> {
  const LoadState();
}

class Loading<T> extends LoadState<T> {
  const Loading();
}

class Success<T> extends LoadState<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends LoadState<T> {
  final String message;
  const Failure(this.message);
}

// A switch expression over a sealed class must be EXHAUSTIVE. If you
// delete one line below (or add a new subclass), Dart reports an error.
String describe<T>(LoadState<T> s) => switch (s) {
  Loading() => 'Loading...',
  // "final d" reads the field named data into a new variable d.
  Success(data: final d) => 'Data: $d',
  Failure(message: final m) => 'Error: $m',
};

void main() {
  // Named record: access the fields by name.
  final user = mk('Ali', 30);
  print('name=${user.name}, age=${user.age}');

  // Positional record: take it apart with a pattern (destructuring).
  final (width, height) = screenSize();
  print('size: $width x $height');

  // The three states of a loading screen.
  final states = <LoadState<int>>[
    const Loading(),
    const Success(42),
    const Failure('timeout'),
  ];
  for (final s in states) {
    print(describe(s));
  }
}
