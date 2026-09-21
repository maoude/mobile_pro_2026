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
import 'package:week04_flutter_examples/10_appbar_options.dart' as step10;
import 'package:week04_flutter_examples/11_scaffold_extras.dart' as step11;
import 'package:week04_flutter_examples/12_expanded.dart' as step12;
import 'package:week04_flutter_examples/13_widget_types.dart' as step13;
import 'package:week04_flutter_examples/14_gestures.dart' as step14;
import 'package:week04_flutter_examples/15_widget_tree_dump.dart' as step15;

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

  // ---------------- Going further (not in the slides) ----------------
  testWidgets('10 AppBar has leading and action icons that react to taps', (
    tester,
  ) async {
    await tester.pumpWidget(const step10.MyApp());
    final bar = tester.widget<AppBar>(find.byType(AppBar));
    expect(bar.backgroundColor, Colors.teal);
    expect(bar.foregroundColor, Colors.white);
    expect(bar.elevation, 4);
    expect(find.byIcon(Icons.menu), findsOneWidget); // leading (left)
    expect(find.byIcon(Icons.search), findsOneWidget); // actions (right)
    expect(find.byIcon(Icons.settings), findsOneWidget);
    // the leading icon is left of the title, the actions are right of it
    final title = tester.getCenter(find.text('AppBar options')).dx;
    expect(tester.getCenter(find.byIcon(Icons.menu)).dx, lessThan(title));
    expect(
        tester.getCenter(find.byIcon(Icons.settings)).dx, greaterThan(title));

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump(); // show the SnackBar
    expect(find.text('Settings tapped'), findsOneWidget);
  });

  testWidgets('11 Scaffold slots: background, Card body, bottom bar', (
    tester,
  ) async {
    await tester.pumpWidget(const step11.MyApp());
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, Colors.blueGrey.shade50);
    expect(find.text('Scaffold extras'), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.text('A Card in the body'), findsOneWidget);
    // the bottom bar is at the bottom of the (600 px high) screen
    expect(find.text('Bottom bar'), findsOneWidget);
    expect(tester.getCenter(find.text('Bottom bar')).dy, greaterThan(500));
    // only one Scaffold on the page
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('12 Expanded shares the free height 1 : 2 : 1', (tester) async {
    await tester.pumpWidget(const step12.MyApp());
    double height(String key) =>
        tester.getSize(find.byKey(ValueKey(key))).height;

    final fixed = height('fixed');
    final a = height('box-a');
    final b = height('box-b');
    final c = height('box-c');

    expect(fixed, 60); // the fixed strip keeps its size
    expect(b, closeTo(2 * a, 0.01)); // flex 2 is twice flex 1
    expect(c, closeTo(a, 0.01)); // flex 1 and flex 1 are equal
    // together they fill the body: 600 (screen) - 56 (app bar)
    expect(fixed + a + b + c, closeTo(600 - 56, 0.01));
  });

  testWidgets('12 the shares follow the screen size', (tester) async {
    addTearDown(tester.view.reset);
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(400, 1000); // a tall phone
    await tester.pumpWidget(const step12.MyApp());
    final a = tester.getSize(find.byKey(const ValueKey('box-a'))).height;
    final b = tester.getSize(find.byKey(const ValueKey('box-b'))).height;
    expect(b, closeTo(2 * a, 0.01)); // still 1 : 2, on another screen
    expect(a, closeTo((1000 - 56 - 60) / 4, 0.01));
  });

  // ---------------- Part 2: architecture and widget types ----------------
  testWidgets('13 visible widgets, layout widgets, buttons change the state', (
    tester,
  ) async {
    await tester.pumpWidget(const step13.WidgetTypesApp());

    // visible widgets
    final hello = tester.widget<Text>(find.text('Hello, Flutter!'));
    expect(hello.textAlign, TextAlign.center);
    expect(hello.style?.fontWeight, FontWeight.bold);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
    final image = tester.widget<Image>(find.byType(Image));
    expect((image.image as AssetImage).assetName, 'assets/logo.png');
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // the buttons change the state of the page
    expect(find.text('Last button: none'), findsOneWidget);
    await tester.tap(find.byType(OutlinedButton));
    await tester.pump();
    expect(find.text('Last button: OutlinedButton'), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Last button: ElevatedButton'), findsOneWidget);

    // layout widgets: the three labels of the Row are on one line...
    final r1 = tester.getCenter(find.text('Row 1'));
    final r2 = tester.getCenter(find.text('Row 2'));
    final r3 = tester.getCenter(find.text('Row 3'));
    expect(r1.dy, closeTo(r2.dy, 1));
    expect(r2.dy, closeTo(r3.dy, 1));
    expect(r1.dx, lessThan(r2.dx));
    expect(r2.dx, lessThan(r3.dx));
    // ...and in the Stack the smaller red square is drawn on the blue one
    Finder square(Color c) =>
        find.byWidgetPredicate((w) => w is Container && w.color == c);
    final blue = tester.getRect(square(Colors.blue));
    final red = tester.getRect(square(Colors.red.shade300));
    expect(blue.contains(red.topLeft), isTrue);
    expect(blue.contains(red.bottomRight), isTrue);
    expect(red.center.dx, closeTo(blue.center.dx, 0.01));
    expect(red.center.dy, closeTo(blue.center.dy, 0.01));
  });

  testWidgets('14 GestureDetector: tap adds 1, long press resets', (
    tester,
  ) async {
    await tester.pumpWidget(const step14.GestureApp());
    final area = find.byKey(const ValueKey('touch-area'));
    expect(find.text('Taps: 0'), findsOneWidget);

    await tester.tap(area);
    await tester.pump();
    expect(find.text('Taps: 1'), findsOneWidget);
    await tester.tap(area);
    await tester.tap(area);
    await tester.pump();
    expect(find.text('Taps: 3'), findsOneWidget);

    await tester.longPress(area);
    await tester.pump();
    expect(find.text('Taps: 0'), findsOneWidget);
    expect(find.byIcon(Icons.touch_app), findsOneWidget);
  });

  testWidgets('15 debugDumpApp prints the widget tree, outside in', (
    tester,
  ) async {
    final lines = <String>[];
    final original = debugPrint;
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) lines.add(message);
    };
    try {
      await tester.pumpWidget(const step15.MyApp());
      expect(find.text('Hello'), findsOneWidget);
      expect(find.text('World'), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));

      final dump = lines.join('\n');
      expect(dump, contains('widget tree of the running app'));

      // Each widget must appear AFTER the widget that contains it.
      // (Siblings, such as AppBar and Center, can appear in any order.)
      int after(String name, int from) {
        final at = dump.indexOf(name, from);
        expect(at, greaterThanOrEqualTo(0),
            reason: '$name not found after $from');
        return at + name.length;
      }

      var p = after('MyApp', 0);
      p = after('MaterialApp', p);
      p = after('HomePage', p);
      final scaffold = after('Scaffold', p);
      after('AppBar', scaffold); // inside the Scaffold
      final center = after('Center', scaffold); // inside the Scaffold
      final column = after('Column', center); // the Center contains the Column
      expect(dump.indexOf('Text("Hello"', column), greaterThanOrEqualTo(0));
      expect(dump.indexOf('Text("World"', column), greaterThanOrEqualTo(0));
      final fab =
          after('FloatingActionButton', scaffold); // inside the Scaffold
      after('Icon', fab); // the button contains the Icon
    } finally {
      // Flutter checks that debugPrint is back to normal when the test ends.
      debugPrint = original;
    }
  });
}
