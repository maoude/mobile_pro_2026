// =====================================================================
// Automated checks for the week 6, part 2 examples
// =====================================================================
// Each test starts one example in a test window, types and taps like a user,
// and checks that what appears on screen matches the "EXPECTED RESULT"
// written at the top of that example's file. Some tests check claims made in
// the lecture notes: that ListView.builder does not build the rows that are
// off screen, that a builder without itemCount reads past the end, that
// the printed "validate() ?? false" test logs in with an INVALID form, that
// the printed email pattern accepts "a@bcd", and that Scaffold.of fails with
// the context of the widget that creates the Scaffold.
//
// HOW TO RUN
//   flutter test
//
// EXPECTED RESULT
//   All tests pass:  "All tests passed!"
// =====================================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:week06_examples/00_lap_list_builder.dart' as ex00;
import 'package:week06_examples/01_login_form.dart' as ex01;
import 'package:week06_examples/02_push_vs_replacement.dart' as ex02;
import 'package:week06_examples/03_platform_alert.dart' as ex03;
import 'package:week06_examples/04_dialog_result.dart' as ex04;
import 'package:week06_examples/05_bottom_sheets.dart' as ex05;
import 'package:week06_examples/06_stopwatch_app/main.dart' as ex06;

// Types [text] in the n-th TextField of the screen.
Future<void> typeIn(WidgetTester tester, int n, String text) async {
  await tester.enterText(find.byType(TextField).at(n), text);
  await tester.pump();
}

// The _validate method of the printed text, on a form with one required field.
class _PrintedValidate extends StatefulWidget {
  const _PrintedValidate();

  @override
  State<_PrintedValidate> createState() => _PrintedValidateState();
}

class _PrintedValidateState extends State<_PrintedValidate> {
  final _formKey = GlobalKey<FormState>();
  bool loggedIn = false;

