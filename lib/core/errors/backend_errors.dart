class InvalidApiKeyException implements Exception {
  final String message =
      'No API Key was specified or an invalid API Key was specified';
}

class RequestReachedException implements Exception {
  final String message =
      'The maximum allowed API amount of monthly API requests has been reached.';
}

class InvalidBaseCurrency implements Exception {
  final String message = 'An invalid base currency has been entered.';
}

class TokenExpired implements Exception {
  final String message = 'Vencio el tiempo de la sesion';
}

class NoContentResponse implements Exception {
  // final String message = 'No body returned for response'; //204 No Content

  const NoContentResponse([this.message]);

  final String? message;

  @override
  String toString() {
    String result = '';
    if (message is String) return '$message';
    return result;
  }
}

class ResponseMsg implements Exception {
  const ResponseMsg([this.message]);

  final String? message;

  @override
  String toString() {
    String result = '';
    if (message is String) return '$message';
    return result;
  }
}

class ValidationError implements Exception {
  // final String message = 'No body returned for response'; //204 No Content

  const ValidationError([this.message]);

  final String? message;

  @override
  String toString() {
    String result = '';
    if (message is String) return '$message';
    return result;
  }
}
