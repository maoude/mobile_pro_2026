import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:week07_examples/00_number_format.dart';
import 'package:week07_examples/01_http_request.dart';
import 'package:week07_examples/02_area_calculator.dart';
import 'package:week07_examples/services/post_service.dart';

void main() {
  testWidgets('explicit locales format numbers', (tester) async {
    await tester.pumpWidget(const FormattingApp());
    expect(find.text('US: 1,234.57'), findsOneWidget);
    expect(find.text('German: 1.234,57'), findsOneWidget);
  });
  testWidgets('calculator validates and computes both shapes', (tester) async {
    await tester.pumpWidget(const AreaApp());
    await tester.tap(find.text('Rectangle'));
    await tester.pump();
    expect(find.textContaining('Enter finite, positive'), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(0), '4');
    await tester.enterText(find.byType(TextField).at(1), '3');
    await tester.tap(find.text('Rectangle'));
    await tester.pump();
    expect(find.text('Area: 12 square units'), findsOneWidget);
    await tester.tap(find.text('Triangle'));
    await tester.pump();
    expect(find.text('Area: 6 square units'), findsOneWidget);
  });
  testWidgets('HTTP error can be retried successfully', (tester) async {
    var calls = 0;
    final client = MockClient((request) async {
      expect(request.url.scheme, 'https');
      calls++;
      return calls == 1
          ? http.Response('Unavailable', 503)
          : http.Response('{"title":"Package example"}', 200);
    });
    addTearDown(client.close);
    await tester.pumpWidget(MaterialApp(home: HttpPage(client: client)));
    await tester.pumpAndSettle();
    expect(find.text('Could not load the post.'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Package example'), findsOneWidget);
  });
  test('malformed JSON payload is rejected', () async {
    final client = MockClient((_) async => http.Response('{"title":42}', 200));
    addTearDown(client.close);
    await expectLater(PostService(client).fetchPost(), throwsFormatException);
  });
}
