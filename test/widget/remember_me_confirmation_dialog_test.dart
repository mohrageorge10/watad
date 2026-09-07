import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watad/features/auth/presentation/view/widgets/remember_me_confirmation_dialog.dart';

Widget createTestableWidget(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, _) => MaterialApp(
      home: Scaffold(body: Center(child: child)),
    ),
  );
}

void main() {
  group('RememberMeConfirmationDialog Widget Tests', () {
    testWidgets('renders dialog title and description in English', (tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          RememberMeConfirmationDialog(
            onEnableAndLogin: () {},
            onContinueWithout: () {},
            onCancel: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Stay Logged In?'), findsOneWidget);
      expect(
        find.textContaining("You haven't checked 'Remember me'"),
        findsOneWidget,
      );
      expect(find.text('Enable & Log In'), findsOneWidget);
      expect(find.text('Continue without Remember Me'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('triggers onEnableAndLogin when primary button is tapped', (tester) async {
      bool enableCalled = false;

      await tester.pumpWidget(
        createTestableWidget(
          RememberMeConfirmationDialog(
            onEnableAndLogin: () => enableCalled = true,
            onContinueWithout: () {},
            onCancel: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Enable & Log In'));
      await tester.pump();

      expect(enableCalled, isTrue);
    });

    testWidgets('triggers onContinueWithout when secondary button is tapped', (tester) async {
      bool continueWithoutCalled = false;

      await tester.pumpWidget(
        createTestableWidget(
          RememberMeConfirmationDialog(
            onEnableAndLogin: () {},
            onContinueWithout: () => continueWithoutCalled = true,
            onCancel: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue without Remember Me'));
      await tester.pump();

      expect(continueWithoutCalled, isTrue);
    });

    testWidgets('triggers onCancel when Cancel button is tapped', (tester) async {
      bool cancelCalled = false;

      await tester.pumpWidget(
        createTestableWidget(
          RememberMeConfirmationDialog(
            onEnableAndLogin: () {},
            onContinueWithout: () {},
            onCancel: () => cancelCalled = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pump();

      expect(cancelCalled, isTrue);
    });
  });
}
