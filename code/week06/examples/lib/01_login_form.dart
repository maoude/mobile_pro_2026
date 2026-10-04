// =====================================================================
// Week 6, part 2 - A login form on one screen
// =====================================================================
// WHAT YOU LEARN
//   * The same tools as week 5, part 3, put together for a real screen: a
//     Form with a GlobalKey<FormState>, two TextFormFields with their own
//     TextEditingControllers, a validator for each field, and a button that
//     calls validate().
//   * One screen, two faces: a bool in the State (_loggedIn) chooses which
//     widget tree build returns:
//         child: _loggedIn ? _buildSuccess() : _buildLoginForm()
//     setState flips the bool and the whole body changes. (The next examples
//     use real navigation to another screen instead.)
//   * keyboardType: TextInputType.emailAddress shows the keyboard with "@".
//   * The email check uses a RegExp, anchored with ^ and $ so that the WHOLE
//     text must match:  something @ something . something, without spaces.
//   * Watch the direction of the test in _validate: validate() returns TRUE
//     when every field is valid, so we stop when it is FALSE:
//         if (!_formKey.currentState!.validate()) return;
//     The printed text writes "if (form?.validate() ?? false) return;", which
//     stops when the form is VALID and logs in when it is NOT: the test in
//     ../test/widget_test.dart shows it.
//
// HOW TO RUN
//   flutter run -t lib/01_login_form.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   An app bar "Login", two fields "Runner" and "Email", and a CONTINUE button.
//     * Press CONTINUE with empty fields: "Enter the runner's name." and
//       "Enter the runner's email." appear in red under the fields.
//     * Type "Lina" and "lina@mail": "Enter a valid email" (no dot after @).
//     * Type "lina@mail.com" and press CONTINUE: the form is replaced by an
//       orange check mark and "Hi Lina".
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const LoginApp());

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

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
  bool _loggedIn = false;
  String _name = '';

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: _loggedIn ? _buildSuccess() : _buildLoginForm(),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check, color: Colors.orangeAccent, size: 48),
        Text('Hi $_name'),
      ],
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
      return; // at least one field is wrong: its error is already shown
    }
    setState(() {
      _loggedIn = true;
      _name = _nameController.text.trim();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
