class ErrorModel {
  final int? status;
  final String errorMessage;

  ErrorModel({this.status, required this.errorMessage});

  factory ErrorModel.fromJson(dynamic jsonData) {
    if (jsonData is Map) {
      // 1. Check for ASP.NET Core ValidationProblemDetails 'errors'
      final rawErrors = jsonData['errors'] ?? jsonData['Errors'];
      if (rawErrors is Map) {
        final List<String> messages = [];
        for (final entry in rawErrors.entries) {
          if (entry.value is List) {
            messages.addAll((entry.value as List).map((e) => e.toString()));
          } else if (entry.value != null) {
            messages.add(entry.value.toString());
          }
        }
        if (messages.isNotEmpty) {
          return ErrorModel(
            errorMessage: messages.join(', '),
            status: _parseStatus(jsonData),
          );
        }
      } else if (rawErrors is List && rawErrors.isNotEmpty) {
        return ErrorModel(
          errorMessage: rawErrors.map((e) => e.toString()).join(', '),
          status: _parseStatus(jsonData),
        );
      }

      // 2. Standard message fields
      final String? message = jsonData["message"] ??
          jsonData["Message"] ??
          jsonData["errorMessage"] ??
          jsonData["error"] ??
          jsonData["detail"] ??
          jsonData["title"] ??
          jsonData["Title"];

      return ErrorModel(
        errorMessage: (message != null && message.trim().isNotEmpty)
            ? message.trim()
            : "An unexpected error occurred",
        status: _parseStatus(jsonData),
      );
    } else if (jsonData is String && jsonData.trim().isNotEmpty) {
      final trimmed = jsonData.trim();
      // Check if the response is an HTML page (e.g. Azure 403 Stopped Web App / Cloudflare / IIS error page)
      if (trimmed.contains('<!DOCTYPE') ||
          trimmed.contains('<html') ||
          trimmed.contains('<body') ||
          trimmed.contains('<div') ||
          trimmed.contains('<h1')) {
        if (trimmed.toLowerCase().contains('web app is stopped') ||
            trimmed.toLowerCase().contains('app is stopped') ||
            trimmed.toLowerCase().contains('site disabled')) {
          return ErrorModel(
            errorMessage:
                "The backend server is currently stopped on Azure. Please start the App Service in Azure Portal.",
            status: 403,
          );
        }
        return ErrorModel(
          errorMessage:
              "The server returned an HTML error page. Please try again later.",
        );
      }
      return ErrorModel(errorMessage: trimmed);
    } else {
      return ErrorModel(errorMessage: "An unexpected error occurred");
    }

  }

  static int? _parseStatus(Map json) {
    final rawStatus = json["status"] ?? json["statusCode"] ?? json["StatusCode"];
    if (rawStatus is int) return rawStatus;
    return int.tryParse(rawStatus?.toString() ?? '');
  }
}
