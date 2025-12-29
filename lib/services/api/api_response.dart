class ApiResponse<T> {
  final int statusCode;
  final T? data;
  final String message;
  final bool success;

  ApiResponse({
    required this.statusCode,
    this.data,
    String? message,
  })  : success = statusCode >= 200 && statusCode < 300,
        message = message ?? _defaultMessage(statusCode);

  static String _defaultMessage(int code) {
    switch (code) {
      case 400:
        return "Bad Request";
      case 401:
        return "Unauthorized";
      case 403:
        return "Forbidden";
      case 404:
        return "Not Found";
      case 405:
        return "Method Not Allowed";
      case 500:
        return "Internal Server Error";
      default:
        return "Something went wrong";
    }
  }
}
