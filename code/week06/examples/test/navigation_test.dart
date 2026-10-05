import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:week06_examples/07_named_routes.dart';

void main() {
  testWidgets('filters category, returns selection, preserves it on cancel',
      (tester) async {
    await tester.pumpWidget(const NavigationApp());
    await tester.tap(find.text('Food'));
    await tester.pumpAndSettle();
    expect(find.text('Burger'), findsOneWidget);
    expect(find.text('Fresh juice'), findsNothing);
    await tester.tap(find.text('Burger'));
    await tester.pumpAndSettle();
    expect(find.text('Meal'), findsOneWidget);
    await tester.tap(find.text('Choose this item'));
    await tester.pumpAndSettle();
    expect(find.text('Chosen: Burger'), findsOneWidget);
    await tester.tap(find.text('Salad'));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Chosen: Burger'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Categories'), findsOneWidget);
  });

  for (final scenario in [
    (name: '/missing', arguments: null),
    (name: DetailPage.routeName, arguments: 'missing-id'),
    (name: CategoryPage.routeName, arguments: 42),
  ]) {
    testWidgets('handles ${scenario.name} / ${scenario.arguments}',
        (tester) async {
      await tester.pumpWidget(const NavigationApp());
      final context = tester.element(find.byType(CategoriesPage));
      Navigator.of(context)
          .pushNamed<void>(scenario.name, arguments: scenario.arguments);
      await tester.pumpAndSettle();
      expect(find.text('Unknown route or invalid arguments.'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Categories'), findsOneWidget);
    });
  }
}
