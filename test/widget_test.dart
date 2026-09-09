import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_learning/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.byType(MyApp), findsOneWidget);
  });
}
