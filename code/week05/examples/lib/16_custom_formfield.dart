// =====================================================================
// Week 5, part 3 - Creating your own FormField: a verification code input
// =====================================================================
// WHAT YOU LEARN
//   * TextFormField is not magic: it is a FormField<String> that happens to
//     wrap a TextField. You can build your OWN FormField<T> around any input
//     widget, and it gets validate(), reset() and save() for free, exactly
//     like a built-in one.
//   * The plan has two parts, and the visible widget knows nothing about Form:
//       1. VerificationCodeInput: a plain, reusable input widget (no Form
//          knowledge). It wraps a TextField with the formatters of example 13
//          (digits only, 6 characters): the same widget you could use outside
//          any form.
//       2. VerificationCodeFormField: a FormField<String> that BUILDS a
//          VerificationCodeInput and wires it to the Form machinery.
//   * A FormField<T> is created with a `builder` function, which receives a
//     FormFieldState<T> and returns the widget to show. The state has
//     field.value, field.errorText and field.didChange(newValue): calling
//     didChange tells the Form "the value changed", which is what makes
//     validate() see the current text.
//   * To add a PERSISTENT controller to the field (so it survives rebuilds and
//     can be cleared by reset()), your FormField subclass overrides
//     createState() to return your OWN State class, which must extend
//     FormFieldState<T> (not the plain State<T> of an ordinary widget). That
//     state:
//       - creates the controller in initState and adds a listener to it;
//       - the listener calls didChange(controller.text), so the Form always
//         has the controller's latest text;
//       - overrides reset() to also clear the controller's text;
//       - overrides dispose() to remove the listener and dispose the
//         controller (as always, week 5, part 1).
//   * This is the pattern used by every "custom form field" package you will
//     find for Flutter: a plain input widget, plus a thin FormField subclass
//     around it.
//
// HOW TO RUN
//   flutter run -t lib/16_custom_formfield.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The text "Enter the 6-digit code we sent you", a boxed 6-character field,
//   and a SUBMIT button.
//     * Press SUBMIT with the field empty: a red "Enter the 6-digit code"
//       appears under the field.
//     * Type "123": press SUBMIT: a red "The code must have 6 digits"
//       appears (the validator; the formatter already keeps only digits, at
//       most 6).
//     * Type "123456", press SUBMIT: the message "Code accepted: 123456"
//       appears below the button, and the field is cleared (a RESET call).
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomFormFieldPage(),
    );
  }
}

// ------------------------------------------------------------------
// Part 1: a plain input widget. It knows nothing about Form.
// ------------------------------------------------------------------
class VerificationCodeInput extends StatelessWidget {
  const VerificationCodeInput({
    super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ],
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: '••••••',
          errorText: errorText,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

// ------------------------------------------------------------------
// Part 2: a FormField<String> that builds a VerificationCodeInput and
// wires it to the Form machinery, with its own persistent controller.
// ------------------------------------------------------------------
class VerificationCodeFormField extends FormField<String> {
  VerificationCodeFormField({
    super.key,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
  }) : super(
          initialValue: '',
          builder: (field) {
            // At runtime `field` IS a _VerificationCodeFormFieldState,
            // because createState() below returns one.
            final state = field as _VerificationCodeFormFieldState;
            return VerificationCodeInput(
              controller: state._controller,
              errorText: field.errorText,
              onChanged: field.didChange,
            );
          },
        );

  @override
  FormFieldState<String> createState() => _VerificationCodeFormFieldState();
}

class _VerificationCodeFormFieldState extends FormFieldState<String> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleControllerChanged);
  }

  void _handleControllerChanged() {
    // Keep the Form's value in sync with what the user actually typed.
    if (_controller.text != value) {
      didChange(_controller.text);
    }
  }

  @override
  void reset() {
    super.reset(); // resets the Form's value to initialValue ('')
    _controller.text = '';
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    _controller.dispose();
    super.dispose();
  }
}

// ------------------------------------------------------------------
// Using the custom field in a page, exactly like a TextFormField.
// ------------------------------------------------------------------
class CustomFormFieldPage extends StatefulWidget {
  const CustomFormFieldPage({super.key});

  @override
  State<CustomFormFieldPage> createState() => _CustomFormFieldPageState();
}

class _CustomFormFieldPageState extends State<CustomFormFieldPage> {
  final _formKey = GlobalKey<FormState>();
  String _accepted = '';

  String? _validateCode(String? value) {
    if (value == null || value.isEmpty) return 'Enter the 6-digit code';
    if (value.length != 6) return 'The code must have 6 digits';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom FormField')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Enter the 6-digit code we sent you'),
              ),
              VerificationCodeFormField(
                validator: _validateCode,
                // save() (below) calls this with the field's current value.
                onSaved: (value) {
                  setState(() => _accepted = 'Code accepted: $value');
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // FormState has no way to read a field's value directly:
                  // validate(), then save() to collect it through onSaved.
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _formKey.currentState!.reset();
                  }
                },
                child: const Text('SUBMIT'),
              ),
              const SizedBox(height: 16),
              Text(_accepted),
            ],
          ),
        ),
      ),
    );
  }
}
