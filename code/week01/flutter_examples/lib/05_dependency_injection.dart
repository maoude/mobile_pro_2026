// =====================================================================
// Lecture 1.1, section 2.2: Dependency injection with Provider
// =====================================================================
// WHAT YOU LEARN
//   * Instead of creating its own helpers, a class RECEIVES them
//     (dependency injection). Widgets ask Provider for what they need.
//   * MultiProvider registers several providers at the top of the app.
//   * ProxyProvider2 builds a UserRepository from the ApiService and the
//     CacheService that were registered before it.
//   * To switch to a real server, change ONE line here (register a real
//     ApiService); no widget has to change.
//
// HOW TO RUN
//   flutter run -t lib/05_dependency_injection.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   An app bar titled "Users (via Provider)". After a short spinner
//   (about 0.2 s) three cards appear: Alice, Bob and Carol.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '07_future_builder.dart';
import 'data/user_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Register the ABSTRACT types, with a concrete (fake) object each.
        Provider<ApiService>(create: (_) => FakeApiService()),
        Provider<CacheService>(create: (_) => InMemoryCacheService()),
        // Build the repository from the two providers registered above.
        ProxyProvider2<ApiService, CacheService, UserRepository>(
          update: (_, api, cache, previous) => UserRepository(api, cache),
        ),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );
  }
}

// The lecture did not define HomeScreen; this is a minimal one.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users (via Provider)')),
      // UserProfileView finds the UserRepository with context.read.
      body: const UserProfileView(userId: 'demo'),
    );
  }
}

void main() => runApp(const MyApp());
