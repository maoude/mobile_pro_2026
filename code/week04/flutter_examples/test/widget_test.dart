// =====================================================================
// Automated checks for the week 4 Flutter examples
// =====================================================================
// Each test starts one step of the lecture in a test window and checks that
// what appears on screen matches the "EXPECTED RESULT" written at the top of
// that example's file. Some tests check claims made in the slides: for
// example that MaterialApp alone gives the warning style to the text, and
// that a Scaffold removes it.
//
// HOW TO RUN
//   flutter test
//
// EXPECTED RESULT
//   All tests pass:  "All tests passed!"
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:week04_flutter_examples/00_stateless_vs_stateful.dart';
import 'package:week04_flutter_examples/01_hello_container.dart' as step01;
import 'package:week04_flutter_examples/02_hello_text.dart' as step02;
import 'package:week04_flutter_examples/03_scaffold.dart' as step03;
import 'package:week04_flutter_examples/04_appbar.dart' as step04;
import 'package:week04_flutter_examples/05_text_style.dart' as step05;
import 'package:week04_flutter_examples/06_custom_widget.dart' as step06;
import 'package:week04_flutter_examples/07_column.dart' as step07;
import 'package:week04_flutter_examples/08_row.dart' as step08;
import 'package:week04_flutter_examples/09_logical_pixels.dart';

// The text style that is really used for a Text widget on screen.
TextStyle effectiveStyle(WidgetTester tester, String text) {
  final element = tester.element(find.text(text));
  return DefaultTextStyle.of(element).style;
}

void main() {
  testWidgets('00 stateless Greeting and stateful checkbox', (tester) async {
    await tester.pumpWidget(const StatelessStatefulApp());
    expect(find.text('Hello, Rami'), findsOneWidget);
    expect(find.text('Not accepted'), findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);

    await tester.tap(find.byType(Checkbox)); // the stateful widget changes
    await tester.pump();
    expect(find.text('Accepted'), findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(find.text('Not accepted'), findsOneWidget);
  });

  testWidgets('01 a white Container fills the screen', (tester) async {
    await tester.pumpWidget(const step01.MyApp());
    final container = tester.widget<Container>(find.byType(Container));
    expect(container.color, Colors.white);
    // it fills the whole test screen (800 x 600 logical pixels)
    expect(tester.getSize(find.byType(Container)), const Size(800, 600));
  });

  testWidgets('02 MaterialApp alone gives the text the warning style', (
    tester,
  ) async {
    await tester.pumpWidget(const step02.MyApp());
    expect(find.text('Hello World'), findsOneWidget);
    // The slide: "ugly red/yellow text style". Red text, underlined.
    final style = effectiveStyle(tester, 'Hello World');
    expect(style.decoration, TextDecoration.underline);
    expect(style.decorationColor, const Color(0xFFFFFF00)); // yellow
    // ...and Center puts the text in the middle of the screen.
    final center = tester.getCenter(find.text('Hello World'));
    expect(center.dx, closeTo(400, 1));
    expect(center.dy, closeTo(300, 1));
  });

  testWidgets('03 a Scaffold gives the text a normal style', (tester) async {
    await tester.pumpWidget(const step03.MyApp());
    expect(find.text('Hello World'), findsOneWidget);
    final style = effectiveStyle(tester, 'Hello World');
    expect(style.decoration, anyOf(isNull, TextDecoration.none));
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('04 the AppBar shows a centered title', (tester) async {
    await tester.pumpWidget(const step04.MyApp());
    expect(find.text('Home Page'), findsOneWidget);
    expect(find.text('Hello World'), findsOneWidget);
    expect(tester.widget<AppBar>(find.byType(AppBar)).centerTitle, isTrue);
    // the title is in the horizontal middle of the 800 px wide screen
    expect(tester.getCenter(find.text('Home Page')).dx, closeTo(400, 1));
  });

  testWidgets('05 the text is size 24 and deep purple', (tester) async {
    await tester.pumpWidget(const step05.MyApp());
    final text = tester.widget<Text>(find.text('Hello World'));
    expect(text.style?.fontSize, 24);
    expect(text.style?.color, Colors.deepPurple);
  });

  testWidgets('06 MyTextWidget shows the text it is given', (tester) async {
    await tester.pumpWidget(const step06.MyApp());
    expect(find.text('Text 1'), findsOneWidget);
    final text = tester.widget<Text>(find.text('Text 1'));
    expect(text.style?.color, Colors.deepPurple);

    // The point of a custom widget: it can be reused with other texts.
    await tester.pumpWidget(
      const MaterialApp(
        home: Column(
          children: [
            step06.MyTextWidget(text: 'A'),
            step06.MyTextWidget(text: 'B'),
          ],
        ),
      ),
    );
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
  });

  testWidgets('07 Column places Text 1 above Text 2 with 16 px gaps', (
    tester,
  ) async {
    await tester.pumpWidget(const step07.MyApp());
    final t1 = tester.getCenter(find.text('Text 1'));
    final t2 = tester.getCenter(find.text('Text 2'));
    expect(t1.dy, lessThan(t2.dy)); // one below the other
    expect(t1.dx, closeTo(t2.dx, 1)); // same horizontal position
    // SizedBox(height: 16.0) is 16 logical pixels tall.
    final boxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
    expect(boxes.where((b) => b.height == 16.0).length, 2);
  });

  testWidgets('08 Row puts Text 3, 4 and 5 on one line, spread evenly', (
    tester,
  ) async {
    await tester.pumpWidget(const step08.MyApp());
    final t2 = tester.getCenter(find.text('Text 2'));
    final t3 = tester.getCenter(find.text('Text 3'));
    final t4 = tester.getCenter(find.text('Text 4'));
    final t5 = tester.getCenter(find.text('Text 5'));

    expect(t3.dy, greaterThan(t2.dy)); // the row is below Text 2
    expect(t4.dy, closeTo(t3.dy, 1)); // same line
    expect(t5.dy, closeTo(t3.dy, 1));
    expect(t3.dx, lessThan(t4.dx)); // left to right
    expect(t4.dx, lessThan(t5.dx));
    // spaceEvenly: the gaps between the three texts are equal
    expect(t4.dx - t3.dx, closeTo(t5.dx - t4.dx, 1));
  });

  testWidgets('09 logical size, pixel ratio and physical size', (tester) async {
    addTearDown(tester.view.reset);
    tester.view.devicePixelRatio = 2.0;
    tester.view.physicalSize = const Size(800, 1600); // physical pixels

    await tester.pumpWidget(const LogicalPixelsApp());
    expect(find.text('Logical size: 400.0 x 800.0'), findsOneWidget);
    expect(find.text('Device pixel ratio: 2.0'), findsOneWidget);
    expect(find.text('Physical size: 800.0 x 1600.0'), findsOneWidget);
    expect(
        find.text('16 logical pixels = 32.0 physical pixels'), findsOneWidget);
  });
}
