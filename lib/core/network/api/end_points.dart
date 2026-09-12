class EndPoints {
  static const String baseUrl =
      "https://watad-c5c6hkgmcxe5dzeg.uaenorth-01.azurewebsites.net/api/";
  // Backup URL: "http://watad-api.runasp.net/api/"

  // ================= Central Dashboard =================
  static String timelineOverview(String projectId) =>
      "Owner/centraldashboard/$projectId/timeline-overview";
  static String financialOverview(String projectId) =>
      "Owner/centraldashboard/$projectId/financial-overview";
  static String progressBargraph(String projectId) =>
      "Owner/centraldashboard/$projectId/progress-bargraph";
  static String siteLogsArchive(String projectId) =>
      "contractor/site-logs/project/$projectId/archive";

  // =================== Auth ===================
  static const String signUp = "Auth/register";
  static const String confirmEmail = "Auth/confirm-email";
  static const String resendConfirmOtp = "Auth/resend-confirmation-otp";
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
  static const String confirmChangePassword = "Auth/change-password/confirm";

  // =================== Owner Feature & Dashboards ===================
  static const String ownerProfile = "Owner/profile";
  static const String mainDashboardSummary = "Owner/maindashboard-summary";
  static const String homeOverview = "Owner/home-overview";
  static const String currentProjectOverview = "Owner/current-project-overview";
  static String centralProgressBargraph(String projectId) =>
      "Owner/centraldashboard/$projectId/progress-bargraph";
  static String centralTimelineOverview(String projectId) =>
      "Owner/centraldashboard/$projectId/timeline-overview";
  static String centralFinancialOverview(String projectId) =>
      "Owner/centraldashboard/$projectId/financial-overview";
  static String ownerProgressOverview(String projectId) =>
      "Owner/progress-overview?projectId=$projectId";
  static String ownerMilestoneDetails(String milestoneId) =>
      "Owner/milestone-details/$milestoneId";
  static String contractorPublicProfile(String contractorUserId) =>
      "Owner/contractor/$contractorUserId/public-profile";

  // =================== Projects ===================
  static const String projects = "Projects";
  static const String ownerProjects = "Projects";
  static const String contractorProjects = "Projects/contractor-projects";
  static const String contractorRecommendedProjects =
      "Projects/Contractor-recommended-projects";
  static String contractorRecommendedProjectDetails(String id) =>
      "Projects/Contractor-recommended-project/$id";
  static String projectDetails(String id) => "Projects/$id";
  static String publishProject(String id) => "Projects/$id/publish";
  static String recommendedContractors(String projectId) =>
      "Projects/$projectId/recommended-contractors";
  static const String marketplaceProjects = "Projects/marketplace";
  static String marketplaceProjectDetails(String id) =>
      "Projects/marketplace/$id";

  // =================== Feasibility ===================
  static const String calculateFeasibility = "Feasibility/calculate";
  static const String saveFeasibility = "Feasibility/save";
  static const String feasibilityReports = "Feasibility/reports";
  static String feasibilityReportDetails(String id) => "Feasibility/reports/$id";

  // =================== Bids & Marketplace ===================
  static const String submitBid = "Bids/submit-bid";
  static const String contractorBids = "Bids/contractor-bids";
  static const String myBids = "Bids/contractor-bids";
  static const String bids = "Bids";
  static String cancelBid(String id) => "Bids/cancel-bid/$id";
  static String acceptedBidContract(String projectId) =>
      "Bids/accepted/$projectId";
  static String projectBids(String projectId) => "Bids/$projectId/project-bids";
  static String bidDetails(String bidId) => "Bids/$bidId";
  static String acceptBid(String bidId) => "Bids/$bidId/accept";
  static String rejectBid(String bidId) => "Bids/$bidId/reject";

  // =================== Contracts ===================
  static const String createContract = "Contracts";
  static const String contracts = "Contracts";
  static String contractDetails(String id) => "Contracts/$id";
  static String generateContractPdf(String projectId, String contractId) =>
      "Contracts/$contractId/generate-pdf";
  static String signContract(String contractId) => "Contracts/$contractId/sign";

  // =================== Contractor & Portfolio ===================
  static const String contractorProfile = "Contractor/profile";
  static const String contractorPortfolio = "Contractor/portfolio";
  static String portfolioProject(String projectId) =>
      "Contractor/portfolio/$projectId";
  static const String addPortfolioProject = "Contractor/Add-portfolioproject";
  static String updatePortfolioProject(String projectId) =>
      "Contractor/$projectId/update-portfolioproject";
  static String contractorProjectDashboard(String projectId) =>
      "Contractor/projects/$projectId/dashboard";
  static String projectDashboard(String projectId) =>
      "Contractor/projects/$projectId/dashboard";

  // =================== Change Orders ===================
  static const String changeOrders = "ChangeOrders";
  static String changeOrderDetails(String id) => "ChangeOrders/$id";
  static String decideChangeOrder(String id) => "ChangeOrders/$id/decide";
  static String estimateChangeOrder(String id) => "ChangeOrders/$id/estimate";
  static String pendingChangeOrders(String projectId) =>
      "ChangeOrders/project/$projectId/pending";
  static String changeOrdersHistory(String projectId) =>
      "ChangeOrders/project/$projectId/history";
  static String pendingEstimationChangeOrders(String projectId) =>
      "ChangeOrders/project/$projectId/pending-estimation";

  // =================== Milestones & Inspections ===================
  static String projectMilestones(String projectId) =>
      "milestones/project/$projectId";
  static String milestoneContractorDetails(String milestoneId) =>
      "milestones/$milestoneId/contractor-details";
  static String milestoneDetails(String milestoneId) =>
      "milestones/$milestoneId";
  static String extendMilestoneDeadline(String milestoneId) =>
      "milestones/$milestoneId/extend-deadline";
  static String reviewMilestone(String milestoneId) =>
      "milestones/$milestoneId/review";
  static String approveMilestonePayment(String milestoneId) =>
      "milestones/$milestoneId/approve-payment";
  static String rejectMilestone(String milestoneId) =>
      "milestones/$milestoneId/reject";
  static String requestMilestoneInspection(String milestoneId) =>
      "milestones/$milestoneId/request-inspection";
  static String requestInspection(String milestoneId) =>
      "milestones/$milestoneId/request-inspection";

  static String milestoneInspectionDetails(String inspectionId) =>
      "milestone-inspections/$inspectionId";
  static String projectSiteInspections(String projectId) =>
      "milestone-inspections/centraldashboard/$projectId/site-inspections";

  // =================== Daily Site Logs ===================
  static const String siteLogs = "contractor/site-logs";
  static String milestoneLogs(String milestoneId) =>
      "contractor/site-logs/milestone/$milestoneId";
  static String projectSiteLogsArchive(String projectId) =>
      "contractor/site-logs/project/$projectId/archive";
  static String siteLogDetails(String projectId, String siteLogId) =>
      "contractor/site-logs/project/$projectId/logs/$siteLogId";

  // =================== Construction Copilot (AI) ===================
  static String copilotSessions(String projectId) =>
      "projects/$projectId/copilot/sessions";
  static String copilotSessionMessages(String projectId, String sessionId) =>
      "projects/$projectId/copilot/sessions/$sessionId/messages";
  static String copilotAsk(String projectId) =>
      "projects/$projectId/copilot/ask";

  // =================== Notifications ===================
  static const String notifications = "Notifications";
  static const String unreadNotificationsCount = "Notifications/unread-count";
  static String markNotificationAsRead(String id) => "Notifications/$id/read";
  static const String markAllNotificationsAsRead = "Notifications/read-all";

  // =================== Payments ===================
  static const String myPayments = "Payments/my-payments";
  static String paymentDetails(String id) => "Payments/$id";
  static String paymentReceiptPdf(String id) => "Payments/$id/receipt-pdf";

  // =================== Reviews ===================
  static const String reviews = "Reviews";
  static const String myReviews = "Reviews/my-reviews";
  static String reviewDetails(String id) => "Reviews/$id";
  static String contractorReviews(String contractorId) =>
      "Reviews/contractor/$contractorId";
}

