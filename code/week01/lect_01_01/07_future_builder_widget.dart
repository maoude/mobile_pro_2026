// Source: 002_lect_01_01.tex, section 2.3 Asynchronous Programming - FutureBuilder / StreamBuilder
// Flutter + package:provider. Needs User (03), ProfileCard (04) and UserRepository (05).

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatelessWidget {
  final String userId;
  const UserProfileView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<UserRepository>();
    return FutureBuilder<List<User>>(
      future: repo.getUsers(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final users = snapshot.data ?? const <User>[];
            return ListView(
              children: users.map((u) => ProfileCard(user: u)).toList(),
            );
        }
      },
    );
  }
}
