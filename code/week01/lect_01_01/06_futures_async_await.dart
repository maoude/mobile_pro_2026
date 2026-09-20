// Source: 002_lect_01_01.tex, section 2.3 Asynchronous Programming - Futures & Async/Await
// Needs package:http. fetchUserPreferences and fetchUserActivity are not defined in the lecture.

import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> fetchUserData(String userId) async {
  try {
    final r = await http.get(
      Uri.parse('https://api.example.com/users/$userId'),
    );
    if (r.statusCode == 200) return r.body;
    throw HttpException('Failed: ${r.statusCode}');
  } catch (e, st) {
    // Local handling; consider global handlers too.
    throw Exception('Network error: $e\n$st');
  }
}

// Parallel tasks with Future.wait (destructuring)
Future<void> buildUserProfile(String userId) async {
  final results = await Future.wait([
    fetchUserData(userId),
    fetchUserPreferences(userId),
    fetchUserActivity(userId),
  ]);
  final [userData, prefs, activity] = results;
  // Use userData (String), prefs (Map), activity (List) as needed.
}
