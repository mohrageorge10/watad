import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/features/auth/domain/entities/auth_response_entity.dart';
import 'package:watad/features/auth/domain/entities/user_entity.dart';
import 'package:watad/features/auth/presentation/pages/login_page.dart';
import 'package:watad/features/auth/presentation/view/widgets/remember_me_confirmation_dialog.dart';

import 'integration_test_helper.dart';

void main() {
  late TestDependencies deps;

  setUp(() {
    deps = setupTestServiceLocator();
  });

  GoRouter createTestRouter() {
    return GoRouter(
      initialLocation: AppRoutes.loginScreen,
      routes: [
        GoRoute(
          path: AppRoutes.loginScreen,
          builder: (context, state) => const LoginPage(),
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

  group('Login Flow Integration & E2E Tests', () {
    testWidgets('Validates empty form fields before submission', (tester) async {
      setTestViewport(tester);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final router = createTestRouter();
      await tester.pumpWidget(buildTestableApp(router: router));
      await tester.pumpAndSettle();

      // Verify on Login Page
      expect(find.byType(LoginPage), findsOneWidget);

      // Tap Login button with empty inputs
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pumpAndSettle();

      // Expect validation errors to appear matching AppValidators
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);

      // Verify no login API was called
      verifyNever(() => deps.loginUseCase(any()));
    });

    testWidgets('Shows RememberMeConfirmationDialog when remember me is unchecked and handles Cancel', (tester) async {
      setTestViewport(tester);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final router = createTestRouter();
      await tester.pumpWidget(buildTestableApp(router: router));
      await tester.pumpAndSettle();

      // Enter valid credentials
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'mohraeel@watad.org',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Password123',
      );
      await tester.pumpAndSettle();

      // Tap Login without checking Remember Me
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pumpAndSettle();

      // Confirm dialog appears with English title
      expect(find.byType(RememberMeConfirmationDialog), findsOneWidget);
      expect(find.text('Stay Logged In?'), findsOneWidget);

      // Tap Cancel button
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Confirm dialog is dismissed and no API was called
      expect(find.byType(RememberMeConfirmationDialog), findsNothing);
      verifyNever(() => deps.loginUseCase(any()));
    });

    testWidgets('Confirms login without remember me and proceeds with authentication', (tester) async {
      setTestViewport(tester);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      when(() => deps.loginUseCase(any())).thenAnswer(
        (_) async => ApiResult.success(
          const AuthResponseEntity(
            isSuccess: true,
            statusCode: 200,
            message: 'Welcome back to Watad!',
            user: UserEntity(
              userId: '1',
              fullName: 'Mohraeel George',
              email: 'mohraeel@watad.org',
              token: 'mock_jwt_token',
            ),
          ),
        ),
      );

      final router = createTestRouter();
      await tester.pumpWidget(buildTestableApp(router: router));
      await tester.pumpAndSettle();

      // Enter valid credentials
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'mohraeel@watad.org',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Password123',
      );
      await tester.pumpAndSettle();

      // Tap Login
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(RememberMeConfirmationDialog), findsOneWidget);

      // Tap "Continue without Remember Me"
      await tester.tap(find.text('Continue without Remember Me'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Verify login usecase was called with rememberMe == false
      verify(() => deps.loginUseCase(any(
            that: isA().having((req) => req.rememberMe, 'rememberMe', isFalse),
          ))).called(1);

      // Flush snackbar timers
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets('Bypasses dialog and logs in directly when remember me is checked', (tester) async {
      setTestViewport(tester);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      when(() => deps.loginUseCase(any())).thenAnswer(
        (_) async => ApiResult.success(
          const AuthResponseEntity(
            isSuccess: true,
            statusCode: 200,
            message: 'Welcome back to Watad!',
            user: UserEntity(
              userId: '1',
              fullName: 'Mohraeel George',
              email: 'mohraeel@watad.org',
              token: 'mock_jwt_token',
            ),
          ),
        ),
      );

      final router = createTestRouter();
      await tester.pumpWidget(buildTestableApp(router: router));
      await tester.pumpAndSettle();

      // Enter valid credentials
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'mohraeel@watad.org',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Password123',
      );

      // Check "Remember me"
      await tester.tap(find.text('Remember me'));
      await tester.pumpAndSettle();

      // Tap Login
      await tester.tap(find.byType(AppElevatedButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Verify dialog never appeared
      expect(find.byType(RememberMeConfirmationDialog), findsNothing);

      // Verify login usecase was called with rememberMe == true
      verify(() => deps.loginUseCase(any(
            that: isA().having((req) => req.rememberMe, 'rememberMe', isTrue),
          ))).called(1);

      // Flush snackbar timers
      await tester.pump(const Duration(seconds: 4));
    });
  });
}
