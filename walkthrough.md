# Walkthrough - شبكة اختبارات Unit, Widget & Integration/E2E Tests لتطبيق وتد

تم بنجاح بناء وتشغيل مجموعة اختبارات متكاملة واحترافية (44 اختباراً شاملاً) تغطي كافة طبقات التطبيق: طبقة الـ Core، الـ Data، الـ Presentation، ومسارات المستخدم التفاعلية من البداية للنهاية (End-to-End User Journeys).

---

## 1. اختبارات التكامل ونهاية-إلى-نهاية (Integration / E2E Tests)

### أ. [login_flow_integration_test.dart](file:///h:/Grad%20Project/watad/test/integration/login_flow_integration_test.dart) (4 اختبارات)
- **فحص التحقق من الحقول الفارغة (Form Validations)**: التأكد من ظهور رسائل الخطأ `"Email is required"` و `"Password is required"` عند الضغط على Login دون كتابة بيانات، والتأكد من عدم إرسال أي طلب للـ API.
- **فحص حوار الـ Remember Me (Stay Logged In?)**: إدخال بيانات صحيحة مع ترك خيار "Remember me" غير محدد، والتأكد من ظهور دايالوج التنبيه `RememberMeConfirmationDialog` بعنوانه الإنجليزي `"Stay Logged In?"`، واختبار الضغط على `"Cancel"` وإغلاق الحوار بأمان.
- **تأكيد المتابعة بدون تذكرني (Continue without Remember Me)**: فحص تفاعل المستخدم مع الخيار الثاني والتأكد من تنفيذ دالة الـ Login مع إرسال `rememberMe: false`.
- **تسجيل الدخول المباشر (Direct Login with Remember Me)**: فحص تحديد خيار "Remember me" مسبقاً وتخطي الدايالوج فوراً واستدعاء الـ Login مع `rememberMe: true`.

### ب. [forget_password_flow_integration_test.dart](file:///h:/Grad%20Project/watad/test/integration/forget_password_flow_integration_test.dart) (2 اختبارات)
- **التحقق من حقل البريد**: فحص التحقق من صحة البريد قبل إرسال رمز الاستعادة.
- **الرحلة الكاملة (Forget Password -> OTP -> Reset Password)**:
  1. إدخال البريد الإلكتروني في `ForgetPasswordPage` والضغط على Continue.
  2. الانتقال لشاشة `OtpPage` والتأكد من ظهور ويدجت التنبيه `SpamFolderHintWidget` بنصها المنسق (RichText) وتمرير البريد في الـ Router extra.
  3. فحص إدخال كود OTP غير مكتمل ومنع الاستمرار، ثم إدخال الكود المكون من 6 أرقام في الـ `Pinput` واستدعاء `verifyOtpUseCase`.
  4. الانتقال لشاشة `ResetPasswordPage` مع التوكن والبريد.
  5. فحص التحقق من تطابق كلمتي المرور (Passwork mismatch validation).
  6. إدخال كلمة مرور جديدة متطابقة والضغط على Done وتنفيذ `resetPasswordUseCase` بنجاح.

### ج. [signup_flow_integration_test.dart](file:///h:/Grad%20Project/watad/test/integration/signup_flow_integration_test.dart) (1 اختبار شامل)
- **رحلة إنشاء الحساب بـ 4 خطوات (4-Step Multi-Step Stepper Journey)**:
  1. **الخطوة 1 (`SignUpRolePage`)**: التأكد من أن الـ Stepper على الخطوة 1، واختيار دور (Engineer) والضغط على Continue.
  2. **الخطوة 2 (`SignUpPersonalInfoPage`)**: التأكد من تقدم الـ Stepper للخطوة 2، وفحص رسائل الخطأ للحقول الفارغة، ثم إدخال الاسم والبريد ورقم الهاتف والضغط على Continue.
  3. **الخطوة 3 (`SignUpPasswordPage`)**: التأكد من تقدم الـ Stepper للخطوة 3، وإدخال كلمة المرور وتأكيدها، واستدعاء `registerUseCase` بجميع البيانات مجمعة بنجاح.
  4. **الخطوة 4 (`SignUpEmailConfirmationPage`)**: التأكد من بلوغ الـ Stepper للخطوة 4، وظهور عنوان `Email Confirmation:` و `SpamFolderHintWidget`، وإدخال كود التفعيل المكون من 6 أرقام في `Pinput` وإتمام التفعيل والانتقال إلى شاشة `Home Screen`.

### د. [app_e2e_test.dart](file:///h:/Grad%20Project/watad/integration_test/app_e2e_test.dart)
- نقطة الدخول الرسمية لـ `integration_test` بحزمة `IntegrationTestWidgetsFlutterBinding` لتمكين تشغيل اختبارات E2E على الأجهزة الحقيقية والـ Emulators.

---

## 2. اختبارات الـ Unit Tests (`test/unit/`) - (28 اختباراً)
- **`app_validators_test.dart`** (15 اختباراً): فحص `validateEmail`, `validatePassword`, `validateConfirmPassword`, `validateName`, `validatePhone`.
- **`auth_models_test.dart`** (9 اختبارات): فحص تسلسل الموديلات (`LoginRequestModel`, `RegisterRequestModel`, إلخ) واستخراج الـ `token` والـ `resetToken` بمرونة.
- **`auth_cubit_test.dart`** (4 اختبارات): فحص حالات الـ Cubit مع `bloc_test` و `mocktail`.

---

## 3. اختبارات الـ Widget Tests (`test/widget/`) - (9 اختبارات)
- **`custom_horizontal_stepper_test.dart`** (2 اختبارات): فحص الخطوات الأربعة والخطوط الموصلة.
- **`remember_me_confirmation_dialog_test.dart`** (4 اختبارات): فحص دايالوج تذكرني الإنجليزي وأزراره الثلاثة.
- **`app_elevated_button_test.dart`** (3 اختبارات): فحص الزرار وحالات التحميل `isLoading`.

---

## نتائج التشغيل (Final Verification Results)

1. **تشغيل الـ Integration Tests**:
   ```bash
   flutter test test/integration/
   ```
   **النتيجة**: `00:07 +7: All tests passed!`

2. **تشغيل شبكة الاختبارات كاملة (Unit + Widget + Integration)**:
   ```bash
   flutter test test/unit/ test/widget/ test/integration/
   ```
   **النتيجة**: `00:09 +44: All tests passed!`

3. **فحص الجودة والـ Linter (`flutter analyze`)**:
   ```bash
   flutter analyze --no-pub
   ```
   **النتيجة**: `No issues found! (ran in 3.7s)`
