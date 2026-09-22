// =====================================================================
// Automated checks for the week 5 Flutter examples
// =====================================================================
// Each test starts one step of the lecture in a test window, types in the
// text fields and taps the buttons like a user, and checks that what appears
// on screen matches the "EXPECTED RESULT" written at the top of that
// example's file. Some tests check claims made in the lecture notes: for
// example that changing a variable without setState does not change the
// screen, and that double.parse stops on a text that is not a number.
//
// HOW TO RUN
//   flutter test
//
// EXPECTED RESULT
//   All tests pass:  "All tests passed!"
// =====================================================================

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:week05_flutter_examples/00_stateful_counter.dart' as ex00;
import 'package:week05_flutter_examples/01_setstate_needed.dart' as ex01;
import 'package:week05_flutter_examples/02_textfield_events.dart' as ex02;
import 'package:week05_flutter_examples/03_you_typed.dart' as ex03;
import 'package:week05_flutter_examples/04_custom_textfield.dart' as ex04;
import 'package:week05_flutter_examples/05_sum_app/main.dart' as ex05;
import 'package:week05_flutter_examples/05_sum_app/my_text_field.dart'
    as ex05field;
import 'package:week05_flutter_examples/06_text_controller.dart' as ex06;
import 'package:week05_flutter_examples/07_button_styles.dart' as ex07;
import 'package:week05_flutter_examples/08_safe_number_input.dart' as ex08;
import 'package:week05_flutter_examples/09_lifecycle_log.dart' as ex09;
import 'package:week05_flutter_examples/10_stopwatch_timer.dart' as ex10;
import 'package:week05_flutter_examples/11_stopwatch_buttons.dart' as ex11;
import 'package:week05_flutter_examples/12_stopwatch_laps.dart' as ex12;
import 'package:week05_flutter_examples/13_scrolling.dart' as ex13;
import 'package:week05_flutter_examples/main.dart' as app;

// Types [text] in the n-th TextField of the screen.
Future<void> typeIn(WidgetTester tester, int n, String text) async {
  await tester.enterText(find.byType(TextField).at(n), text);
  await tester.pump();
}

// A widget with the mistake described in the notes: a "late" Timer that is
// only assigned when a button is pressed, but cancelled in dispose.
class _LateTimerDemo extends StatefulWidget {
  const _LateTimerDemo();

  @override
  State<_LateTimerDemo> createState() => _LateTimerDemoState();
}

class _LateTimerDemoState extends State<_LateTimerDemo> {
  late Timer timer; // never assigned: Start is never pressed

  @override
  Widget build(BuildContext context) => const SizedBox();

