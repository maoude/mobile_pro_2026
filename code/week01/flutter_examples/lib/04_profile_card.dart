// =====================================================================
// Lecture 1.1, section 2.2: A reusable widget built by composition
// =====================================================================
// WHAT YOU LEARN
//   * A StatelessWidget is a widget that never changes by itself: it just
//     turns its (final) inputs into a piece of UI in build().
//   * Composition: ProfileCard is built from small ready-made widgets
//     (Card, ListTile, CircleAvatar, Text) instead of inheriting from them.
//   * "const" constructors let Flutter reuse widgets and rebuild less.
//   * VoidCallback? onTap is an optional function passed in by the parent.
//
// HOW TO RUN
//   flutter run -t lib/04_profile_card.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   An app bar titled "ProfileCard" and one card in the middle showing:
//     * a round avatar with the letter  J
//     * the title      John
//     * the subtitle   john@example.com
//   Tapping the card shows a message at the bottom: "Tapped John".
// =====================================================================

import 'package:flutter/material.dart';

import 'models/user.dart';

class ProfileCard extends StatelessWidget {
  final User user; // the data to show
  final VoidCallback? onTap; // what to do when tapped (optional)

  // "const" + super.key: the standard way to declare a widget constructor.
  const ProfileCard({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    // build() describes the UI as a tree of widgets.
    return Card(
      child: ListTile(
        // The avatar shows the first letter of the name ('?' if it is empty).
        leading: CircleAvatar(
          child: Text(user.name.isNotEmpty ? user.name[0] : '?'),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        onTap: onTap,
      ),
    );
  }
}

// ---------------- Demo app (only used when this file is run) ----------------
void main() => runApp(const ProfileCardApp());

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = User(id: '1', name: 'John', email: 'john@example.com');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ProfileCard')),
        // Builder gives us a context that is BELOW the Scaffold, which
        // ScaffoldMessenger needs in order to show the SnackBar.
        body: Builder(
          builder: (context) => Center(
            child: ProfileCard(
              user: user,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped ${user.name}')),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
