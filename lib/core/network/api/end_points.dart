class EndPoints {
  static const String baseUrl =
      "https://watad-c5c6hkgmcxe5dzeg.uaenorth-01.azurewebsites.net/api/";
  // =================== Auth ===================
  static const String signUp = "Auth/register";
  static const String confirmEmail = "Auth/confirm-email";
  static const String resendConfirmOtp = "Auth/resend-confirm-otp";
  static const String login = "Auth/login";
  static const String googleLogin = "Auth/google-login";
  static const String facebookLogin = "Auth/facebook-login";
  static const String refreshToken = "Auth/refresh-token";
  static const String revokeToken = "Auth/revoke-token";
  static const String logout = "Auth/logout";
  static const String forgetPassword = "Auth/forget-password";
  static const String verifyOtp = "Auth/verify-otp";
  static const String resetPassword = "Auth/reset-password";
  static const String verifyCurrentPassword =
      "Auth/change-password/verify-current";
  static const String confirmNewPassword = "Auth/change-password/confirm";
}

class ApiKey {
  // ================ Response =============
  static const String message = "message";
  static const String isSuccess = "isSuccess";
  static const String statusCode = "statusCode";
  static const String data = "data";

  // ================ Register =============
  static const String fullName = "fullName";
  static const String email = "email";
  static const String password = "password";
  static const String confirmPassword = "confirmPassword";
  static const String phoneNumber = "phoneNumber";
  static const String userType = "userType";

  // ================ OTP ===================
  static const String otp = "otp";

  // ================ Google Login ===================
  static const String idToken = "idToken";

  // ================ Facebook Login ===================
  static const String accessToken = "accessToken";

  // ================ Refresh & Revoke Token ===================
  static const String refreshToken = "refreshToken";

  // ================ Reset Password ===================
  static const String resetToken = "resetToken";
  static const String newPassword = "newPassword";

  // ================ Verify Current Password ===================
  static const String currentPassword = "currentPassword";

  // ================ Confirm New Password ===================
  static const String otpCode = "otpCode";
  static const String confirmNewPassword = "confirmNewPassword";
}
