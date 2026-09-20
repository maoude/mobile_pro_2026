// =====================================================================
// Lecture 1.1, section 2.4: Null safety
// =====================================================================
// WHAT YOU LEARN
//   * A normal type (String) can NEVER be null. Add "?" (String?) when a
//     value may be missing. Dart checks this before the program runs.
//   * "??" gives a fallback when the value is null.
//   * "?." reads a member only when the object is not null (else null).
//   * "late final" promises to assign a value before it is first used.
//     Use it sparingly: if you break the promise, the program crashes.
//
// (ApiClient below is a tiny stand-in added so the example can run; the
//  lecture used a real API client.)
//
// HOW TO RUN
//   dart run 09_null_safety_basics.dart
//
// EXPECTED OUTPUT
//   nonNull: John
//   maybeNull: null
//   maybeNull after assignment: Now I have a value
//   display(null): Anonymous
//   display('Sara'): Sara
//   len(null): null
//   len('hello'): 5
//   Before init(): LateInitializationError
//   user 7 from https://api.example.com
// =====================================================================

// "name ?? 'Anonymous'": use name if it is not null, otherwise 'Anonymous'.
String display(String? name) => name ?? 'Anonymous';

// "s?.length": the length if s is not null, otherwise null.
// The result type is int? because it may be null.
int? len(String? s) => s?.length;

// Stand-in for a real API client (added for this demo).
class ApiClient {
  ApiClient(this.base);
  final String base;
  Future<String> fetchUser(String id) async => 'user $id from $base';
}

class Service {
  // "late final": no value yet, but we promise to set it exactly once
  // (in init) before anybody reads it.
  late final ApiClient _client;

  void init(String base) {
    _client = ApiClient(base);
  }

  Future<String> getUser(String id) => _client.fetchUser(id);
}

Future<void> main() async {
  String nonNull = 'John'; // can never be null
  String? maybeNull; // may be null; starts as null
  print('nonNull: $nonNull');
  print('maybeNull: $maybeNull');
  maybeNull = 'Now I have a value';
  print('maybeNull after assignment: $maybeNull');

  print("display(null): ${display(null)}");
  print("display('Sara'): ${display('Sara')}");
  print("len(null): ${len(null)}");
  print("len('hello'): ${len('hello')}");

  // late final: reading it BEFORE init() breaks the promise -> crash.
  final service = Service();
  try {
    await service.getUser('7');
  } on Error catch (e) {
    // Dart throws an Error when a "late" variable is read before it was
    // given a value. Its message starts with "LateInitializationError:",
    // e.g. "LateInitializationError: Field '_client' has not been
    // initialized." (there is no public class to catch, so we read the
    // text before the first colon).
    print('Before init(): ${e.toString().split(':').first}');
  }

  // Keeping the promise: initialise first, then use.
  service.init('https://api.example.com');
  print(await service.getUser('7'));
}
