import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';

Widget createTestableWidget(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, _) => MaterialApp(
      home: Scaffold(body: Center(child: child)),
    ),
  );
}

void main() {
  group('AppElevatedButton Widget Tests', () {
    testWidgets('renders button title correctly', (tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          AppElevatedButton(
            title: 'Sign In',
            onPressed: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sign In'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('triggers onPressed when tapped and not loading', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        createTestableWidget(
          AppElevatedButton(
            title: 'Submit',
            onPressed: () => wasPressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(wasPressed, isTrue);
    });

    testWidgets('shows CircularProgressIndicator and disables tap when isLoading is true', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        createTestableWidget(
          AppElevatedButton(
            title: 'Loading Button',
            isLoading: true,
            onPressed: () => wasPressed = true,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading Button'), findsNothing);

      // Attempt to tap the button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(wasPressed, isFalse);
    });
  });
}
