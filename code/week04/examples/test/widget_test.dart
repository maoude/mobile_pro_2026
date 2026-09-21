// =====================================================================
// Automated checks for the week 4, part 3 examples
// =====================================================================
// Each test starts one example in a test window and checks that what appears
// on screen matches the "EXPECTED RESULT" written at the top of that file.
// Some tests check a claim made in the lecture notes, for example that a
// ListView placed directly in a Column fails, and that Expanded fixes it.
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

import 'package:week04_examples/01_widgets_full_program.dart' as ex01;
import 'package:week04_examples/02_scaffold_bottom_bar.dart' as ex02;
import 'package:week04_examples/03_custom_appbar.dart' as ex03;
import 'package:week04_examples/04_expanded_flag.dart' as ex04;
import 'package:week04_examples/05_expanded_listview.dart' as ex05;
import 'package:week04_examples/06_scaffold_drawer.dart' as ex06;
import 'package:week04_examples/07_cupertino_scaffold.dart' as ex07;
import 'package:week04_examples/08_container_effects.dart' as ex08;

void main() {
  // The test window is 800 x 600 logical pixels; the app bar is 56 tall.
  const double bodyHeight = 600 - kToolbarHeight;

  testWidgets('01 full program: widget types, parameters, button state', (
    tester,
  ) async {
    await tester.pumpWidget(const ex01.WidgetsFullProgramApp());

    // The three parts of the page.
    expect(find.text('Widgets and Their Types'), findsOneWidget); // AppBar
    expect(find.text('1) Visible Widgets'), findsOneWidget);
    expect(find.text('Hello, Flutter!'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.text('No button selected'), findsOneWidget);

    // Tapping a button changes the last line (the page is stateful).
    await tester.tap(find.byType(OutlinedButton));
    await tester.pump();
    expect(find.text('OutlinedButton'), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('ElevatedButton'), findsOneWidget);
    expect(find.text('No button selected'), findsNothing);

    // The layout widgets of part 2 and the parameters of part 3 are further
    // down the page: scroll to them.
    await tester.scrollUntilVisible(find.text('Stack'), 300);
    expect(find.byType(Stack), findsWidgets);
    await tester.scrollUntilVisible(
      find.text('3) Common Widget Parameters'),
      300,
    );
    expect(find.text('3) Common Widget Parameters'), findsOneWidget);
  });

  testWidgets('02 Scaffold: bottom bar, floating button, keyboard', (
    tester,
  ) async {
    await tester.pumpWidget(const ex02.MyApp());

    expect(find.text('Scaffold Example'), findsOneWidget);
    expect(find.byType(BottomAppBar), findsOneWidget);
    expect(find.text('bottomNavigationBar'), findsOneWidget);
    expect(find.text('Taps: 0'), findsOneWidget);

    // The Scaffold fills the whole window.
    expect(tester.getSize(find.byType(Scaffold)), const Size(800, 600));
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, Colors.blueGrey);

    // The floating button changes the state.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.text('Taps: 2'), findsOneWidget);

    // When the keyboard opens (300 logical pixels), the Scaffold makes the
    // body smaller by itself: the card moves up.
    final before = tester.getCenter(find.text('Taps: 2')).dy;
    tester.view.viewInsets = const FakeViewPadding(bottom: 900); // physical px
    addTearDown(tester.view.resetViewInsets);
    await tester.pump();
    final after = tester.getCenter(find.text('Taps: 2')).dy;
    expect(after, lessThan(before));
  });

  testWidgets('03 custom AppBar: PreferredSizeWidget, leading, actions', (
    tester,
  ) async {
    await tester.pumpWidget(const ex03.MyApp());

    expect(find.text('Container Widget'), findsOneWidget);
    expect(find.text('Hello Flutter!'), findsOneWidget);

    // The bar is as tall as the custom class announces in preferredSize.
    expect(const ex03.MyAppBar(title: 'x').preferredSize.height, 100);
    expect(tester.getSize(find.byType(AppBar)).height, 100);

    final bar = tester.widget<AppBar>(find.byType(AppBar));
    expect(bar.backgroundColor, Colors.black);
    expect(bar.elevation, 0.0);
    expect(find.byIcon(Icons.menu), findsOneWidget); // leading
    expect(find.byIcon(Icons.settings), findsOneWidget); // actions

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();
    expect(find.text('Menu tapped'), findsOneWidget);
    // Snack bars are shown one after the other: wait until the first one
    // has gone, then the second one appears.
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump(const Duration(seconds: 5)); // first one is shown
    await tester.pump(const Duration(seconds: 5)); // ... and goes away
    await tester.pumpAndSettle();
    expect(find.text('Settings tapped'), findsOneWidget);
  });

  testWidgets('04 Expanded children with no flex share the space equally', (
    tester,
  ) async {
    await tester.pumpWidget(const ex04.MyApp());

    final heights = [
      for (final name in ['area1', 'area2', 'area3', 'area4'])
        tester.getSize(find.byKey(ValueKey(name))).height,
    ];
    // Four equal shares...
    for (final h in heights) {
      expect(h, closeTo(heights.first, 0.01));
    }
    // ...of what the word Luxembourg leaves.
    final word = tester.getSize(find.text('Luxembourg', findRichText: true));
    expect(heights.reduce((a, b) => a + b) + word.height,
        closeTo(bodyHeight, 0.01));

    // Top to bottom: red, empty, word, empty, blue.
    double top(Finder f) => tester.getTopLeft(f).dy;
    expect(top(find.byKey(const ValueKey('area1'))),
        lessThan(top(find.byKey(const ValueKey('area2')))));
    expect(top(find.byKey(const ValueKey('area2'))),
        lessThan(top(find.text('Luxembourg', findRichText: true))));
    expect(top(find.text('Luxembourg', findRichText: true)),
        lessThan(top(find.byKey(const ValueKey('area3')))));
    expect(top(find.byKey(const ValueKey('area3'))),
        lessThan(top(find.byKey(const ValueKey('area4')))));
  });

  testWidgets('05 a ListView in a Column needs Expanded', (tester) async {
    // The claim: a ListView directly in a Column fails (unbounded height).
    final errors = <FlutterErrorDetails>[];
    final original = FlutterError.onError;
    FlutterError.onError = errors.add; // collect the errors, do not fail
    try {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(children: [ListView(children: const [Text('a')])]),
          ),
        ),
      );
    } finally {
      // Flutter checks that onError is back to normal when the test ends.
      FlutterError.onError = original;
    }
    expect(errors, isNotEmpty);
    expect(errors.first.exceptionAsString(), contains('unbounded height'));

    // The example wraps it in Expanded: no error, and the list takes exactly
    // the height that the header and the footer leave.
    await tester.pumpWidget(const ex05.MyApp());
    expect(tester.takeException(), isNull);
    final header = tester.getSize(find.byKey(const ValueKey('header')));
    final footer = tester.getSize(find.byKey(const ValueKey('footer')));
    final list = tester.getSize(find.byType(ListView));
    expect(list.height + header.height + footer.height,
        closeTo(bodyHeight, 0.01));

    // The list scrolls; the header and the footer stay.
    expect(find.text('Country 1'), findsOneWidget);
    expect(find.text('Country 20'), findsNothing); // not built yet
    await tester.scrollUntilVisible(find.text('Country 20'), 200);
    expect(find.text('Country 20'), findsOneWidget);
    expect(find.text('Countries'), findsOneWidget);
    expect(find.text('Scroll the list'), findsOneWidget);
  });

  testWidgets('06 Drawer: menu buttons appear by themselves, rows close it', (
    tester,
  ) async {
    await tester.pumpWidget(const ex06.MyApp());
    expect(find.text('Page: Home'), findsOneWidget);
    expect(find.byType(Drawer), findsNothing); // closed

    // The AppBar added a button for each drawer: nobody wrote them.
    expect(find.byType(DrawerButton), findsOneWidget);
    expect(find.byType(EndDrawerButton), findsOneWidget);

    await tester.tap(find.byType(DrawerButton));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    expect(find.text('Menu'), findsOneWidget); // the DrawerHeader
    expect(find.byType(ListTile), findsNWidgets(3));

    // Tapping a row changes the page AND closes the drawer (Navigator.pop).
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsNothing);
    expect(find.text('Page: Settings'), findsOneWidget);

    // A swipe from the left edge opens it too.
    await tester.dragFrom(const Offset(5, 300), const Offset(300, 0));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();
    expect(find.text('Page: About'), findsOneWidget);

    // The end drawer comes from the right.
    await tester.tap(find.byType(EndDrawerButton));
    await tester.pumpAndSettle();
    expect(find.text('End drawer'), findsOneWidget);
    expect(tester.getTopRight(find.byType(Drawer)).dx, 800);
  });

  testWidgets('07 Cupertino: CupertinoPageScaffold, navigation bar, button', (
    tester,
  ) async {
    await tester.pumpWidget(const ex07.MyApp());
    expect(find.byType(CupertinoPageScaffold), findsOneWidget);
    expect(find.byType(CupertinoNavigationBar), findsOneWidget);
    expect(find.byType(Scaffold), findsNothing); // no Material here
    expect(find.text('Cupertino Example'), findsOneWidget); // "middle"
    expect(find.text('Home'), findsOneWidget); // "leading"
    expect(tester.getCenter(find.text('Cupertino Example')).dx,
        closeTo(400, 1));

    expect(find.text('Taps: 0'), findsOneWidget);
    await tester.tap(find.byType(CupertinoButton));
    await tester.pump();
    await tester.tap(find.byType(CupertinoButton));
    await tester.pump();
    expect(find.text('Taps: 2'), findsOneWidget);
  });

  testWidgets('08 Container: margin, padding, decoration, alignment', (
    tester,
  ) async {
    await tester.pumpWidget(const ex08.MyApp());
    Finder box(int n) => find.byKey(ValueKey('box$n'));
    Container container(int n) => tester.widget<Container>(box(n));

    // 1. margin is OUTSIDE (the amber rectangle starts 20 from the edge);
    //    padding is INSIDE (the rectangle is 12 + 12 larger than its text).
    final text1 = tester.getSize(find.text('margin 20, padding 12'));
    final amber =
        find.descendant(of: box(1), matching: find.byType(ColoredBox));
    expect(tester.getTopLeft(amber) - tester.getTopLeft(box(1)),
        const Offset(20, 20));
    expect(tester.getSize(amber).width, closeTo(text1.width + 24, 0.01));
    expect(tester.getSize(amber).height, closeTo(text1.height + 24, 0.01));
    // The Container itself includes the margin: 20 on each side.
    expect(tester.getSize(box(1)).width, closeTo(text1.width + 24 + 40, 0.01));

    // 2. the parameters of the BoxDecoration.
    final deco2 = container(2).decoration! as BoxDecoration;
    expect(deco2.color, Colors.white);
    expect(deco2.border, isNotNull);
    expect(deco2.borderRadius, BorderRadius.circular(16));
    expect(deco2.boxShadow, hasLength(1));

    // 3. a gradient of two colors.
    final deco3 = container(3).decoration! as BoxDecoration;
    expect((deco3.gradient! as LinearGradient).colors,
        [Colors.orange, Colors.purple]);

    // 4. an 80 x 80 box with shape circle.
    expect(
      tester.getSize(
          find.descendant(of: box(4), matching: find.byType(DecoratedBox))),
      const Size(80, 80),
    );
    expect((container(4).decoration! as BoxDecoration).shape, BoxShape.circle);

    // 5. the child is at the bottom right corner (inside the 8 px padding).
    final corner = tester.getBottomRight(
        find.descendant(of: box(5), matching: find.byType(ColoredBox)));
    final label = tester.getBottomRight(find.text('bottom right'));
    expect(corner.dx - label.dx, closeTo(8, 0.01));
    expect(corner.dy - label.dy, closeTo(8, 0.01));

    // 6. a transform is set.
    expect(container(6).transform, isNotNull);

    // The claim of the notes: color and decoration cannot be given together.
    expect(
      () => Container(color: Colors.red, decoration: const BoxDecoration()),
      throwsAssertionError,
    );
  });
}
