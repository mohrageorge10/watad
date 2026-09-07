class EndPoints {
  static const String baseUrl =
      "https://watad-c5c6hkgmcxe5dzeg.uaenorth-01.azurewebsites.net";

  // ================= Home Feature =================
  static const String currentProjectOverview =
      "/api/Owner/current-project-overview";
  static const String ownerProjects = "/api/Projects";
  static const String ownerProfile = "/api/Owner/profile";

  // ================= Feasibility Feature =================
  static const String calculateFeasibility = "/api/Feasibility/calculate";
  static const String saveFeasibility = "/api/Feasibility/save";
}

class ApiKey {
  static const String message = "message";
  static const String status = "status";
  static const String errorMessage = "errorMessage";
  static const String token = "token";
}

