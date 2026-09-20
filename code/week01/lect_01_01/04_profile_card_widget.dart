// Source: 002_lect_01_01.tex, section 2.2 OOP in Dart - Widget-Specific OOP Patterns (Composition)
// Flutter widget. Needs the User class from 03_user_model.dart.

import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;
  const ProfileCard({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
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
