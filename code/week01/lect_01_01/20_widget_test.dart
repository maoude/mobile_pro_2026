// Source: 002_lect_01_01.tex, section 7. Assessment, Testing and Metrics - Testing Fundamentals (Widget Test)
// flutter_test. Needs User (03) and ProfileCard (04).

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('ProfileCard shows user info', (tester) async {
    final user = User(id: '1', name: 'John', email: 'john@example.com');
    await tester.pumpWidget(MaterialApp(home: ProfileCard(user: user)));
    expect(find.text('John'), findsOneWidget);
    expect(find.text('john@example.com'), findsOneWidget);
  });
}
