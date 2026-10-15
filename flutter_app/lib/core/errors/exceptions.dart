class ServerException implements Exception {
  final String message;

  const ServerException([this.message = 'Server request failed']);
}

class CacheException implements Exception {
  final String message;

  const CacheException([this.message = 'Cached data unavailable']);
}

class AppFirebaseException implements Exception {
  final String code;

  const AppFirebaseException(this.code);
}
