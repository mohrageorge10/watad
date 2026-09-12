import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watad/features/contractor/profile/presentation/pages/edit_profile_screen.dart';

void main() {
  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          home: EditProfileScreen(),
        );
      },
    );
  }

  group('EditProfileScreen Widget Tests', () {
    testWidgets('renders header, form fields and action buttons',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Check Header Title
      expect(find.text('Edit Profile'), findsOneWidget);

      // Check Form Labels
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Company Name'), findsOneWidget);
      expect(find.text('Specialization'), findsOneWidget);
      expect(find.text('Years of Experience'), findsOneWidget);
      expect(find.text('Covered Governorates'), findsOneWidget);
      expect(find.text('Bio'), findsOneWidget);

      // Scroll to bottom
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -400));
      await tester.pumpAndSettle();

      // Check Official Details section
      expect(find.text('Official Details (Optional)'), findsOneWidget);
      expect(find.text('Commercial Register Number'), findsOneWidget);
      expect(find.text('Tax ID'), findsOneWidget);

      // Check Action Buttons
      expect(find.text('Save Changes'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('allows removing and adding governorate chips', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Chips initially contain Cairo and Giza
      expect(find.text('Cairo'), findsOneWidget);
      expect(find.text('Giza'), findsOneWidget);

      // Scroll to + Add More and tap
      await tester.scrollUntilVisible(
        find.text('+ Add More'),
        100,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('+ Add More'));
      await tester.pumpAndSettle();

      // Dialog opens: select Alexandria from suggestions list
      expect(find.text('Add Covered Governorate'), findsOneWidget);
      await tester.tap(find.text('Alexandria'));
      await tester.pumpAndSettle();

      // Check that Alexandria was added to chips
      expect(find.text('Alexandria'), findsOneWidget);
    });
  });
}
