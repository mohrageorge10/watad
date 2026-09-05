import 'package:flutter_test/flutter_test.dart';
import 'package:watad/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const WatadApp());
    expect(find.byType(WatadApp), findsOneWidget);
  });
}
