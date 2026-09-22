// =====================================================================
// Week 5, part 3 - Reaching a Form without a key: Form.of(context)
// =====================================================================
// WHAT YOU LEARN
//   * Example 11 reaches a Form's state with a GlobalKey. There is a second
//     way: Form.of(context), which walks UP the widget tree from `context` and
//     returns the nearest Form's state. It works like Theme.of(context) or
//     MediaQuery.of(context) (week 4): Form is an InheritedWidget-backed
//     widget, and .of() is the standard way Flutter widgets expose themselves
//     to their descendants.
//   * The rule that trips people up: `context` must belong to a widget that is
//     BELOW the Form, in the tree, not the one that BUILT the Form. The
//     `context` of the build method that creates the Form is still ABOVE it:
//     Form.of(context) there fails.
//   * A Builder widget solves this: its own builder function receives a NEW,
//     inner BuildContext, for the point right where the Builder sits - which
//     is below the Form. Wrap the button that needs Form.of in a Builder.
//   * Form.of(context) is non-nullable: if no Form is found, it throws
//     (verified: a FlutterError, "Form.of() was called with a context that
//     does not contain a Form widget"). Form.maybeOf(context) returns null
//     instead of throwing, if you want to handle the "no Form" case yourself.
//   * Which one to use? A GlobalKey is simpler when the button is a direct
//     sibling of the Form, in the same build method (example 11).
//     Form.of(context) is convenient when the button is written far from the
//     Form, for example in a separate widget class that does not receive a key.
//
// HOW TO RUN
//   flutter run -t lib/15_form_of_builder.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A field "Your name" and a button "VALIDATE (Form.of)". Press it with the
//   field empty: a red message appears under the field, and the line below the
//   button says "valid: false". Type a name, press again: no message, and
//   "valid: true".
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormOfPage(),
    );
  }
}

class FormOfPage extends StatefulWidget {
  const FormOfPage({super.key});

  @override
  State<FormOfPage> createState() => _FormOfPageState();
}

class _FormOfPageState extends State<FormOfPage> {
  String _status = '';

  @override
  Widget build(BuildContext topContext) {
    // `topContext` is ABOVE the Form we are about to build: Form.of(topContext)
    // would fail. We reach the Form from a context BELOW it instead.
    return Scaffold(
      appBar: AppBar(title: const Text('Form.of')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Your name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please fill in this field';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // A Builder gives its child a context that is BELOW the Form,
              // so Form.of(subContext) can find it.
              Builder(
                builder: (subContext) {
                  return ElevatedButton(
                    onPressed: () {
                      final valid = Form.of(subContext).validate();
                      setState(() => _status = 'valid: $valid');
                    },
                    child: const Text('VALIDATE (Form.of)'),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(_status, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
