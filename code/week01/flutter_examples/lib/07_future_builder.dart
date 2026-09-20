// =====================================================================
// Lecture 1.1, section 2.3: FutureBuilder (connect async data to widgets)
// =====================================================================
// WHAT YOU LEARN
//   * FutureBuilder rebuilds its UI when a Future changes state:
//       waiting -> show a spinner;  error -> show the error;
//       done    -> show the data.
//   * context.read<T>() gets an object supplied by Provider (dependency
//     injection) WITHOUT listening for changes.
//   * The Future is created ONCE in initState. If you wrote
//     future: repo.getUsers() inside build(), every rebuild would start a
//     new request. (The lecture kept it in build for brevity.)
//
// HOW TO RUN
//   flutter run -t lib/07_future_builder.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   1. For about 0.2 seconds: a spinning progress indicator in the middle.
//   2. Then a list of three cards:
//        Alice  alice@example.com
//        Bob    bob@example.com
//        Carol  carol@example.com
// =====================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '04_profile_card.dart';
import 'data/user_repository.dart';
import 'models/user.dart';

class UserProfileView extends StatefulWidget {
  final String userId;
  const UserProfileView({super.key, required this.userId});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  // The Future is stored so it is created only once.
  late final Future<List<User>> _users;

  @override
  void initState() {
    super.initState();
    // context.read gets the UserRepository that Provider placed higher up
    // in the widget tree.
    _users = context.read<UserRepository>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _users,
      builder: (context, snapshot) {
        // connectionState tells us where the Future is in its life.
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            // "?? const <User>[]": an empty list if there is no data.
            final users = snapshot.data ?? const <User>[];
            return ListView(
              children: users.map((u) => ProfileCard(user: u)).toList(),
            );
        }
      },
    );
  }
}

// ---------------- Demo app (only used when this file is run) ----------------
void main() => runApp(const FutureBuilderApp());

class FutureBuilderApp extends StatelessWidget {
  const FutureBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('FutureBuilder')),
        // Provider.value makes ONE repository available to everything below.
        body: Provider<UserRepository>.value(
          value: UserRepository(FakeApiService(), InMemoryCacheService()),
          child: const UserProfileView(userId: 'demo'),
        ),
      ),
    );
  }
}
