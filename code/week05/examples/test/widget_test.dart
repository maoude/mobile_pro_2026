// =====================================================================
// Automated checks for the week 5, part 2 examples (gestures and state)
// =====================================================================
// Each test starts one example in a test window and touches it like a user:
// it presses, moves and lifts pointers, taps, drags, pinches, and checks that
// what appears on screen matches the "EXPECTED RESULT" written at the top of
// that example's file. Some tests check claims made in the lecture notes, for
// example that the deepest GestureDetector wins the tap, that a ListenableBuilder
// rebuilds only itself, and that a Consumer without a provider above it fails.
//
// HOW TO RUN
//   flutter test
//
// EXPECTED RESULT
//   All tests pass:  "All tests passed!"
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:week05_examples/00_pointer_events.dart' as ex00;
import 'package:week05_examples/01_tap_gestures.dart' as ex01;
import 'package:week05_examples/02_drag_gestures.dart' as ex02;
import 'package:week05_examples/03_pan_ball.dart' as ex03;
import 'package:week05_examples/04_pinch_scale.dart' as ex04;
import 'package:week05_examples/05_gesture_arena.dart' as ex05;
import 'package:week05_examples/06_ephemeral_state.dart' as ex06;
import 'package:week05_examples/07_lifting_state_up.dart' as ex07;
import 'package:week05_examples/08_change_notifier.dart' as ex08;
import 'package:week05_examples/10_dropdown_button.dart' as ex10;
import 'package:week05_examples/11_form_validation.dart' as ex11;
import 'package:week05_examples/12_more_validators.dart' as ex12;
import 'package:week05_examples/09_provider_cart.dart' as ex09;
import 'package:week05_examples/13_input_formatters.dart' as ex13;
import 'package:week05_examples/14_controller_listener.dart' as ex14;
import 'package:week05_examples/15_form_of_builder.dart' as ex15;
import 'package:week05_examples/16_custom_formfield.dart' as ex16;

