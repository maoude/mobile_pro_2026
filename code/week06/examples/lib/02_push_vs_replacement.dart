// =====================================================================
// Week 6, part 2 - push or pushReplacement: can the user come back?
// =====================================================================
// WHAT YOU LEARN
//   * The Navigator keeps the screens (routes) in a STACK (week 6, part 1).
//       push            puts the new route ON TOP of the current one:
//                       [Login, Welcome]   - Back returns to Login.
//       pushReplacement REPLACES the current route by the new one:
//                       [Welcome]          - there is nothing to go back to.
//     After a login, the login screen should not come back with the Back
//     button: that is the job of pushReplacement.
//   * The AppBar draws the back arrow BY ITSELF when there is a route below
//     it (Navigator.canPop(context) is true). We write no code for it.
//   * The data goes to the new screen through its CONSTRUCTOR, with typed,
//     required parameters (week 6, part 1, "constructor parameters"):
//         MaterialPageRoute(builder: (_) => WelcomeScreen(name: name))
//     In the State class the widget's fields are read with widget.name.
//   * builder: (_) => ... The underscore is the name of a parameter we do not
//     use (here the BuildContext). Flutter calls the builder only when the
//     route is really shown.
//   * pushAndRemoveUntil(route, (r) => false) pushes a route and removes ALL
//     the others: used here by "Log out" to start again from an empty stack.
//
// HOW TO RUN
//   flutter run -t lib/02_push_vs_replacement.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A "Login" screen with a "Runner" field (it contains "Lina") and two
//   buttons, PUSH and PUSH REPLACEMENT.
//     * PUSH: the screen "Hi Lina" opens, with a back arrow in its app bar,
//       and the text "Routes below this one: yes". The arrow returns to Login.
//     * PUSH REPLACEMENT: the same screen opens WITHOUT a back arrow, and the
//       text says "Routes below this one: no". On Android the system Back
//       button closes the app instead of returning to Login.
//     * LOG OUT (on the second screen) always returns to a fresh Login screen,
//       with no back arrow.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const RoutesApp());

class RoutesApp extends StatelessWidget {
  const RoutesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController(text: 'Lina');

  void _push() {
    final name = _nameController.text;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => WelcomeScreen(name: name)),
    );
  }

  void _pushReplacement() {
    final name = _nameController.text;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => WelcomeScreen(name: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Runner'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _push, child: const Text('Push')),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _pushReplacement,
              child: const Text('Push replacement'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.name});

  final String name;

  void _logOut(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false, // remove every route below
    );
  }

  @override
  Widget build(BuildContext context) {
    final canGoBack = Navigator.of(context).canPop();
    return Scaffold(
      // No "leading" here: the AppBar adds the back arrow only if canPop.
      appBar: AppBar(title: Text('Hi $name')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Routes below this one: ${canGoBack ? 'yes' : 'no'}'),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => _logOut(context),
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
