import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/features/auth/domain/entities/auth_response_entity.dart';
import 'package:watad/features/auth/domain/entities/user_entity.dart';
import 'package:watad/features/auth/presentation/pages/login_page.dart';
import 'package:watad/features/auth/presentation/view/widgets/remember_me_confirmation_dialog.dart';

import '../test/integration/integration_test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

  testWidgets('E2E App Smoke & Authentication Flow', (tester) async {
    setTestViewport(tester);

    when(() => deps.loginUseCase(any())).thenAnswer(
      (_) async => ApiResult.success(
        const AuthResponseEntity(
          isSuccess: true,
          statusCode: 200,
          message: 'Welcome back to Watad!',
          user: UserEntity(
            userId: '100',
            fullName: 'E2E Test User',
            email: 'e2e@watad.org',
            token: 'e2e_jwt_token',
          ),
        ),
      ),
    );

    final router = createTestRouter();
    await tester.pumpWidget(buildTestableApp(router: router));
    await tester.pumpAndSettle();

    // 1. Check Login Page displays
    expect(find.byType(LoginPage), findsOneWidget);

    // 2. Type credentials
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'e2e@watad.org',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'Password123',
    );
    await tester.pumpAndSettle();

    // 3. Tap Login button -> dialog appears
    await tester.tap(find.byType(AppElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(RememberMeConfirmationDialog), findsOneWidget);
    expect(find.text('Stay Logged In?'), findsOneWidget);

    // 4. Tap "Enable & Log In"
    await tester.tap(find.text('Enable & Log In'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify login was executed with rememberMe = true
    verify(() => deps.loginUseCase(any(
          that: isA().having((req) => req.rememberMe, 'rememberMe', isTrue),
        ))).called(1);

    // Flush timers
    await tester.pump(const Duration(seconds: 4));
  });
}
