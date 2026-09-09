class EndPoints {
  static const String baseUrl =
      "http://watad-api.runasp.net/api/";
      "https://watad-c5c6hkgmcxe5dzeg.uaenorth-01.azurewebsites.net/api/";

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
  // =================== Projects & Marketplace ===================
  static const String contractorProjects = "Projects/contractor-projects";
  static const String contractorRecommendedProjects =
      "Projects/Contractor-recommended-projects";
  static const String projects = "Projects";
  static const String marketplaceProjects = "Projects/marketplace";
  static String projectDetails(String id) => "Projects/$id";
  static String contractorRecommendedProjectDetails(String id) =>
      "Projects/Contractor-recommended-project/$id";
  static String marketplaceProjectDetails(String id) => "Projects/marketplace/$id";

  // =================== Bids ===================
  static const String submitBid = "Bids/submit-bid";
  static const String contractorBids = "Bids/contractor-bids";
  static const String myBids = "Bids/contractor-bids";
  static const String bids = "Bids";
  static String cancelBid(String id) => "Bids/cancel-bid/$id";
  static String bidDetails(String bidId) => "Bids/$bidId";
  static String acceptedBidContract(String projectId) =>
      "Bids/accepted/$projectId";

  // =================== Contractor & Portfolio ===================
  static const String contractorProfile = "Contractor/profile";
  static const String contractorPortfolio = "Contractor/portfolio";
  static String portfolioProject(String projectId) => "Contractor/portfolio/$projectId";

  // =================== Reviews ===================
  static const String myReviews = "Reviews/my-reviews";

  // =================== Project Dashboard, Milestones & Site Logs ===================
  static String projectDashboard(String projectId) =>
      "Contractor/projects/$projectId/dashboard";
  static const String siteLogs = "contractor/site-logs";
  static String milestoneLogs(String milestoneId) =>
      "contractor/site-logs/milestone/$milestoneId";
  static String milestoneDetails(String milestoneId) =>
      "milestones/$milestoneId";
  static String requestInspection(String milestoneId) =>
      "milestones/$milestoneId/request-inspection";

  // =================== Contracts ===================
  static String contractDetails(String contractId) => "Contracts/$contractId";
  static String signContract(String contractId) => "Contracts/$contractId/sign";
}

class ApiQueryParams {
  static const String pageNumber = "pageNumber";
  static const String pageSize = "pageSize";
  static const String status = "status";
  static const String search = "Search";
  static const String governorate = "Governorate";
  static const String minBudget = "MinBudget";
  static const String maxBudget = "MaxBudget";
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

