class RestError {
  String message;
  int? statusCode;

  RestError({
    required this.message,
    this.statusCode,
  });
}