void main() {
  testWidgets('00 Listener: down, move, up and cancel pointer events', (
    tester,
  ) async {
    await tester.pumpWidget(const ex00.MyApp());
    expect(find.text('Last event: none'), findsOneWidget);
    final area = find.byKey(const ValueKey('area'));
    final center = tester.getCenter(area);

    // A finger touches the square...
    final finger = await tester.startGesture(center);
    await tester.pump();
    expect(find.text('Last event: PointerDownEvent'), findsOneWidget);
    // ...the position is inside the square (the square is 240 x 240).
    expect(find.text('Position: (120, 120)'), findsOneWidget);

    // ...moves...
    await finger.moveBy(const Offset(30, 10));
    await tester.pump();
    expect(find.text('Last event: PointerMoveEvent'), findsOneWidget);
    expect(find.text('Position: (150, 130)'), findsOneWidget);

    // ...and leaves the screen.
    await finger.up();
    await tester.pump();
    expect(find.text('Last event: PointerUpEvent'), findsOneWidget);
    expect(find.text('Down: 1   Move: 1   Up: 1   Cancel: 0'), findsOneWidget);

    // An interrupted interaction sends a cancel event instead of an up event.
    final second = await tester.startGesture(center);
    await second.cancel();
    await tester.pump();
    expect(find.text('Last event: PointerCancelEvent'), findsOneWidget);
    expect(find.text('Down: 2   Move: 1   Up: 1   Cancel: 1'), findsOneWidget);
  });

  group('01 GestureDetector: tap, double tap, long press', () {
    Finder counter(String name, int n) => find.text('$name: $n');

    testWidgets('a tap is delayed while onDoubleTap is set', (tester) async {
      await tester.pumpWidget(const ex01.MyApp());
      await tester.tap(find.byKey(const ValueKey('box')));
      await tester.pump(const Duration(milliseconds: 150));
      // Flutter waits to see whether a second tap follows...
      expect(counter('onTap', 0), findsOneWidget);
      // ...then the whole tap arrives: down, up, tap.
      await tester.pump(const Duration(milliseconds: 250));
      expect(counter('onTapDown', 1), findsOneWidget);
      expect(counter('onTapUp', 1), findsOneWidget);
      expect(counter('onTap', 1), findsOneWidget);
      expect(find.text('Last event: onTap'), findsOneWidget);
      expect(counter('onDoubleTap', 0), findsOneWidget);
    });

    testWidgets('without onDoubleTap a tap is instant', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: GestureDetector(
              onTap: () => taps++,
              // (An empty SizedBox draws nothing and cannot be hit: give the
              // detector something to touch, here a colored box.)
              child: Container(
                key: const ValueKey('plain'),
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byKey(const ValueKey('plain')));
      await tester.pump(); // no waiting
      expect(taps, 1);
    });

    testWidgets('an empty box is not hit, unless behavior is opaque', (
      tester,
    ) async {
      var taps = 0;
      Widget detector(HitTestBehavior behavior) => MaterialApp(
            home: Center(
              child: GestureDetector(
                behavior: behavior,
                onTap: () => taps++,
                child: const SizedBox(
                  key: ValueKey('empty'),
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          );

      // deferToChild (the default): an empty SizedBox draws nothing, so the
      // touch goes through it.
      await tester.pumpWidget(detector(HitTestBehavior.deferToChild));
      await tester.tap(find.byKey(const ValueKey('empty')), warnIfMissed: false);
      await tester.pump();
      expect(taps, 0);

      // opaque: the whole box receives the touch, drawn or not.
      await tester.pumpWidget(detector(HitTestBehavior.opaque));
      await tester.tap(find.byKey(const ValueKey('empty')));
      await tester.pump();
      expect(taps, 1);
    });

    testWidgets('two quick taps are one double tap', (tester) async {
      await tester.pumpWidget(const ex01.MyApp());
      final box = find.byKey(const ValueKey('box'));
      await tester.tap(box);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(box);
      await tester.pump(const Duration(milliseconds: 500));
      expect(counter('onDoubleTap', 1), findsOneWidget);
      expect(counter('onTap', 0), findsOneWidget);
      expect(find.text('Last event: onDoubleTap'), findsOneWidget);
    });

    testWidgets('a long press wins and the tap is cancelled', (tester) async {
      await tester.pumpWidget(const ex01.MyApp());
      await tester.longPress(find.byKey(const ValueKey('box')));
      await tester.pump(const Duration(milliseconds: 500));
      expect(counter('onLongPress', 1), findsOneWidget);
      expect(counter('onTapCancel', 1), findsOneWidget);
      expect(counter('onTap', 0), findsOneWidget);
    });

    testWidgets('moving the finger away cancels the tap', (tester) async {
      await tester.pumpWidget(const ex01.MyApp());
      final box = find.byKey(const ValueKey('box'));
      final finger = await tester.startGesture(tester.getCenter(box));
      await tester.pump(const Duration(milliseconds: 150));
      await finger.moveBy(const Offset(200, 0));
      await tester.pump();
      await finger.up();
      await tester.pump(const Duration(milliseconds: 500));
      expect(counter('onTapDown', 1), findsOneWidget);
      expect(counter('onTapCancel', 1), findsOneWidget);
      expect(counter('onTap', 0), findsOneWidget);
    });
  });

  testWidgets('02 horizontal and vertical drags move a square', (tester) async {
    await tester.pumpWidget(const ex02.MyApp());
    expect(find.text('Horizontal: x = 0'), findsOneWidget);
    expect(find.text('Vertical: y = 0'), findsOneWidget);

    // A horizontal drag uses only the horizontal part of the movement.
    await tester.drag(
        find.byKey(const ValueKey('horizontal')), const Offset(100, 30));
    await tester.pump();
    expect(find.text('Horizontal: x = 100'), findsOneWidget);
    expect(find.text('Vertical: y = 0'), findsOneWidget);
    expect(find.text('Last event: onHorizontalDragEnd'), findsOneWidget);

    // The square stops at the end of its track (240).
    await tester.drag(
        find.byKey(const ValueKey('horizontal')), const Offset(500, 0));
    await tester.pump();
    expect(find.text('Horizontal: x = 240'), findsOneWidget);

    // The vertical square: down to the end of the track, then back up.
    await tester.drag(
        find.byKey(const ValueKey('vertical')), const Offset(20, 500));
    await tester.pump();
    expect(find.text('Vertical: y = 240'), findsOneWidget);
    expect(find.text('Last event: onVerticalDragEnd'), findsOneWidget);
    await tester.drag(
        find.byKey(const ValueKey('vertical')), const Offset(0, -100));
    await tester.pump();
    expect(find.text('Vertical: y = 140'), findsOneWidget);
  });

  testWidgets('03 pan moves the ball in any direction', (tester) async {
    await tester.pumpWidget(const ex03.MyApp());
    expect(find.text('Position: (125, 125)'), findsOneWidget);
    expect(find.text('Pan state: idle'), findsOneWidget);

    // While the finger moves, the state is "panning".
    final ball = find.byKey(const ValueKey('ball'));
    final finger = await tester.startGesture(tester.getCenter(ball));
    await finger.moveBy(const Offset(60, 40));
    await tester.pump();
    expect(find.text('Pan state: panning'), findsOneWidget);
    expect(find.text('Position: (185, 165)'), findsOneWidget); // dx AND dy
    await finger.up();
    await tester.pump();
    expect(find.text('Pan state: idle'), findsOneWidget);

    // The ball stays inside the 300 x 300 field (300 - 50 = 250).
    await tester.drag(ball, const Offset(500, 500));
    await tester.pump();
    expect(find.text('Position: (250, 250)'), findsOneWidget);

    await tester.tap(find.text('RESET'));
    await tester.pump();
    expect(find.text('Position: (125, 125)'), findsOneWidget);
  });

  testWidgets('04 pinch scales the square, and keeps the size', (tester) async {
    await tester.pumpWidget(const ex04.MyApp());
    expect(find.text('Scale: 1.00'), findsOneWidget);
    expect(find.text('Rotation: 0 degrees'), findsOneWidget);

    // Two fingers, 40 pixels apart, move apart to 80: the scale is 2.
    final center = tester.getCenter(find.byKey(const ValueKey('square')));
    var left = await tester.startGesture(center - const Offset(20, 0), pointer: 1);
    var right = await tester.startGesture(center + const Offset(20, 0), pointer: 2);
    await left.moveBy(const Offset(-20, 0));
    await right.moveBy(const Offset(20, 0));
    await tester.pump();
    expect(find.text('Scale: 2.00'), findsOneWidget);
    await left.up();
    await right.up();
    await tester.pump();
    expect(find.text('Scale: 2.00'), findsOneWidget); // the size is kept

    // A second pinch starts again at 1.0 but multiplies the kept size:
    // fingers 80 apart come to 40 (scale 0.5): 2.0 * 0.5 = 1.0.
    left = await tester.startGesture(center - const Offset(40, 0), pointer: 3);
    right = await tester.startGesture(center + const Offset(40, 0), pointer: 4);
    await left.moveBy(const Offset(20, 0));
    await right.moveBy(const Offset(-20, 0));
    await tester.pump();
    expect(find.text('Scale: 1.00'), findsOneWidget);
    await left.up();
    await right.up();
    await tester.pump();

    // The size is limited to 3 times.
    left = await tester.startGesture(center - const Offset(20, 0), pointer: 5);
    right = await tester.startGesture(center + const Offset(20, 0), pointer: 6);
    await left.moveBy(const Offset(-100, 0));
    await right.moveBy(const Offset(100, 0));
    await tester.pump();
    expect(find.text('Scale: 3.00'), findsOneWidget);
    await left.up();
    await right.up();
    await tester.pump();

    await tester.tap(find.text('RESET'));
    await tester.pump();
    expect(find.text('Scale: 1.00'), findsOneWidget);

    // The claim of the notes: scale is a superset of pan, so a pan and a scale
    // on the same GestureDetector are refused.
    expect(
      () => GestureDetector(onPanUpdate: (_) {}, onScaleUpdate: (_) {}),
      throwsAssertionError,
    );
    // A pan with only ONE kind of drag is accepted.
    expect(
      () => GestureDetector(onPanUpdate: (_) {}, onHorizontalDragUpdate: (_) {}),
      returnsNormally,
    );
  });

  testWidgets('05 the arena: the deepest detector wins, unless told otherwise', (
    tester,
  ) async {
    await tester.pumpWidget(const ex05.MyApp());
    Finder text(String s) => find.text(s);
    // The demo texts appear twice ("parent: n" in each demo): check by order.
    List<String> parentTexts() => tester
        .widgetList<Text>(find.textContaining('parent:'))
        .map((t) => t.data!)
        .toList();
    List<String> childTexts() => tester
        .widgetList<Text>(find.textContaining('child:'))
        .map((t) => t.data!)
        .toList();
    expect(parentTexts(), ['parent: 0', 'parent: 0']);
    expect(childTexts(), ['child: 0', 'child: 0']);
    expect(text('Default'), findsOneWidget);
    expect(text('Multiple'), findsOneWidget);

    // Default: a tap on the child goes to the child only.
    await tester.tap(find.byKey(const ValueKey('defaultChild')));
    await tester.pump();
    expect(parentTexts(), ['parent: 0', 'parent: 0']);
    expect(childTexts(), ['child: 1', 'child: 0']);

    // A tap on the yellow border goes to the parent.
    await tester.tapAt(
        tester.getTopLeft(find.byKey(const ValueKey('defaultParent'))) +
            const Offset(10, 10));
    await tester.pump();
    expect(parentTexts(), ['parent: 1', 'parent: 0']);
    expect(childTexts(), ['child: 1', 'child: 0']);

    // Multiple (RawGestureDetector): a tap on the child goes to BOTH.
    await tester.tap(find.byKey(const ValueKey('multipleChild')));
    await tester.pump();
    expect(parentTexts(), ['parent: 1', 'parent: 1']);
    expect(childTexts(), ['child: 1', 'child: 1']);

    // ...and a tap on the border goes to the parent only.
    await tester.tapAt(
        tester.getTopLeft(find.byKey(const ValueKey('multipleParent'))) +
            const Offset(10, 10));
    await tester.pump();
    expect(parentTexts(), ['parent: 1', 'parent: 2']);
    expect(childTexts(), ['child: 1', 'child: 1']);
  });

  testWidgets('06 ephemeral state: each widget has its own state', (
    tester,
  ) async {
    await tester.pumpWidget(const ex06.MyApp());
    expect(find.text('Rami'), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Lina'), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Rami'), findsOneWidget);

    // Three hearts, all empty.
    expect(find.byIcon(Icons.favorite_border), findsNWidgets(3));
    expect(find.byIcon(Icons.favorite), findsNothing);

    // Tap the second: only its own state changes.
    await tester.tap(find.byType(IconButton).at(1));
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNWidgets(2));
    final second = find.byType(ex06.LikeButton).at(1);
    expect(
      find.descendant(of: second, matching: find.byIcon(Icons.favorite)),
      findsOneWidget,
    );

    await tester.tap(find.byType(IconButton).at(1));
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsNothing);
  });

  testWidgets('07 lifting the state up: data down, events up', (tester) async {
    await tester.pumpWidget(const ex07.MyApp());
    expect(find.text('Items in the cart: 0'), findsOneWidget);
    expect(find.text('Add (0 in the cart)'), findsOneWidget);

    await tester.tap(find.byType(ex07.AddButton));
    await tester.pump();
    await tester.tap(find.byType(ex07.AddButton));
    await tester.pump();
    // The state is in ShopPage; three widgets show it.
    expect(find.text('Items in the cart: 2'), findsOneWidget);
    expect(find.text('Add (2 in the cart)'), findsOneWidget);
    expect(
      find.descendant(
          of: find.byType(ex07.CartBadge), matching: find.text('2')),
      findsOneWidget,
    );

    await tester.tap(find.text('CLEAR'));
    await tester.pump();
    expect(find.text('Items in the cart: 0'), findsOneWidget);
    expect(find.text('Add (0 in the cart)'), findsOneWidget);
  });

  group('08 ChangeNotifier', () {
    test('the model notifies its listeners after each change', () {
      final model = ex08.CounterModel();
      var calls = 0;
      model.addListener(() => calls++);
      model.increment();
      model.increment();
      model.decrement();
      expect(model.value, 1);
      expect(calls, 3);
    });

    testWidgets('only the ListenableBuilder is rebuilt, not the page', (
      tester,
    ) async {
      await tester.pumpWidget(const ex08.MyApp());
      expect(find.text('Counter: 0'), findsOneWidget);
      expect(find.text('Page built: 1 time(s)'), findsOneWidget);
      expect(find.text('Text built: 1 time(s)'), findsOneWidget);

      for (var i = 0; i < 3; i++) {
        await tester.tap(find.text('+'));
        await tester.pump();
      }
      expect(find.text('Counter: 3'), findsOneWidget);
      expect(find.text('Text built: 4 time(s)'), findsOneWidget);
      // The page was not built again: no setState anywhere.
      expect(find.text('Page built: 1 time(s)'), findsOneWidget);

      await tester.tap(find.text('-'));
      await tester.pump();
      expect(find.text('Counter: 2'), findsOneWidget);
    });
  });

  group('09 provider', () {
    test('the cart model computes the total and notifies', () {
      final cart = ex09.CartModel();
      var calls = 0;
      cart.addListener(() => calls++);
      cart.add(ex09.products[0]); // Coffee 3
      cart.add(ex09.products[2]); // Cake 5
      expect(cart.total, 8);
      cart.remove(ex09.products[0]);
      expect(cart.items.length, 1);
      cart.clear();
      expect(cart.items, isEmpty);
      expect(calls, 4);
    });

    testWidgets('the cart is shared by two pages, and the theme by all', (
      tester,
    ) async {
      await tester.pumpWidget(const ex09.ShopApp());
      expect(find.text('Catalog'), findsOneWidget);
      // No item yet: no badge.
      expect(find.text('0'), findsNothing);

      // Add Coffee twice and Cake once: read with context.read in onPressed.
      await tester.tap(find.byTooltip('Add Coffee'));
      await tester.pump();
      expect(find.text('1'), findsOneWidget); // the badge (context.select)
      await tester.tap(find.byTooltip('Add Coffee'));
      await tester.tap(find.byTooltip('Add Cake'));
      await tester.pump();
      expect(find.text('3'), findsOneWidget);

      // The cart page sees the same model (the provider is above MaterialApp).
      await tester.tap(find.byTooltip('Open the cart'));
      await tester.pumpAndSettle();
      expect(find.text('Your items'), findsOneWidget);
      expect(find.text('Coffee'), findsNWidgets(2));
      expect(find.text('Cake'), findsOneWidget);
      expect(find.text('Total: 11.00'), findsOneWidget);

      // Removing an item changes the total (Consumer rebuilds).
      await tester.tap(find.byTooltip('Remove Coffee').first);
      await tester.pump();
      expect(find.text('Total: 8.00'), findsOneWidget);
      expect(find.text('Coffee'), findsOneWidget);

      // The other model, SettingsModel: the theme changes on ALL pages.
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('2'), findsOneWidget); // the badge follows the cart
      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).theme!.brightness,
        Brightness.light,
      );
      await tester.tap(find.byTooltip('Change the theme'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).theme!.brightness,
        Brightness.dark,
      );
      expect(find.byIcon(Icons.light_mode), findsOneWidget); // icon changed
      await tester.tap(find.byTooltip('Open the cart'));
      await tester.pumpAndSettle();
      expect(
        Theme.of(tester.element(find.byType(ex09.CartPage))).brightness,
        Brightness.dark,
      );

      // CLEAR empties the cart.
      await tester.tap(find.text('CLEAR'));
      await tester.pump();
      expect(find.text('Total: 0.00'), findsOneWidget);
    });

    testWidgets('a Consumer needs a provider ABOVE it', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Consumer<ex09.CartModel>(
            builder: (context, cart, child) => Text('${cart.items.length}'),
          ),
        ),
      );
      expect(tester.takeException(), isA<ProviderNotFoundException>());
    });
  });

  group('10 to 12 forms and validation', () {
    testWidgets('10 DropdownButton: data down, onChanged up', (tester) async {
      await tester.pumpWidget(const ex10.MyApp());
      expect(find.text('You live in: Calcutta'), findsOneWidget);
      expect(find.text('Calcutta'), findsOneWidget); // the closed dropdown

      await tester.tap(find.text('Calcutta'));
      await tester.pumpAndSettle();
      expect(find.text('Mumbai'), findsOneWidget); // the open menu
      await tester.tap(find.text('Mumbai').last);
      await tester.pumpAndSettle();

      expect(find.text('You live in: Mumbai'), findsOneWidget);
      expect(find.text('Mumbai'), findsOneWidget); // the closed dropdown now
      expect(find.text('Calcutta'), findsNothing);
    });

    testWidgets('11 Form + GlobalKey<FormState>: validate, submit, reset', (
      tester,
    ) async {
      await tester.pumpWidget(const ex11.MyApp());
      expect(find.text('Your name'), findsOneWidget);
      expect(find.text('Your age'), findsOneWidget);

      // Submitting an empty form shows the errors and does nothing else.
      await tester.tap(find.text('SUBMIT'));
      await tester.pump();
      expect(find.text('Please fill in this field'), findsNWidgets(2));
      expect(find.textContaining('Name:'), findsNothing);

      // A filled, valid form: the errors go away and the result appears.
      await tester.enterText(find.byType(TextFormField).at(0), 'Lina');
      await tester.enterText(find.byType(TextFormField).at(1), '20');
      await tester.tap(find.text('Calcutta')); // opens the dropdown menu
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mumbai').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('SUBMIT'));
      await tester.pump();
      expect(find.text('Please fill in this field'), findsNothing);
      expect(find.text('Name: Lina, age: 20, city: Mumbai'), findsOneWidget);

      // RESET clears the fields, the city, and the result.
      await tester.tap(find.text('RESET'));
      await tester.pump();
      expect(find.text('Name: Lina, age: 20, city: Mumbai'), findsNothing);
      expect(
        tester.widget<TextFormField>(find.byType(TextFormField).at(0)).controller!.text,
        isEmpty,
      );
      expect(find.text('Calcutta'), findsOneWidget);
    });

    testWidgets('11 the validator and currentState claims are real errors', (
      tester,
    ) async {
      // The notes claim these are compile-time errors under null safety, not
      // just style warnings; that cannot be checked at runtime, so instead we
      // check the fixed versions behave as documented.
      String? requiredValidator(String? value) =>
          (value == null || value.isEmpty) ? 'required' : null;
      expect(requiredValidator(null), 'required');
      expect(requiredValidator(''), 'required');
      expect(requiredValidator('x'), isNull);

      final key = GlobalKey<FormState>();
      expect(key.currentState, isNull); // before the Form is built
    });

    testWidgets('12 chained validators and autovalidateMode', (tester) async {
      await tester.pumpWidget(const ex12.MyApp());
      final email = find.byType(TextFormField).at(0);
      final password = find.byType(TextFormField).at(1);
      final confirm = find.byType(TextFormField).at(2);

      // Nothing typed yet: autovalidateMode.disabled-like silence until touched.
      expect(find.text('Please fill in this field'), findsNothing);

      // onUserInteraction: touching a field shows its own error live.
      await tester.enterText(email, 'abc');
      await tester.pump();
      expect(find.text('Not a valid email address'), findsOneWidget);

      await tester.enterText(email, 'a@b.com');
      await tester.pump();
      expect(find.text('Not a valid email address'), findsNothing);

      await tester.enterText(password, '123');
      await tester.pump();
      expect(find.text('At least 6 characters'), findsOneWidget);

      await tester.enterText(password, '123456');
      await tester.enterText(confirm, '000000');
      await tester.pump();
      expect(find.text('Passwords do not match'), findsOneWidget);

      await tester.enterText(confirm, '123456');
      await tester.pump();
      expect(find.text('Passwords do not match'), findsNothing);

      await tester.tap(find.text('CHECK'));
      await tester.pump();
      expect(find.text('All fields are valid!'), findsOneWidget);
    });
  });

  group('13 to 16 custom inputs (going deeper into forms)', () {
    testWidgets('13 inputFormatters: only digits, at most 6', (tester) async {
      await tester.pumpWidget(const ex13.MyApp());
      expect(find.text('You typed: '), findsOneWidget);

      // Letters are denied entirely.
      await tester.enterText(find.byType(TextField), 'abc');
      await tester.pump();
      expect(find.text('You typed: '), findsOneWidget);

      // Digits pass through, but stop at 6 characters.
      await tester.enterText(find.byType(TextField), 'abc123defg456');
      await tester.pump();
      expect(find.text('You typed: 123456'), findsOneWidget);
    });

    testWidgets('14 addListener fires for user AND program changes', (
      tester,
    ) async {
      await tester.pumpWidget(const ex14.MyApp());
      expect(find.text('Mirrored by addListener: '), findsOneWidget);

      // A change made by the user: the listener mirrors it (like onChanged).
      await tester.enterText(find.byType(TextField), 'Hi');
      await tester.pump();
      expect(find.text('Mirrored by addListener: Hi'), findsOneWidget);

      // A change made by the PROGRAM: onChanged would stay silent (part 1),
      // but addListener still fires.
      await tester.tap(find.text('SET TO HELLO (programmatically)'));
      await tester.pump();
      expect(find.text('Hello'), findsOneWidget); // the field itself
      expect(find.text('Mirrored by addListener: Hello'), findsOneWidget);
    });

    testWidgets('15 Form.of(context) needs a context BELOW the Form', (
      tester,
    ) async {
      await tester.pumpWidget(const ex15.MyApp());
      expect(find.text('valid: false'), findsNothing);

      // Empty field: validate() (through Form.of, via the Builder) fails.
      await tester.tap(find.text('VALIDATE (Form.of)'));
      await tester.pump();
      expect(find.text('Please fill in this field'), findsOneWidget);
      expect(find.text('valid: false'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'Lina');
      await tester.tap(find.text('VALIDATE (Form.of)'));
      await tester.pump();
      expect(find.text('Please fill in this field'), findsNothing);
      expect(find.text('valid: true'), findsOneWidget);

      // The claim of the notes: Form.of() with a context ABOVE the Form
      // throws, unlike Form.maybeOf() which would return null.
      final aboveContext =
          tester.element(find.byType(Scaffold).first);
      expect(() => Form.of(aboveContext), throwsFlutterError);
      expect(Form.maybeOf(aboveContext), isNull);
    });

    testWidgets('16 a custom FormField: validate, save, reset', (
      tester,
    ) async {
      await tester.pumpWidget(const ex16.MyApp());
      expect(
        find.text('Enter the 6-digit code we sent you'),
        findsOneWidget,
      );

      // Empty: the validator's first message.
      await tester.tap(find.text('SUBMIT'));
      await tester.pump();
      expect(find.text('Enter the 6-digit code'), findsOneWidget);
      expect(find.textContaining('Code accepted'), findsNothing);

      // Too short: the validator's second message. Also: only digits, and at
      // most 6 of them, thanks to the same formatters as example 13.
      await tester.enterText(find.byType(TextField), 'ab12');
      await tester.tap(find.text('SUBMIT'));
      await tester.pump();
      expect(find.text('The code must have 6 digits'), findsOneWidget);

      // A full 6-digit code: validate() passes, save() calls onSaved, and the
      // field is then cleared by reset().
      await tester.enterText(find.byType(TextField), '1234567');
      await tester.tap(find.text('SUBMIT'));
      await tester.pump();
      expect(find.text('The code must have 6 digits'), findsNothing);
      expect(find.text('Code accepted: 123456'), findsOneWidget);
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        isEmpty,
      );
    });
  });
}
