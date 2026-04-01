class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() => message;
}

class AuthException extends AppException {
  AuthException(super.message, {super.code});
}

class ServerException extends AppException {
  ServerException({String message = 'A server error occurred, please try again later.'})
      : super(message);
}

class NetworkException extends AppException {
  NetworkException({String message = 'No internet connection details.'})
      : super(message);
}
