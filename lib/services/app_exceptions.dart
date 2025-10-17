/// Base Exception class
class AppException implements Exception {
  final String message;
  final String? prefix;

  AppException([this.message = "", this.prefix]);

  @override
  String toString() {
    return "${prefix ?? "Error"}: $message";
  }
}

/// Internet / Network Exception
class InternetException extends AppException {
  InternetException([String message = "No Internet connection"])
    : super(message, "InternetException");
}

/// Request Timeout Exception
class RequestTimeOut extends AppException {
  RequestTimeOut([String message = "Request timed out"])
    : super(message, "RequestTimeOut");
}

/// Bad Request 400
class BadRequestException extends AppException {
  BadRequestException([String message = "Bad Request"])
    : super(message, "BadRequestException");
}

/// Unauthorized 401 / 403
class UnauthorisedException extends AppException {
  UnauthorisedException([String message = "Unauthorized"])
    : super(message, "UnauthorisedException");
}

/// Not Found 404
class NotFoundException extends AppException {
  NotFoundException([String message = "Resource Not Found"])
    : super(message, "NotFoundException");
}

/// Server / Fetch Data Exception (500+)
class FetchDataException extends AppException {
  FetchDataException([String message = "Error During Communication"])
    : super(message, "FetchDataException");
}
