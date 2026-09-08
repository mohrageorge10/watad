class EndPoints {
  static const String baseUrl =
      "http://watad-api.runasp.net/api/";
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
  // =================== Projects ===================
  static const String contractorProjects = "Projects/contractor-projects";

  // =================== Bids ===================
  static const String contractorBids = "Bids/contractor-bids";

  // =================== Contractor ===================
  static const String contractorProfile = "Contractor/profile";
  static const String contractorPortfolio = "Contractor/portfolio";
}

class ApiQueryParams {
  static const String pageNumber = "pageNumber";
  static const String pageSize = "pageSize";
  static const String status = "status";
}

class ApiKey {
  // ================ Headers ================
  static const String authorization = "Authorization";
  static String bearer(String token) => "Bearer $token";

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
  static const String userId = "userId";
  static const String role = "role";
  // token
  static const String expirationDate = "expirationDate";
  // refreshToken
  static const String refreshTokenExpiration = "refreshTokenExpiration";

  // ===================== Confirm email =================
  // email
  // otp

  // ===================== Resend confirmation otp =================
  // email

  // ===================== Login =================
  // email
  // password

  // ================ OTP ===================
  static const String otp = "otp";

  // ================ Google Login ===================
  static const String idToken = "idToken";
  // userType

  // ================ Facebook Login ===================
  static const String accessToken = "accessToken";
  // userType

  // ================ Refresh Token ===================
  static const String refreshToken = "refreshToken";
  // access token

  // ================ Revoke Token & Logout ===================
  // refreshToken 

  // ================ Forget Password ===================
  // email

  // ================ Verify OTP ===================
  // email
  // otp

  // ================ Reset Password ===================
  static const String resetToken = "resetToken";
  static const String newPassword = "newPassword";
  // email

  // ================ Verify Current Password ===================
  static const String currentPassword = "currentPassword";

  // ================ Confirm New Password ===================
  static const String otpCode = "otpCode";
  static const String confirmNewPassword = "confirmNewPassword";
  // newPassword
}
