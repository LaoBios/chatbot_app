import 'dart:io';
import 'package:flutter_chatgpt_tutorial_yt/services/app_exceptions.dart';
import 'package:logger/logger.dart';


class BaseService {
  /// To handle all exceptions
  /// If there is a new exception, must add here
   final Logger log = Logger();
  Future<AppException> handleException(e) async {
    if (e is TypeError) {
      return FetchDataException('Type error while parsing response');
    } else if (e is FormatException) {
      return FetchDataException('Format error while parsing response');
    } else if (e is AppException) {
      return e;
    } else if (e is SocketException) {
      return FetchDataException('No Internet Connection');
    }
    return FetchDataException(e.toString());
  }
}
