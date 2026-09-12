class AppRoutes {
  // ============ Common & Gateways ============
  static const String splash = '/';
  static const String home = '/home';
  static const String onBoarding = '/on-boarding';
  static const String welcome = '/welcome';
  // ============ Auth Feature ============
  static const String authLogin = '/login';
  static const String authRoleSelection = '/role-selection';
  static const String authSignUp = '/sign-up';
  static const String authSignUpPersonalInfo = '/sign-up-personal-info';
  static const String authSignUpPassword = '/sign-up-password';
  static const String authSignUpConfirmation = '/sign-up-confirmation';
  static const String authForgetPassword = '/forget-password';
  static const String authOtp = '/otp';
  static const String authResetPassword = '/reset-password';

  // ============ Change Password Feature ============
  static const String changePassword = '/change-password';
  static const String changePasswordOtp = '/change-password-otp';
  static const String newPassword = '/new-password';

  // ============ Owner Feature ============
  static const String ownerDashboard = '/project-dashboard';
  static const String ownerCreateProject = '/create-project';
  static const String ownerFinancialSummary = '/financial-summary';
  static const String ownerProgressSiteUpdates = '/progress-site-updates';
  static const String ownerChangeOrders = '/change-orders';
  static const String ownerFeasibilityCalculator = '/feasibility-calculator';
  static const String ownerFeasibilityReport = '/feasibility-report';
  static const String ownerBidDetails = '/owner-bid-details';
  static const String ownerBidResult = '/bid-result';
  static const String ownerCreateContractForm = '/create-contract-form';
  static const String ownerMilestonesForm = '/milestones-form';
  static const String ownerContractDetails = '/owner-contract-details';
  
  // From HEAD (Owner change orders details)
  static const String allChangeOrders = '/all-change-orders';
  static const String changeOrderDetails = '/change-order-details';
  static const String confirmAcceptChangeOrder = '/confirm-accept-change-order';
  static const String confirmRejectChangeOrder = '/confirm-reject-change-order';
  static const String changeOrderAccepted = '/change-order-accepted';
  static const String createChangeOrder = '/create-change-order';
  static const String changeOrderSubmitted = '/change-order-submitted';

  static const String futurePlan = '/future-plan';
  static const String copilot = '/copilot';

  // ============ Contractor Feature ============
  static const String contractorProfile = '/contractor-profile';
  static const String contractorEditProfile = '/edit-profile';
  static const String contractorPortfolioProjects = '/portfolio-projects';
  static const String contractorMyProjects = '/my-projects';
  static const String contractorAddPortfolioProject = '/add-portfolio-project';
  static const String contractorPortfolioProjectDetails = '/portfolio-project-details';
  static const String contractorMarketplace = '/marketplace';
  static const String contractorMarketplaceProjectDetails = '/marketplace-project-details';
  static const String contractorSubmitBid = '/submit-bid';
  static const String contractorBids = '/contractor-bids';
  static const String contractorMyBids = '/my-bids';
  static const String contractorBidDetails = '/bid-details';
  static const String contractorEditBid = '/edit-bid';
  static const String contractorContractDetails = '/contract-details';
  static const String contractorContractPreview = '/contract-preview';

  // ============ Aliases (Backward Compatibility) ============
  static const String loginScreen = authLogin;
  static const String roleSelection = authRoleSelection;
  static const String signUpScreen = authSignUp;
  static const String signUpPersonalInfo = authSignUpPersonalInfo;
  static const String signUpPassword = authSignUpPassword;
  static const String signUpConfirmation = authSignUpConfirmation;
  static const String forgetPassScreen = authForgetPassword;
  static const String otpScreen = authOtp;
  static const String resetPasswordScreen = authResetPassword;

  static const String projectDashboard = ownerDashboard;
  static const String createProject = ownerCreateProject;
  static const String financialSummary = ownerFinancialSummary;
  static const String progressSiteUpdates = ownerProgressSiteUpdates;
  static const String changeOrders = ownerChangeOrders;
  static const String feasibilityCalculator = ownerFeasibilityCalculator;
  static const String feasibilityReport = ownerFeasibilityReport;
  static const String bidResult = ownerBidResult;
  static const String createContractForm = ownerCreateContractForm;
  static const String milestonesForm = ownerMilestonesForm;

  static const String editProfile = contractorEditProfile;
  static const String portfolioProjects = contractorPortfolioProjects;
  static const String myProjects = contractorMyProjects;
  static const String addPortfolioProject = contractorAddPortfolioProject;
  static const String portfolioProjectDetails = contractorPortfolioProjectDetails;
  static const String marketplace = contractorMarketplace;
  static const String marketplaceProjectDetails = contractorMarketplaceProjectDetails;
  static const String submitBid = contractorSubmitBid;
  static const String myBids = contractorMyBids;
  static const String bidDetails = contractorBidDetails;
  static const String editBid = contractorEditBid;
  static const String contractDetails = contractorContractDetails;
  static const String contractPreview = contractorContractPreview;
}


