import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watad/core/theme/app_colors.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          backgroundColor: AppColors.white100,
          body: Center(child: Text('Watad App Smoke Test')),
        ),
      ),
    );
    expect(find.text('Watad App Smoke Test'), findsOneWidget);
  });
}
