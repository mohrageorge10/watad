class EndPoints {
  static const String baseUrl =
      "http://watad-api.runasp.net/api/";

  // ================= Home Feature =================
  static const String currentProjectOverview =
      "Owner/current-project-overview";
  static const String ownerProjects = "Projects";
  static const String ownerProfile = "Owner/profile";

  // ================= Feasibility Feature =================
  static const String calculateFeasibility = "Feasibility/calculate";
  static const String saveFeasibility = "Feasibility/save";

  // ================= Marketplace Feature =================
  static String recommendedContractors(String projectId) => "Projects/$projectId/recommended-contractors";
  static String projectBids(String projectId) => "Bids/$projectId/project-bids";
  static String bidDetails(String bidId) => "Bids/$bidId";
  static String acceptBid(String bidId) => "Bids/$bidId/accept";
  static String rejectBid(String bidId) => "Bids/$bidId/reject";

  // ================= Contracts Feature =================
  static const String createContract = "contracts";
  static String contractDetails(String id) => "contracts/$id";
  static String generateContractPdf(String projectId, String contractId) => 
      "contractor/projects/$projectId/contracts/$contractId/generate-pdf";

  // ================= Central Dashboard =================
  static String timelineOverview(String projectId) =>
      "Owner/centraldashboard/$projectId/timeline-overview";
  static String financialOverview(String projectId) =>
      "Owner/centraldashboard/$projectId/financial-overview";
  static String progressBargraph(String projectId) =>
      "Owner/centraldashboard/$projectId/progress-bargraph";
  static String siteLogsArchive(String projectId) =>
      "contractor/site-logs/project/$projectId/archive";
  static String changeOrdersHistory(String projectId) =>
      "ChangeOrders/project/$projectId/history";
  static String pendingChangeOrders(String projectId) =>
      "ChangeOrders/project/$projectId/pending";

  // ================= Alerts & Notifications =================
  static const String notifications = "Notifications";

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

