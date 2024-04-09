class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(message) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "");
}

class ForbiddenException extends AppException {
  ForbiddenException([message]) : super(message, "");
}

class InvalidInputException extends AppException {
  InvalidInputException([message]) : super(message, "");
}

class ServerException extends AppException {
  ServerException([message]) : super(message, "");
}

class NotFoundException extends AppException {
  NotFoundException([message]) : super(message, "");
}
