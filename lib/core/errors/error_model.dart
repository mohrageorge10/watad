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
      return ErrorModel(errorMessage: jsonData.trim());
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