class ApiQueryParams {
  static const String pageNumber = "pageNumber";
  static const String pageSize = "pageSize";
  static const String status = "status";
  static const String statusUpper = "Status";
  static const String search = "Search";
  static const String searchTerm = "SearchTerm";
  static const String governorate = "Governorate";
  static const String city = "City";
  static const String minBudget = "MinBudget";
  static const String maxBudget = "MaxBudget";
  static const String sortBy = "sortBy";
  static const String maxCost = "maxCost";
  static const String maxDurationDays = "maxDurationDays";
  static const String milestoneId = "MilestoneId";
  static const String aiStatus = "AiStatus";
  static const String startDate = "StartDate";
  static const String endDate = "EndDate";
  static const String category = "Category";
  static const String type = "Type";
  static const String take = "take";
  static const String projectId = "projectId";
}

class ApiKey {
  // ================ Headers ================
  static const String authorization = "Authorization";
  static String bearer(String token) => "Bearer $token";

  // ================ General Response Keys =============
  static const String message = "message";
  static const String isSuccess = "isSuccess";
  static const String statusCode = "statusCode";
  static const String data = "data";

  // ================ Auth: Register & Profile =============
  static const String fullName = "fullName";
  static const String email = "email";
  static const String password = "password";
  static const String confirmPassword = "confirmPassword";
  static const String phoneNumber = "phoneNumber";
  static const String userType = "userType";
  static const String userId = "userId";
  static const String role = "role";
  static const String expirationDate = "expirationDate";
  static const String refreshTokenExpiration = "refreshTokenExpiration";

