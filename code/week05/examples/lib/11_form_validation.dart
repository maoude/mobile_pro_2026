// =====================================================================
// Week 5, part 3 - Validating a form: Form, GlobalKey<FormState>,
// TextFormField and validator
// =====================================================================
// WHAT YOU LEARN
//   * A TextField only lets the user type. A TextFormField does the same, but
//     also plugs into a Form: it can be VALIDATED, and it shows its own error
//     message under the field.
//   * validator is a function that receives the current text and returns:
//       null            the text is fine, no error is shown
//       a String        that String is shown in red under the field
//     Its signature is String? Function(String?) - BOTH the parameter and the
//     return type are nullable. Declaring the parameter as a plain String
//     (not String?), as some older tutorials do, no longer compiles: verified,
//     it is a real type error ("String? Function(String) can't be assigned to
//     ... FormFieldValidator<String>?").
//   * Several TextFormFields are grouped in a Form widget. The Form itself
//     draws nothing; it coordinates its fields. We give it a GlobalKey, a
//     special key that lets code OUTSIDE the widget tree (here, the Submit
//     button) reach the Form's state:
//       final _formKey = GlobalKey<FormState>();
//       Form(key: _formKey, child: ...)
//   * Pressing Submit calls _formKey.currentState!.validate(). This runs
//     EVERY field's validator, shows the errors, and returns true only if
//     they ALL returned null. currentState is nullable (the Form might not be
//     built yet), so the ! is required - forgetting it is also a real
//     compile error, not just a lint.
//   * The two fields use a TextEditingController (week 5, part 1) so that the
//     Reset button can clear their text directly, without rebuilding them.
//
// HOW TO RUN
//   flutter run -t lib/11_form_validation.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   Two fields, "Your name" and "Your age", a city dropdown, and two buttons,
//   SUBMIT and RESET.
//     * Press SUBMIT with both fields empty: a red message appears under each
//       one, and nothing else happens.
//     * Type "Lina" and "20", pick "Delhi", press SUBMIT: the message
//       "Name: Lina, age: 20, city: Delhi" appears below the buttons.
//     * Press RESET: both fields and the message are cleared, and the city
//       goes back to "Calcutta".
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormValidationPage(),
    );
  }
}

class FormValidationPage extends StatefulWidget {
  const FormValidationPage({super.key});

  @override
  State<FormValidationPage> createState() => _FormValidationPageState();
}

class _FormValidationPageState extends State<FormValidationPage> {
  // Identifies this Form, so code outside it (the Submit button) can reach
  // its FormState: currentState.validate(), .save(), .reset().
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  final List<String> _cities = ['Calcutta', 'Delhi', 'Mumbai', 'Chennai'];
  late String _selectedCity;
  String _result = '';

  @override
  void initState() {
    super.initState();
    _selectedCity = _cities[0];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please fill in this field';
    }
    return null; // null means: no error
  }

  void _submit() {
    // validate() runs every field's validator and shows the error messages.
    // It returns true only if EVERY field returned null.
    if (_formKey.currentState!.validate()) {
      setState(() {
        _result = 'Name: ${_nameController.text}, '
            'age: ${_ageController.text}, '
            'city: $_selectedCity';
      });
    }
  }

  void _reset() {
    _formKey.currentState!.reset(); // clears the validation errors
    _nameController.clear();
    _ageController.clear();
    setState(() {
      _selectedCity = _cities[0];
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form validation')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Your name',
                  border: OutlineInputBorder(),
                ),
                validator: _requiredValidator,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Your age',
                  border: OutlineInputBorder(),
                ),
                validator: _requiredValidator,
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: _selectedCity,
                items: _cities.map((city) {
                  return DropdownMenuItem(value: city, child: Text(city));
                }).toList(),
                onChanged: (city) {
                  setState(() {
                    if (city != null) _selectedCity = city;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('SUBMIT'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: _reset,
                    child: const Text('RESET'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(_result, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
