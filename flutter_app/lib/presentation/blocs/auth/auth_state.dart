import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/user_entity.dart';

enum AuthAction { login, signUp, logout, restore }

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  final AuthAction action;
  const AuthLoading(this.action);
  @override
  List<Object?> get props => [action];
}

final class AuthAuthenticated extends AuthState {
  final UserEntity user;
  const AuthAuthenticated(this.user);
  @override
  List<Object?> get props => [user];
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

final class AuthError extends AuthState {
  final Failure failure;
  final AuthAction action;
  const AuthError(this.failure, this.action);
  @override
  List<Object?> get props => [failure, action];
}
