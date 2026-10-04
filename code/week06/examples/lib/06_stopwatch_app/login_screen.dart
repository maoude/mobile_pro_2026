// The login screen: the form of example 01. When the form is valid, the
// stopwatch REPLACES this screen (pushReplacement, example 02), so the Back
// button cannot return to the login.

import 'package:flutter/material.dart';

import 'stopwatch.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(child: _buildLoginForm()),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Runner'),
              validator: _validateName,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: _validateEmail,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validate,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateName(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "Enter the runner's name.";
    }
    return null;
  }

  String? _validateEmail(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "Enter the runner's email.";
    }
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(text.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  void _validate() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => StopWatch(name: name, email: email)),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
