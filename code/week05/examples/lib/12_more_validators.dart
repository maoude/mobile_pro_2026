// =====================================================================
// Week 5, part 3 - Going further: several validators, and autovalidateMode
// =====================================================================
// WHAT YOU LEARN
//   * A validator can check more than "is it empty?". It is a normal Dart
//     function: any logic is allowed, as long as it returns a String (the
//     error) or null (no error).
//   * You can CHAIN small validator functions instead of writing one big one:
//       String? _combine(List<String? Function(String?)> validators, String? v) {
//         for (final validator in validators) {
//           final error = validator(v);
//           if (error != null) return error; // stop at the first error
//         }
//         return null;
//       }
//     Each field then lists which checks it needs, in order.
//   * A validator can also depend on ANOTHER field, for a "confirm password"
//     style check: read the other controller's .text inside the function.
//   * autovalidateMode controls WHEN a field checks itself:
//       AutovalidateMode.disabled            only when .validate() is called
//                                             (the default; example 11 uses it)
//       AutovalidateMode.onUserInteraction    after the user first touches the
//                                             field, then on every change
//       AutovalidateMode.always               from the very first frame
//     onUserInteraction gives feedback as the user types, without shaming an
//     empty field before they have even started.
//   * RegExp is Dart's regular expression class; .hasMatch(text) tests it.
//
// HOW TO RUN
//   flutter run -t lib/12_more_validators.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   Two fields, "Email" and "Password", and "Confirm password", with a
//   CHECK button. Type in "Email" and leave it, without pressing CHECK: as
//   soon as you touch a field its errors appear live (autovalidateMode).
//     * "Email": empty -> "Please fill in this field"; "abc" -> "Not a valid
//       email address"; "a@b.com" -> no error.
//     * "Password": fewer than 6 characters -> "At least 6 characters".
//     * "Confirm password": a different text than "Password" -> "Passwords
//       do not match".
//   With all three fields valid, press CHECK: "All fields are valid!" appears.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoreValidatorsPage(),
    );
  }
}

// Small, reusable validators: each checks one thing.
String? _required(String? value) {
  if (value == null || value.trim().isEmpty) return 'Please fill in this field';
  return null;
}

String? _validEmail(String? value) {
  final pattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (value != null && !pattern.hasMatch(value)) {
    return 'Not a valid email address';
  }
  return null;
}

String? Function(String?) _minLength(int length) {
  // Returns a validator function: this is a function that BUILDS a function.
  return (value) {
    if (value != null && value.length < length) {
      return 'At least $length characters';
    }
    return null;
  };
}

// Runs several validators in order and stops at the first error.
String? _combine(List<String? Function(String?)> validators, String? value) {
  for (final validator in validators) {
    final error = validator(value);
    if (error != null) return error;
  }
  return null;
}

class MoreValidatorsPage extends StatefulWidget {
  const MoreValidatorsPage({super.key});

  @override
  State<MoreValidatorsPage> createState() => _MoreValidatorsPageState();
}

class _MoreValidatorsPageState extends State<MoreValidatorsPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  String _message = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String? _confirmValidator(String? value) {
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More validators')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          // Show each field's errors as soon as the user touches it.
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _combine([_required, _validEmail], v),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _combine([_required, _minLength(6)], v),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _combine([_required, _confirmValidator], v),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _message = _formKey.currentState!.validate()
                        ? 'All fields are valid!'
                        : '';
                  });
                },
                child: const Text('CHECK'),
              ),
              const SizedBox(height: 20),
              Text(_message, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