  // ================ Auth: Tokens & OTP ===================
  static const String otp = "otp";
  static const String otpCode = "otpCode";
  static const String idToken = "idToken";
  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";
  static const String resetToken = "resetToken";
  static const String newPassword = "newPassword";
  static const String confirmNewPassword = "confirmNewPassword";
  static const String currentPassword = "currentPassword";

  // ================ Projects ============================
  static const String title = "title";
  static const String landArea = "landArea";
  static const String floorsCount = "floorsCount";
  static const String governorate = "governorate";
  static const String city = "city";
  static const String latitude = "latitude";
  static const String longitude = "longitude";
  static const String finishingLevel = "finishingLevel";
  static const String estimatedBudget = "estimatedBudget";
  static const String expectedStartDate = "expectedStartDate";
  static const String expectedDurationMonths = "expectedDurationMonths";

  // ================ Bids ================================
  static const String projectId = "projectId";
  static const String proposedCost = "proposedCost";
  static const String proposedDurationDays = "proposedDurationDays";
  static const String technicalProposalUrl = "technicalProposalUrl";

  // ================ Contracts & Milestones =============
  static const String contractorId = "contractorId";
  static const String consultantId = "consultantId";
  static const String totalValue = "totalValue";
  static const String startDate = "startDate";
  static const String endDate = "endDate";
  static const String termsAndConditions = "termsAndConditions";
  static const String milestones = "milestones";
  static const String costPercentage = "costPercentage";
  static const String amount = "amount";
  static const String targetCompletionDate = "targetCompletionDate";
  static const String newTargetCompletionDate = "newTargetCompletionDate";
  static const String reason = "reason";
  static const String reasonCategory = "reasonCategory";
  static const String notes = "notes";
  static const String paymentTransactionRef = "paymentTransactionRef";

  // ================ Change Orders ======================
  static const String description = "description";
  static const String costImpact = "costImpact";
  static const String timeImpactDays = "timeImpactDays";
  static const String isApproved = "isApproved";
  static const String rejectionReason = "rejectionReason";

  // ================ Contractor Portfolio ==============
  static const String companyName = "companyName";
  static const String commercialRegister = "commercialRegister";
  static const String taxCard = "taxCard";
  static const String bio = "bio";
  static const String specialization = "specialization";
  static const String coveredGovernorates = "coveredGovernorates";
  static const String yearsOfExperience = "yearsOfExperience";
  static const String location = "location";
  static const String projectCost = "projectCost";
  static const String completionDate = "completionDate";
  static const String photos = "Photos";
  static const String newPhotos = "NewPhotos";
  static const String existingMediaUrls = "ExistingMediaUrls";

  // ================ Site Logs ==========================
  static const String milestoneId = "MilestoneId";
  static const String mediaFile = "MediaFile";
  static const String mediaType = "MediaType";
  static const String workersCount = "WorkersCount";
  static const String equipmentUsed = "EquipmentUsed";
  static const String workSummary = "WorkSummary";

  // ================ Feasibility ========================
  static const String feasibilityReportId = "feasibilityReportId";
  static const String newProjectTitle = "newProjectTitle";

  // ================ Reviews ============================
  static const String targetUserId = "targetUserId";
  static const String rating = "rating";
  static const String comment = "comment";

  // ================ Copilot (AI) =======================
  static const String copilotProjectId = "project_id";
  static const String dbContext = "db_context";
  static const String question = "question";
}
