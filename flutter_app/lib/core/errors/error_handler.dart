import 'package:dio/dio.dart';

import 'exceptions.dart';
import 'failures.dart';

class ErrorHandler {
  ErrorHandler._();

  static Failure fromException(Object error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return const NetworkFailure();
      }

      return const ServerFailure();
    }

    if (error is CacheException) {
      return const CacheFailure();
    }

    if (error is AppFirebaseException) {
      return AuthFailure(error.code);
    }

    if (error is ServerException) {
      return const ServerFailure();
    }

    return const UnknownFailure();
  }
}
