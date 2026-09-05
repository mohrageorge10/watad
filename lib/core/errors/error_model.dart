class ErrorModel {
  final int? status;
  final String errorMessage;

  ErrorModel({this.status, required this.errorMessage});

  factory ErrorModel.fromJson(dynamic jsonData) {
    if (jsonData is Map) {
      return ErrorModel(
        errorMessage: jsonData["message"] ??
            jsonData["Message"] ??
            jsonData["errorMessage"] ??
            jsonData["error"] ??
            jsonData["detail"] ??
            "An unexpected error occurred",
        status: jsonData["status"] is int
            ? jsonData["status"]
            : int.tryParse(jsonData["status"]?.toString() ?? ''),
      );
    } else if (jsonData is String) {
      return ErrorModel(errorMessage: jsonData);
    } else {
      return ErrorModel(errorMessage: "An unexpected error occurred");
    }
  }
}
