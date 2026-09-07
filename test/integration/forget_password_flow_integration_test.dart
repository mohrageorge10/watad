import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinput/pinput.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/features/auth/domain/entities/auth_response_entity.dart';
import 'package:watad/features/auth/presentation/pages/forget_password_page.dart';
import 'package:watad/features/auth/presentation/pages/otp_page.dart';
import 'package:watad/features/auth/presentation/pages/reset_password_page.dart';
import 'package:watad/features/auth/presentation/view/widgets/spam_folder_hint_widget.dart';

import 'integration_test_helper.dart';

void main() {
  late TestDependencies deps;

  setUp(() {
    deps = setupTestServiceLocator();
  });

  GoRouter createTestRouter() {
    return GoRouter(
      initialLocation: AppRoutes.forgetPassScreen,
      routes: [
        GoRoute(
          path: AppRoutes.forgetPassScreen,
          builder: (context, state) => const ForgetPasswordPage(),
        ),
        GoRoute(
          path: AppRoutes.otpScreen,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return OtpPage(
              email: extra?['email'] as String?,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.resetPasswordScreen,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return ResetPasswordPage(
              email: extra?['email'] as String?,
              otp: extra?['otp'] as String?,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.loginScreen,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Login Screen')),
          ),
        ),
      ],
    );
  }

  group('Forget Password -> OTP -> Reset Password Flow Integration Tests', () {
    testWidgets('Validates email field before requesting reset code', (tester) async {
      setTestViewport(tester);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final router = createTestRouter();
      await tester.pumpWidget(buildTestableApp(router: router));
      await tester.pumpAndSettle();

      expect(find.byType(ForgetPasswordPage), findsOneWidget);

      // Tap Continue with empty email
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Email is required'), findsOneWidget);
      verifyNever(() => deps.forgotPasswordUseCase(any()));
    });

    testWidgets('Executes full E2E journey from Forget Password to OTP to Reset Password', (tester) async {
      setTestViewport(tester);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      // 1. Setup Mock responses
      when(() => deps.forgotPasswordUseCase(any())).thenAnswer(
        (_) async => ApiResult.success(
          const AuthResponseEntity(
            isSuccess: true,
            statusCode: 200,
            message: 'Reset code sent to your email',
          ),
        ),
      );

      when(() => deps.verifyOtpUseCase(any())).thenAnswer(
        (_) async => ApiResult.success(
          const AuthResponseEntity(
            isSuccess: true,
            statusCode: 200,
            message: 'OTP verified successfully',
          ),
        ),
      );

      when(() => deps.resetPasswordUseCase(any())).thenAnswer(
        (_) async => ApiResult.success(
          const AuthResponseEntity(
            isSuccess: true,
            statusCode: 200,
            message: 'Password reset successfully',
          ),
        ),
      );

      final router = createTestRouter();
      await tester.pumpWidget(buildTestableApp(router: router));
      await tester.pumpAndSettle();

      // Step A: Fill email in ForgetPasswordPage
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'mohraeel@watad.org',
      );
      await tester.pumpAndSettle();

      // Tap Continue
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // Step B: Verify transition to OtpPage & presence of SpamFolderHintWidget
      expect(find.byType(OtpPage), findsOneWidget);
      expect(find.byType(SpamFolderHintWidget), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) => w is RichText && w.text.toPlainText().contains('check your Spam'),
        ),
        findsOneWidget,
      );

      // Test OTP validation: tap continue with empty OTP
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      verifyNever(() => deps.verifyOtpUseCase(any()));

      // Enter 6-digit OTP code into Pinput
      await tester.enterText(find.byType(Pinput), '123456');
      await tester.pumpAndSettle();

      // Tap Continue to verify OTP
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // Verify verifyOtpUseCase was called
      verify(() => deps.verifyOtpUseCase(any(
            that: isA().having((req) => req.otp, 'otp', '123456'),
          ))).called(1);

      // Step C: Verify transition to ResetPasswordPage
      expect(find.byType(ResetPasswordPage), findsOneWidget);

      // Enter mismatched passwords to test validation
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'NewPassword123',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirm Password'),
        'DifferentPass123',
      );
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(AppElevatedButton, 'Done'));
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsOneWidget);
      verifyNever(() => deps.resetPasswordUseCase(any()));

      // Correct confirm password
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirm Password'),
        'NewPassword123',
      );
      await tester.pumpAndSettle();

      // Tap Done
      await tester.tap(find.widgetWithText(AppElevatedButton, 'Done'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Verify resetPasswordUseCase was called
      verify(() => deps.resetPasswordUseCase(any(
            that: isA()
                .having((req) => req.email, 'email', 'mohraeel@watad.org')
                .having((req) => req.newPassword, 'newPassword', 'NewPassword123'),
          ))).called(1);

      // Flush snackbar and timers
      await tester.pump(const Duration(seconds: 4));
    });
  });
}