  void _validate() {
    final form = _formKey.currentState;
    if (form?.validate() ?? false) {
      return; // returns when the form is VALID...
    }
    setState(() {
      loggedIn = true; // ...and logs in when it is not
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (text) => text!.isEmpty ? 'Required' : null,
              ),
              ElevatedButton(onPressed: _validate, child: const Text('Go')),
              Text(loggedIn ? 'logged in' : 'not logged in'),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  // ------------------------------------------------------------------ 00
  testWidgets('00 the lap list scrolls to the newest lap', (tester) async {
    await tester.pumpWidget(const ex00.StopWatchApp());
    expect(find.text('Lap 1'), findsOneWidget);
    expect(find.text('0.0 seconds'), findsOneWidget);

    await tester.tap(find.text('Start'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('0.3 seconds'), findsOneWidget);

    for (var i = 0; i < 20; i++) {
      await tester.tap(find.text('Lap').first);
      await tester.pump();
      // 600 ms: the 500 ms scroll animation ends before the next lap.
      await tester.pump(const Duration(milliseconds: 600));
    }
    await tester.tap(find.text('Stop'));
    await tester.pumpAndSettle();

    // The newest lap is visible: the list scrolled by itself.
    expect(find.widgetWithText(ListTile, 'Lap 20'), findsOneWidget);
    // ListView.builder did not build the first rows, which are off screen.
    expect(find.widgetWithText(ListTile, 'Lap 1'), findsNothing);
    expect(find.byType(Scrollbar), findsOneWidget);
  });

  testWidgets('00 claim: ListView.builder without itemCount reads past the end',
      (tester) async {
    final laps = [1, 2, 3];
    await tester.pumpWidget(MaterialApp(
      home: ListView.builder(
        itemBuilder: (_, i) => Text('Lap ${laps[i]}'), // no itemCount
      ),
    ));
    expect(tester.takeException(), isA<RangeError>());
  });

  // ------------------------------------------------------------------ 01
  testWidgets('01 the login form validates, then says hello', (tester) async {
    await tester.pumpWidget(const ex01.LoginApp());
    await tester.tap(find.text('Continue'));
    await tester.pump();
    expect(find.text("Enter the runner's name."), findsOneWidget);
    expect(find.text("Enter the runner's email."), findsOneWidget);

    await typeIn(tester, 0, 'Lina');
    await typeIn(tester, 1, 'lina@mail');
    await tester.tap(find.text('Continue'));
    await tester.pump();
    expect(find.text('Enter a valid email'), findsOneWidget);

    await typeIn(tester, 1, 'lina@mail.com');
    await tester.tap(find.text('Continue'));
    await tester.pump();
    expect(find.text('Hi Lina'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byType(TextFormField), findsNothing);
  });

  testWidgets('01 claim: the printed validate test logs in when INVALID',
      (tester) async {
    await tester.pumpWidget(const _PrintedValidate());
    await tester.tap(find.text('Go')); // the field is empty: invalid
    await tester.pump();
    expect(find.text('Required'), findsOneWidget);
    expect(find.text('logged in'), findsOneWidget);
  });

  test('01 claim: the printed email pattern accepts addresses without a dot',
      () {
    final printed = RegExp('[^@]+@[^.]+..+');
    final ours = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    expect(printed.hasMatch('a@bcd'), isTrue);
    expect(printed.hasMatch('lina @ mail com'), isTrue);
    expect(ours.hasMatch('a@bcd'), isFalse);
    expect(ours.hasMatch('lina @ mail com'), isFalse);
    expect(ours.hasMatch('lina@mail.com'), isTrue);
  });

  // ------------------------------------------------------------------ 02
  testWidgets('02 push keeps the login below, with a back arrow',
      (tester) async {
    await tester.pumpWidget(const ex02.RoutesApp());
    await tester.tap(find.text('Push'));
    await tester.pumpAndSettle();
    expect(find.text('Hi Lina'), findsOneWidget);
    expect(find.text('Routes below this one: yes'), findsOneWidget);
    expect(find.byType(BackButton), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('02 pushReplacement removes the login: no back arrow',
      (tester) async {
    await tester.pumpWidget(const ex02.RoutesApp());
    await typeIn(tester, 0, 'Sami');
    await tester.tap(find.text('Push replacement'));
    await tester.pumpAndSettle();
    expect(find.text('Hi Sami'), findsOneWidget);
    expect(find.text('Routes below this one: no'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);

    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);
  });

  testWidgets('02 log out after push empties the whole stack', (tester) async {
    await tester.pumpWidget(const ex02.RoutesApp());
    await tester.tap(find.text('Push'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);
  });

  // ------------------------------------------------------------------ 03
  Future<void> openAndClose(
    WidgetTester tester,
    String button,
    Type dialogType,
  ) async {
    await tester.tap(find.text(button));
    await tester.pumpAndSettle();
    // AlertDialog.adaptive builds a private subclass of AlertDialog, so we
    // look for "is a dialogType", not "is exactly a dialogType".
    final dialog = find.byWidgetPredicate(
      (w) => dialogType == AlertDialog
          ? w is AlertDialog
          : w.runtimeType == dialogType,
    );
    expect(dialog, findsOneWidget);
    expect(find.text('Run completed!'), findsOneWidget);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    expect(dialog, findsNothing);
  }

  testWidgets('03 the four dialogs, on Android and pretending to be iOS',
      (tester) async {
    await tester.pumpWidget(const ex03.AlertApp());
    await openAndClose(tester, 'Material dialog', AlertDialog);
    await openAndClose(tester, 'Cupertino dialog', CupertinoAlertDialog);
    await openAndClose(tester, 'Platform alert', AlertDialog);
    await openAndClose(tester, 'Adaptive dialog', AlertDialog);
    expect(find.text('Dialogs closed: 4'), findsOneWidget);

    await tester.tap(find.text('Pretend to be iOS'));
    await tester.pumpAndSettle();
    await openAndClose(tester, 'Platform alert', CupertinoAlertDialog);
    await openAndClose(tester, 'Adaptive dialog', CupertinoAlertDialog);
    expect(find.text('Dialogs closed: 6'), findsOneWidget);
  });

  testWidgets('03 claim: a tap outside closes a Material dialog only',
      (tester) async {
    await tester.pumpWidget(const ex03.AlertApp());
    await tester.tap(find.text('Material dialog'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10)); // on the dark barrier
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);

    await tester.tap(find.text('Cupertino dialog'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.byType(CupertinoAlertDialog), findsOneWidget);
  });

  // ------------------------------------------------------------------ 04
  testWidgets('04 a SimpleDialog returns the chosen distance', (tester) async {
    await tester.pumpWidget(const ex04.DialogResultApp());
    expect(find.text('Distance: 400 m'), findsOneWidget);

    await tester.tap(find.text('Choose distance'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('800 m'));
    await tester.pumpAndSettle();
    expect(find.text('Distance: 800 m'), findsOneWidget);

    // A tap outside closes the dialog with null: nothing changes.
    await tester.tap(find.text('Choose distance'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.byType(SimpleDialog), findsNothing);
    expect(find.text('Distance: 800 m'), findsOneWidget);
  });

  testWidgets('04 a confirmation dialog returns true, false or null',
      (tester) async {
    await tester.pumpWidget(const ex04.DialogResultApp());
    expect(find.text('Laps: 3'), findsOneWidget);

    await tester.tap(find.text('Clear laps'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Laps: 3'), findsOneWidget);

    await tester.tap(find.text('Clear laps'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.text('Laps: 3'), findsOneWidget);

    await tester.tap(find.text('Clear laps'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();
    expect(find.text('Laps: 0'), findsOneWidget);
  });

  // ------------------------------------------------------------------ 05
  String firstLap(WidgetTester tester) {
    final tile = tester.widget<ListTile>(find.byType(ListTile).first);
    return (tile.title as Text).data!;
  }

  testWidgets('05 a modal sheet returns the chosen order', (tester) async {
    await tester.pumpWidget(const ex05.BottomSheetApp());
    expect(find.text('Order: in order'), findsOneWidget);
    expect(firstLap(tester), 'Lap 1');

    await tester.tap(find.text('Sort'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fastest first'));
    await tester.pumpAndSettle();
    expect(find.text('Order: fastest first'), findsOneWidget);
    expect(firstLap(tester), 'Lap 4'); // 58.9 s

    // A tap on the dark area closes the sheet without a choice.
    await tester.tap(find.text('Sort'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.text('Slowest first'), findsNothing);
    expect(find.text('Order: fastest first'), findsOneWidget);
  });

  testWidgets('05 a persistent sheet leaves the page usable, then closes',
      (tester) async {
    await tester.pumpWidget(const ex05.BottomSheetApp());
    await tester.tap(find.text('Summary'));
    await tester.pumpAndSettle();
    expect(find.text('Run completed - 5 laps, total 301.5 s'), findsOneWidget);

    // The page still works while the sheet is open.
    await tester.tap(find.text('Sort'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Slowest first'));
    await tester.pumpAndSettle();
    expect(find.text('Order: slowest first'), findsOneWidget);
    expect(find.text('Run completed - 5 laps, total 301.5 s'), findsOneWidget);

    // It closes by itself after 5 seconds.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.textContaining('Run completed'), findsNothing);

    // ...or with its close button.
    await tester.tap(find.text('Summary'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Run completed'), findsNothing);
  });

  testWidgets('05 claim: Scaffold.of fails with the context above the Scaffold',
      (tester) async {
    late BuildContext outer;
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        outer = context; // this context CREATES the Scaffold below
        return const Scaffold(body: Text('page'));
      }),
    ));
    expect(() => Scaffold.of(outer), throwsFlutterError);
    expect(Scaffold.maybeOf(outer), isNull);
  });

  // ------------------------------------------------------------------ 06
  testWidgets('06 the complete Stopwatch app', (tester) async {
    await tester.pumpWidget(const ex06.StopWatchApp());

    // 1. Login, then the stopwatch replaces it.
    await tester.tap(find.text('Continue'));
    await tester.pump();
    expect(find.text("Enter the runner's name."), findsOneWidget);
    await typeIn(tester, 0, 'Lina');
    await typeIn(tester, 1, 'lina@mail.com');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Lina'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);

    // 2. Two laps of 1.2 s and 0.8 s, then 0.5 s more.
    await tester.tap(find.text('Start'));
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.tap(find.text('Lap').first);
    await tester.pump(const Duration(milliseconds: 800));
    await tester.tap(find.text('Lap').first);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Lap 3'), findsOneWidget); // the counter panel

    // 3. Stop: the dialog gives the total, 2.5 seconds.
    await tester.tap(find.text('Stop'));
    await tester.pumpAndSettle();
    expect(find.text('Run completed!'), findsOneWidget);
    expect(find.text('Total run time is 2.5 seconds.'), findsOneWidget);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    // 4. A lap opens a bottom sheet.
    await tester.tap(find.widgetWithText(ListTile, 'Lap 1'));
    await tester.pumpAndSettle();
    expect(
        find.text('0.4 seconds slower than the fastest lap'), findsOneWidget);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Lap 2'));
    await tester.pumpAndSettle();
    expect(find.text('Fastest lap'), findsOneWidget);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    // 5. Log out: Cancel keeps the stopwatch, Log out returns to the login.
    await tester.tap(find.byTooltip('Log out'));
    await tester.pumpAndSettle();
    expect(find.text('Log out?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Lina'), findsOneWidget);

    await tester.tap(find.byTooltip('Log out'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Log out'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Login'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);
    expect(find.text('Lina'), findsNothing); // a fresh, empty form
  });
}
