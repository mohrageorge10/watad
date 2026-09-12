import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watad/features/auth/presentation/view/widgets/custom_horizontal_stepper.dart';

Widget createTestableWidget(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, _) => MaterialApp(
      home: Scaffold(body: Center(child: child)),
    ),
  );
}

void main() {
  group('CustomHorizontalStepper Widget Tests', () {
    testWidgets('renders all 4 step numbers', (tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const CustomHorizontalStepper(
            currentStep: 2,
            totalSteps: 4,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
    });

    testWidgets('renders correct number of connecting lines', (tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const CustomHorizontalStepper(
            currentStep: 1,
            totalSteps: 4,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // In 4 steps, there are 3 connecting lines (Expanded widgets)
      expect(find.byType(Expanded), findsNWidgets(3));
    });
  });
}
