import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure();
}

class NetworkFailure extends Failure {
  const NetworkFailure();
}

class CacheFailure extends Failure {
  const CacheFailure();
}

class AuthFailure extends Failure {
  final String code;

  const AuthFailure(this.code);

  @override
  List<Object?> get props => [code];
}

class UnknownFailure extends Failure {
  const UnknownFailure();
}