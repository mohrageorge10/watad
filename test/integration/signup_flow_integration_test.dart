import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinput/pinput.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/features/auth/data/models/role_model.dart';
import 'package:watad/features/auth/domain/entities/auth_response_entity.dart';
import 'package:watad/features/auth/domain/entities/user_entity.dart';
import 'package:watad/features/auth/presentation/pages/sign_up_email_confirmation_page.dart';
import 'package:watad/features/auth/presentation/pages/sign_up_password_page.dart';
import 'package:watad/features/auth/presentation/pages/sign_up_personal_info_page.dart';
import 'package:watad/features/auth/presentation/pages/sign_up_role_page.dart';
import 'package:watad/features/auth/presentation/view/widgets/custom_horizontal_stepper.dart';
import 'package:watad/features/auth/presentation/view/widgets/spam_folder_hint_widget.dart';

import 'integration_test_helper.dart';

void main() {
  late TestDependencies deps;

  setUp(() {
    deps = setupTestServiceLocator();
  });

  GoRouter createTestRouter() {
    return GoRouter(
      initialLocation: AppRoutes.signUpScreen,
      routes: [
        GoRoute(
          path: AppRoutes.signUpScreen,
          builder: (context, state) => const SignUpRolePage(),
        ),
        GoRoute(
          path: AppRoutes.signUpPersonalInfo,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return SignUpPersonalInfoPage(
              role: extra?['role'] as RoleModel?,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.signUpPassword,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return SignUpPasswordPage(
              role: extra?['role'] as RoleModel?,
              email: extra?['email'] as String?,
              fullName: extra?['fullName'] as String?,
              phone: extra?['phone'] as String?,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.signUpConfirmation,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return SignUpEmailConfirmationPage(
              role: extra?['role'] as RoleModel?,
              email: extra?['email'] as String?,
              fullName: extra?['fullName'] as String?,
              phone: extra?['phone'] as String?,
              password: extra?['password'] as String?,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Home Screen')),
          ),
        ),
      ],
    );
  }

  group('Multi-Step Sign Up Journey E2E Integration Tests', () {
    testWidgets('Executes full 4-step registration journey from role selection to email confirmation', (tester) async {
      setTestViewport(tester);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      // 1. Setup Mock register and confirmEmail responses
      when(() => deps.registerUseCase(any())).thenAnswer(
        (_) async => ApiResult.success(
          const AuthResponseEntity(
            isSuccess: true,
            statusCode: 200,
            message: 'Registration successful. Verification email sent.',
          ),
        ),
      );

      when(() => deps.confirmEmailUseCase(any())).thenAnswer(
        (_) async => ApiResult.success(
          const AuthResponseEntity(
            isSuccess: true,
            statusCode: 200,
            message: 'Account confirmed successfully!',
            user: UserEntity(
              userId: '42',
              fullName: 'Mohraeel George',
              email: 'mohraeel@watad.org',
              token: 'confirmed_jwt_token',
            ),
          ),
        ),
      );

      final router = createTestRouter();
      await tester.pumpWidget(buildTestableApp(router: router));
      await tester.pumpAndSettle();

      // ============================================
      // STEP 1: SignUpRolePage
      // ============================================
      expect(find.byType(SignUpRolePage), findsOneWidget);
      expect(find.byType(CustomHorizontalStepper), findsOneWidget);

      // Verify Stepper is at Step 1
      final stepperStep1 = tester.widget<CustomHorizontalStepper>(find.byType(CustomHorizontalStepper));
      expect(stepperStep1.currentStep, 1);

      // Tap on a role card (e.g. Engineer)
      await tester.tap(find.text('Engineer'));
      await tester.pumpAndSettle();

      // Tap Continue
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // ============================================
      // STEP 2: SignUpPersonalInfoPage
      // ============================================
      expect(find.byType(SignUpPersonalInfoPage), findsOneWidget);

      // Verify Stepper is at Step 2
      final stepperStep2 = tester.widget<CustomHorizontalStepper>(find.byType(CustomHorizontalStepper));
      expect(stepperStep2.currentStep, 2);

      // Tap Continue with empty fields to verify validations
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Full Name is required'), findsOneWidget);
      expect(find.text('Phone number is required'), findsOneWidget);

      // Fill in valid personal details
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'mohraeel@watad.org',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'),
        'Mohraeel George',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Phone Number'),
        '01012345678',
      );
      await tester.pumpAndSettle();

      // Tap Continue
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // ============================================
      // STEP 3: SignUpPasswordPage
      // ============================================
      expect(find.byType(SignUpPasswordPage), findsOneWidget);

      // Verify Stepper is at Step 3
      final stepperStep3 = tester.widget<CustomHorizontalStepper>(find.byType(CustomHorizontalStepper));
      expect(stepperStep3.currentStep, 3);

      // Fill passwords
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Password123',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirm Password'),
        'Password123',
      );
      await tester.pumpAndSettle();

      // Tap Continue to register
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // Verify registerUseCase was called with correct data
      verify(() => deps.registerUseCase(any(
            that: isA()
                .having((req) => req.fullName, 'fullName', 'Mohraeel George')
                .having((req) => req.email, 'email', 'mohraeel@watad.org')
                .having((req) => req.phoneNumber, 'phoneNumber', '01012345678')
                .having((req) => req.password, 'password', 'Password123'),
          ))).called(1);

      // ============================================
      // STEP 4: SignUpEmailConfirmationPage
      // ============================================
      expect(find.byType(SignUpEmailConfirmationPage), findsOneWidget);

      // Verify Stepper is at Step 4
      final stepperStep4 = tester.widget<CustomHorizontalStepper>(find.byType(CustomHorizontalStepper));
      expect(stepperStep4.currentStep, 4);

      // Verify presence of SpamFolderHintWidget and email info
      expect(find.byType(SpamFolderHintWidget), findsOneWidget);
      expect(find.text('Email Confirmation:'), findsOneWidget);

      // Enter 6-digit confirmation code into Pinput (triggers auto-completion)
      await tester.enterText(find.byType(Pinput), '654321');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // Verify confirmEmailUseCase was called with email and OTP
      verify(() => deps.confirmEmailUseCase(any(
            that: isA()
                .having((req) => req.email, 'email', 'mohraeel@watad.org')
                .having((req) => req.otp, 'otp', '654321'),
          ))).called(1);

      // Verify navigation to Home Screen upon successful email confirmation
      expect(find.text('Home Screen'), findsOneWidget);

      // Flush snackbar and timers
      await tester.pump(const Duration(seconds: 4));
    });
  });
}
