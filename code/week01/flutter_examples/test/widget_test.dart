// =====================================================================
// Automated checks for the week 1 Flutter examples
// =====================================================================
// Each test starts an example widget in a test window and checks that what
// appears on screen matches the "EXPECTED RESULT" written at the top of
// that example's file. It also contains the widget test from the lecture
// (section 7, "Testing Fundamentals").
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

import 'package:week01_flutter_examples/04_profile_card.dart';
import 'package:week01_flutter_examples/05_dependency_injection.dart' as di;
import 'package:week01_flutter_examples/07_future_builder.dart';
import 'package:week01_flutter_examples/08_stream_cleanup.dart';
import 'package:week01_flutter_examples/10_late_bad_vs_good.dart';
import 'package:week01_flutter_examples/13_load_state_ui.dart';
import 'package:week01_flutter_examples/14_widget_tree.dart' as widget_tree;
import 'package:week01_flutter_examples/15_counter_button.dart';
import 'package:week01_flutter_examples/16_lifecycle.dart';
import 'package:week01_flutter_examples/17_responsive_grid.dart';
import 'package:week01_flutter_examples/18_theme.dart';
import 'package:week01_flutter_examples/data/user_repository.dart';
import 'package:week01_flutter_examples/models/user.dart';

void main() {
  // ---------------- Lecture listing 20 (Testing Fundamentals) ----------------
  group('04 ProfileCard', () {
    testWidgets('shows user info', (tester) async {
      final user = User(id: '1', name: 'John', email: 'john@example.com');
      await tester.pumpWidget(MaterialApp(home: ProfileCard(user: user)));

      // find.text looks for a Text widget with exactly this text.
      expect(find.text('John'), findsOneWidget);
      expect(find.text('john@example.com'), findsOneWidget);
      expect(find.text('J'), findsOneWidget); // the avatar letter
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var taps = 0;
      final user = User(id: '1', name: 'John', email: 'john@example.com');
      await tester.pumpWidget(
        MaterialApp(
          home: ProfileCard(user: user, onTap: () => taps++),
        ),
      );
      await tester.tap(find.byType(ListTile));
      expect(taps, 1);
    });
  });

  // ---------------- 05 + 07: Provider, repository, FutureBuilder ----------------
  group('05/07 dependency injection + FutureBuilder', () {
    testWidgets('shows a spinner, then the three users', (tester) async {
      await tester.pumpWidget(const di.MyApp());

      // Right after start the fake server has not answered yet.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // The fake server takes 200 ms.
      await tester.pump(const Duration(milliseconds: 250));

      expect(find.byType(CircularProgressIndicator), findsNothing);
      for (final name in ['Alice', 'Bob', 'Carol']) {
        expect(find.text(name), findsOneWidget);
      }
      expect(find.text('alice@example.com'), findsOneWidget);
    });

    testWidgets('UserProfileView works with any repository', (tester) async {
      final repo = UserRepository(FakeApiService(), InMemoryCacheService());
      await tester.pumpWidget(
        MaterialApp(
          home: Provider<UserRepository>.value(
            value: repo,
            child: const UserProfileView(userId: 'x'),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.byType(ProfileCard), findsNWidgets(3));
    });

    test('the repository caches: the API is called only once', () async {
      final api = FakeApiService();
      final repo = UserRepository(api, InMemoryCacheService());

      await repo.getUsers(); // cache miss -> API
      await repo.getUsers(); // cache hit  -> no API call
      expect(api.calls, 1);

      await repo.getUsers(forceRefresh: true); // forced -> API again
      expect(api.calls, 2);
    });
  });

  // ---------------- 08 streams ----------------
  testWidgets('08 counts stream events and cleans up on dispose', (
    tester,
  ) async {
    await tester.pumpWidget(const ActivityTrackerApp());
    expect(find.text('Activities received: 0'), findsOneWidget);
    expect(find.text('Last activity: none'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // deliver the stream event
    await tester.pump(); // redraw after setState
    expect(find.text('Activities received: 1'), findsOneWidget);
    expect(find.text('Last activity: tap #1'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    await tester.pump();
    expect(find.text('Activities received: 2'), findsOneWidget);

    // Removing the widget runs dispose() (cancel + close). If anything were
    // left running, the test framework would report it.
    await tester.pumpWidget(const SizedBox.shrink());
  });

  // ---------------- 10 late ----------------
  group('10 late', () {
    testWidgets('GoodExample assigns data in initState', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: GoodExample()));
      expect(find.text('ready'), findsOneWidget);
    });

    testWidgets('BadExample crashes with a late initialization error', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: BadExample()));
      // The error thrown while building is kept by the test framework. Its
      // message starts with "LateInitializationError:".
      expect(
        tester.takeException(),
        isA<Error>().having(
          (e) => e.toString(),
          'message',
          contains('LateInitializationError'),
        ),
      );
    });
  });

  // ---------------- 13 sealed classes ----------------
  testWidgets('13 buildUI returns a widget for every state', (tester) async {
    await tester.pumpWidget(const LoadStateApp());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('42'), findsOneWidget);
    expect(find.text('Error: timeout'), findsOneWidget);
  });

  // ---------------- 14 widget tree ----------------
  testWidgets('14 shows Hello with the right app title', (tester) async {
    await tester.pumpWidget(const widget_tree.MyApp());
    expect(find.text('Hello'), findsOneWidget);
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.title, 'Business Card App');
  });

  // ---------------- 15 stateful counter ----------------
  testWidgets('15 CounterButton counts taps', (tester) async {
    await tester.pumpWidget(const CounterApp());
    expect(find.text('Count: 0'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // setState -> rebuild
    expect(find.text('Count: 1'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Count: 3'), findsOneWidget);
  });

  // ---------------- 16 lifecycle ----------------
  testWidgets('16 timer ticks, lifecycle is tracked, dispose cleans up', (
    tester,
  ) async {
    await tester.pumpWidget(const LifecycleApp());
    expect(find.text('Ticks: 0'), findsOneWidget);
    expect(find.text('Lifecycle: unknown'), findsOneWidget);

    // Let 3 seconds pass: the periodic timer fires 3 times.
    await tester.pump(const Duration(seconds: 3));
    expect(find.text('Ticks: 3'), findsOneWidget);

    // Simulate the app going inactive and coming back.
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    await tester.pump();
    expect(find.text('Lifecycle: inactive'), findsOneWidget);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(find.text('Lifecycle: resumed'), findsOneWidget);

    // dispose() must cancel the timer: otherwise the test fails with
    // "A Timer is still pending even after the widget tree was disposed".
    await tester.pumpWidget(const SizedBox.shrink());
  });

  // ---------------- 17 responsive grid ----------------
  testWidgets('17 grid has 2 columns on a phone and 3 on a wide screen', (
    tester,
  ) async {
    addTearDown(tester.view.reset);
    tester.view.devicePixelRatio = 1.0;

    int columns() {
      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      return delegate.crossAxisCount;
    }

    tester.view.physicalSize = const Size(400, 800); // phone-sized
    await tester.pumpWidget(const GridApp());
    expect(columns(), 2);
    expect(find.text('Card 0'), findsOneWidget);

    tester.view.physicalSize = const Size(900, 800); // wide screen
    await tester.pumpAndSettle();
    expect(columns(), 3);
  });

  // ---------------- 18 theme ----------------
  testWidgets('18 AppTheme is a Material 3 light theme', (tester) async {
    final theme = AppTheme.light();
    expect(theme.useMaterial3, isTrue);
    expect(theme.colorScheme.brightness, Brightness.light);

    await tester.pumpWidget(const ThemeDemoApp());
    expect(find.text('Theming'), findsOneWidget);
    expect(find.text('Themed button'), findsOneWidget);
  });
}