  @override
  void dispose() {
    timer.cancel(); // LateInitializationError
    super.dispose();
  }
}
void main() {
  testWidgets('00 a stateful widget redraws when setState is called', (
    tester,
  ) async {
    await tester.pumpWidget(const ex00.MyApp());
    expect(find.text('Counter'), findsOneWidget);
    expect(find.text('Count: 0'), findsOneWidget);

    await tester.tap(find.text('Add 1'));
    await tester.pump();
    await tester.tap(find.text('Add 1'));
    await tester.pump();
    expect(find.text('Count: 2'), findsOneWidget);
    expect(find.text('Count: 0'), findsNothing);
  });

  testWidgets('01 changing a variable WITHOUT setState changes nothing', (
    tester,
  ) async {
    await tester.pumpWidget(const ex01.MyApp());
    expect(find.text('Value: 0'), findsOneWidget);

    // Three additions without setState: the screen still shows 0.
    for (var i = 0; i < 3; i++) {
      await tester.tap(find.text('Add 1 (without setState)'));
      await tester.pump();
    }
    expect(find.text('Value: 0'), findsOneWidget);

    // One setState: build runs again, and the screen shows all four additions.
    await tester.tap(find.text('Add 1 (with setState)'));
    await tester.pump();
    expect(find.text('Value: 4'), findsOneWidget);
  });

  testWidgets('02 onChanged follows every letter, onSubmitted comes once', (
    tester,
  ) async {
    await tester.pumpWidget(const ex02.MyApp());
    expect(find.text('Changed: '), findsOneWidget);
    expect(find.text('Submitted: '), findsOneWidget);

    // The fields of the TextField named in the notes.
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.decoration!.border, isA<OutlineInputBorder>());
    expect(field.decoration!.hintText, 'Type your name');
    expect(field.style!.fontSize, 18);

    await typeIn(tester, 0, 'Ra');
    expect(find.text('Changed: Ra'), findsOneWidget);
    await typeIn(tester, 0, 'Rami');
    expect(find.text('Changed: Rami'), findsOneWidget);
    expect(find.text('Submitted: '), findsOneWidget); // not finished yet

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(find.text('Submitted: Rami'), findsOneWidget);
  });

  testWidgets('03 the text of the TextField is shown in the Text', (
    tester,
  ) async {
    await tester.pumpWidget(const ex03.MyApp());
    expect(find.text('Home Page'), findsOneWidget);
    expect(find.text('You typed: '), findsOneWidget);
    expect(find.text('Enter some text'), findsOneWidget); // the hint

    await typeIn(tester, 0, 'Hello students');
    expect(find.text('You typed: Hello students'), findsOneWidget);

    // The SizedBox gives the TextField a width and a height.
    final box = find.ancestor(
      of: find.byType(TextField),
      matching: find.byType(SizedBox),
    );
    expect(tester.getSize(box.first), const Size(300, 50));
  });

  testWidgets('04 MyTextField: the callback is called with the new text', (
    tester,
  ) async {
    await tester.pumpWidget(const ex04.MyApp());
    expect(find.byType(ex04.MyTextField), findsOneWidget);
    await typeIn(tester, 0, 'callback');
    expect(find.text('You typed: callback'), findsOneWidget);

    // The point of a custom widget: reuse it, each with its own callback.
    final received = <String>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              ex04.MyTextField(
                  hint: 'A', onChanged: (t) => received.add('A$t')),
              ex04.MyTextField(
                  hint: 'B', onChanged: (t) => received.add('B$t')),
            ],
          ),
        ),
      ),
    );
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    await typeIn(tester, 0, '1');
    await typeIn(tester, 1, '2');
    expect(received, ['A1', 'B2']);
  });

  testWidgets('05 sum app (three files): X + Y, shown when SUM is pressed', (
    tester,
  ) async {
    await tester.pumpWidget(const ex05.MyApp());
    expect(find.text('Home Page'), findsOneWidget);
    expect(find.text('Sum: '), findsOneWidget);
    expect(find.text('Enter X'), findsOneWidget);
    expect(find.text('Enter Y'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Typing alone does not change the sum: updateX has no setState.
    await typeIn(tester, 0, '2.5');
    await typeIn(tester, 1, '4');
    expect(find.text('Sum: '), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Sum: 6.5'), findsOneWidget);

    // A negative number works (the slides' -1 marker would forbid -1).
    await typeIn(tester, 0, '-1');
    await typeIn(tester, 1, '-1');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Sum: -2.0'), findsOneWidget);

    // Not a number, or empty: a message, and no crash.
    await typeIn(tester, 0, 'abc');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Sum: Please fill all fields'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await typeIn(tester, 0, '');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Sum: Please fill all fields'), findsOneWidget);

    // The fields ask a phone for a numeric keyboard.
    final field = tester.widget<TextField>(find.byType(TextField).first);
    expect(field.keyboardType, ex05field.numberKeyboard);
  });

  testWidgets('05 the same app starts from lib/main.dart', (tester) async {
    // main.dart only calls main of the sum app (`flutter run` starts it).
    app.main();
    await tester.pump();
    expect(find.byType(ex05field.MyTextField), findsNWidgets(2));
    expect(find.text('Sum: '), findsOneWidget);
  });

  testWidgets('06 TextEditingController: read, change and clear the text', (
    tester,
  ) async {
    await tester.pumpWidget(const ex06.MyApp());
    // The controller gave the field its first text.
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Characters: 7'), findsOneWidget);

    await typeIn(tester, 0, 'Flutter rocks');
    expect(find.text('Characters: 13'), findsOneWidget);

    await tester.tap(find.text('UPPERCASE'));
    await tester.pump();
    expect(find.text('FLUTTER ROCKS'), findsOneWidget);

    // The program changes the text: onChanged is not called, so the button
    // calls setState itself. The count is refreshed and the field is empty.
    await tester.tap(find.text('CLEAR'));
    await tester.pump();
    expect(find.text('Characters: 0'), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).controller!.text,
        isEmpty);
  });

  testWidgets('07 ElevatedButton: shapes, disabled button, switch', (
    tester,
  ) async {
    await tester.pumpWidget(const ex07.MyApp());
    expect(find.text('Last pressed: none'), findsOneWidget);

    ElevatedButton button(String label) => tester.widget<ElevatedButton>(
          find.ancestor(
            of: find.text(label),
            matching: find.byType(ElevatedButton),
          ),
        );
    OutlinedBorder? shapeOf(ElevatedButton b) =>
        b.style!.shape!.resolve({});

    // The round buttons of the exercise.
    expect(shapeOf(button('PILL')), isA<StadiumBorder>());
    expect(shapeOf(button('ROUNDED')), isA<RoundedRectangleBorder>());
    final heart = tester.widget<ElevatedButton>(
      find.ancestor(
        of: find.byIcon(Icons.favorite),
        matching: find.byType(ElevatedButton),
      ),
    );
    expect(shapeOf(heart), isA<CircleBorder>());
    expect(button('PILL').style!.backgroundColor!.resolve({}),
        Colors.deepPurple);

    // An enabled button changes the first line.
    await tester.tap(find.text('PILL'));
    await tester.pump();
    expect(find.text('Last pressed: PILL'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(find.text('Last pressed: HEART'), findsOneWidget);

    // onPressed: null disables a button; it does not react.
    expect(button('DISABLED').onPressed, isNull);
    await tester.tap(find.text('DISABLED'), warnIfMissed: false);
    await tester.pump();
    expect(find.text('Last pressed: HEART'), findsOneWidget);

    // The switch enables it.
    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(button('DISABLED').onPressed, isNotNull);
    await tester.tap(find.text('DISABLED'));
    await tester.pump();
    expect(find.text('Last pressed: DISABLED'), findsOneWidget);
  });

  testWidgets('08 safe input: errorText and a disabled SUM button', (
    tester,
  ) async {
    // The claim of the notes, about Dart itself.
    expect(() => double.parse('abc'), throwsFormatException);
    expect(double.tryParse('abc'), isNull);
    expect(double.tryParse('-4'), -4.0);

    await tester.pumpWidget(const ex08.MyApp());
    ElevatedButton button() =>
        tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button().onPressed, isNull); // nothing typed yet
    expect(find.text('Not a number'), findsNothing);

    await typeIn(tester, 0, 'abc');
    expect(find.text('Not a number'), findsOneWidget);
    expect(button().onPressed, isNull);

    await typeIn(tester, 0, '2.5');
    expect(find.text('Not a number'), findsNothing);
    expect(button().onPressed, isNull); // Y is still empty

    await typeIn(tester, 1, '-4');
    expect(button().onPressed, isNotNull); // both fields are numbers
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Sum: -1.5'), findsOneWidget);
  });

  // ------------------------------------------------------------------
  // The life cycle, the stopwatch (10 to 12), and scrolling (13)
  // ------------------------------------------------------------------

  testWidgets('09 life cycle methods are called in a fixed order', (
    tester,
  ) async {
    // The log is notified after the frame: pump twice.
    Future<void> settle() async {
      await tester.pump();
      await tester.pump();
    }

    // The lines of the log, read from the model that the page shows.
    List<String> logged() {
      final log = tester
          .widget<ListenableBuilder>(find.byWidgetPredicate(
              (w) => w is ListenableBuilder && w.listenable is ex09.LogModel))
          .listenable as ex09.LogModel;
      return List.of(log.lines);
    }

    await tester.pumpWidget(const ex09.MyApp());
    await settle();
    // At the start: initState, didChangeDependencies, build.
    expect(logged(), ['initState', 'didChangeDependencies', 'build']);
    expect(find.text('Child: A'), findsOneWidget);
    // On the screen: numbered, the newest line at the top.
    expect(find.text('1. initState'), findsOneWidget);
    expect(find.text('3. build'), findsOneWidget);

    // New parameters from the parent: didUpdateWidget, then build.
    await tester.tap(find.text('Change label'));
    await settle();
    expect(find.text('Child: B'), findsOneWidget);
    expect(logged().sublist(3), ['didUpdateWidget: A -> B', 'build']);
    expect(find.text('4. didUpdateWidget: A -> B'), findsOneWidget);

    // A hot reload calls reassemble (only during development).
    // (Not awaited: it completes when a frame is drawn, and we draw it below.)
    tester.binding.reassembleApplication();
    await settle();
    expect(logged(), contains('reassemble'));

    // Removing the child: deactivate, then dispose.
    final before = logged().length;
    await tester.tap(find.text('Hide child'));
    await settle();
    expect(find.text('Child: B'), findsNothing);
    expect(logged().sublist(before), ['deactivate', 'dispose']);

    // Showing it again creates a NEW State: it starts with initState.
    final again = logged().length;
    await tester.tap(find.text('Show child'));
    await settle();
    expect(logged().sublist(again).first, 'initState');
    expect(find.text('Child: B'), findsOneWidget);
  });

  group('10 to 12 the stopwatch', () {
    testWidgets('10 a Timer changes the state once a second', (tester) async {
      await tester.pumpWidget(const ex10.StopWatchApp());
      expect(find.text('0 seconds'), findsOneWidget);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('1 second'), findsOneWidget); // singular
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('3 seconds'), findsOneWidget);

      // dispose cancels the Timer: after the screen is closed nothing ticks.
      // (The test also fails by itself if a Timer is still pending at its end.)
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 5));
      expect(tester.takeException(), isNull);
    });

    testWidgets('11 Start and Stop: a button with onPressed null is disabled', (
      tester,
    ) async {
      await tester.pumpWidget(const ex11.StopWatchApp());
      ElevatedButton start() =>
          tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      TextButton stop() => tester.widget<TextButton>(find.byType(TextButton));

      // At the start: Start is active, Stop is disabled.
      expect(start().onPressed, isNotNull);
      expect(stop().onPressed, isNull);
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('0 seconds'), findsOneWidget); // nothing ticks yet

      await tester.tap(find.text('Start'));
      await tester.pump();
      expect(start().onPressed, isNull); // Start is now disabled
      expect(stop().onPressed, isNotNull);
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('3 seconds'), findsOneWidget);

      await tester.tap(find.text('Stop'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 5));
      expect(find.text('3 seconds'), findsOneWidget); // stopped
      expect(start().onPressed, isNotNull);
      expect(stop().onPressed, isNull);

      // Start again: the count starts again from 0.
      await tester.tap(find.text('Start'));
      await tester.pump();
      expect(find.text('0 seconds'), findsOneWidget);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('1 second'), findsOneWidget);

      // Closing the screen while it ticks: dispose cancels the Timer.
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 5));
      expect(tester.takeException(), isNull);
    });

    testWidgets('11 the Timer is nullable: dispose without Start is safe', (
      tester,
    ) async {
      await tester.pumpWidget(const ex11.StopWatchApp());
      await tester.pumpWidget(const SizedBox()); // Start was never pressed
      expect(tester.takeException(), isNull);
    });

    testWidgets('a late Timer that was never assigned fails in dispose', (
      tester,
    ) async {
      // The claim of the notes: with "late Timer timer" and no Start pressed,
      // timer.cancel() in dispose stops the app.
      await tester.pumpWidget(const _LateTimerDemo());
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException().toString(),
          contains('has not been initialized'));
    });

    testWidgets('12 laps: a list in an Expanded that scrolls', (tester) async {
      await tester.pumpWidget(const ex12.StopWatchApp());
      ElevatedButton lap() => tester.widget<ElevatedButton>(
            find.ancestor(
              of: find.text('Lap'),
              matching: find.byType(ElevatedButton),
            ),
          );
      expect(find.text('Lap 1'), findsOneWidget);
      expect(find.text('0.0 seconds'), findsOneWidget);
      expect(lap().onPressed, isNull); // stopped: no lap

      // The counter and the list share the screen equally.
      const bodyHeight = 600 - kToolbarHeight;
      expect(tester.getSize(find.byType(ListView)).height, bodyHeight / 2);

      await tester.tap(find.text('Start'));
      await tester.pump();
      expect(lap().onPressed, isNotNull);
      await tester.pump(const Duration(milliseconds: 300)); // 3 ticks
      expect(find.text('0.3 seconds'), findsOneWidget);

      // A lap: it goes to the list, and the counter starts again from 0.
      await tester.tap(find.text('Lap'));
      await tester.pump();
      expect(find.text('Lap 2'), findsOneWidget); // the panel: the next lap
      expect(find.text('0.0 seconds'), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text('0.3 seconds'), findsOneWidget); // the row of lap 1

      // Many laps: the list scrolls (a Column would overflow).
      for (var i = 0; i < 12; i++) {
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.text('Lap'));
        await tester.pump();
      }
      // 13 laps are finished: the panel is on the 14th, and the list scrolls.
      expect(find.text('Lap 14'), findsOneWidget);
      expect(find.text('Lap 13'), findsNothing); // not built: off the screen
      await tester.scrollUntilVisible(find.text('Lap 13'), 100,
          scrollable: find.byType(Scrollable));
      expect(find.text('Lap 13'), findsOneWidget);
      expect(tester.takeException(), isNull);

      // Stop, then Start: the laps are cleared.
      await tester.tap(find.text('Stop'));
      await tester.pump();
      await tester.tap(find.text('Start'));
      await tester.pump();
      expect(find.byType(ListTile), findsNothing);
      expect(find.text('Lap 1'), findsOneWidget);

      await tester.pumpWidget(const SizedBox()); // dispose cancels the Timer
    });
  });

  group('13 scrolling', () {
    testWidgets('ListView.builder builds only the visible rows', (
      tester,
    ) async {
      await tester.pumpWidget(const ex13.MyApp());
      expect(find.text('Item 0'), findsOneWidget);
      // 1000 items, but only the ones on the screen (and a few more) exist.
      expect(find.byType(ListTile).evaluate().length, lessThan(30));
    });

    testWidgets('scroll physics can be chosen, Never stops scrolling', (
      tester,
    ) async {
      Future<void> choose(String name) async {
        await tester.tap(find.byType(DropdownButton<String>));
        await tester.pumpAndSettle();
        await tester.tap(find.text(name).last);
        await tester.pumpAndSettle();
      }

      ScrollPhysics? physics() =>
          tester.widget<ListView>(find.byType(ListView)).physics;

      await tester.pumpWidget(const ex13.MyApp());
      // The default: no physics chosen. (A ListView adds AlwaysScrollable to
      // it, and the platform then decides how the ends of the list feel.)
      expect(physics(), isA<AlwaysScrollableScrollPhysics>());

      // By default a drag scrolls the list.
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();
      expect(find.text('Item 0'), findsNothing);
      await tester.drag(find.byType(ListView), const Offset(0, 300));
      await tester.pumpAndSettle();
      expect(find.text('Item 0'), findsOneWidget);

      await choose('Bouncing');
      expect(physics(), isA<BouncingScrollPhysics>());
      await choose('Clamping');
      expect(physics(), isA<ClampingScrollPhysics>());

      // Never: the finger no longer scrolls the list.
      await choose('Never');
      expect(physics(), isA<NeverScrollableScrollPhysics>());
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();
      expect(find.text('Item 0'), findsOneWidget);
    });

    testWidgets('a ListView in a Column needs Expanded', (tester) async {
      // The claim of the notes: without Expanded, a ListView in a Column fails.
      final errors = <FlutterErrorDetails>[];
      final original = FlutterError.onError;
      FlutterError.onError = errors.add;
      try {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(children: [ListView(children: const [Text('a')])]),
            ),
          ),
        );
      } finally {
        FlutterError.onError = original;
      }
      expect(errors, isNotEmpty);
      expect(errors.first.exceptionAsString(), contains('unbounded height'));
    });
  });
}
