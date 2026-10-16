import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failures.dart';
import '../../../core/errors/result.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/auth/get_current_user_usecase.dart';
import '../../../domain/usecases/auth/login_usecase.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';
import '../../../domain/usecases/auth/observe_auth_state_usecase.dart';
import '../../../domain/usecases/auth/signup_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ObserveAuthStateUseCase observeAuthStateUseCase;

  StreamSubscription<String?>? _subscription;
  int _generation = 0;
  bool _busy = false;
  bool _observing = false;

  AuthCubit({
    required this.loginUseCase,
    required this.signupUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.observeAuthStateUseCase,
  }) : super(const AuthInitial());

  // The auth stream is the source of truth for restoring a Firebase session.
  // Ignore interim stream events during login/sign-up: Firebase can emit a UID
  // before the corresponding Firestore profile has been written.
  void start() {
    if (_observing || isClosed) return;
    _observing = true;
    emit(const AuthLoading(AuthAction.restore));
    _subscription = observeAuthStateUseCase().listen(
      (uid) {
        if (isClosed || _busy) return;
        if (uid == null) {
          _generation++;
          emit(const AuthUnauthenticated());
        } else {
          unawaited(restoreSession());
        }
      },
      onError: (Object _) {
        if (!isClosed && !_busy) {
          emit(const AuthError(UnknownFailure(), AuthAction.restore));
        }
      },
    );
  }

  Future<void> restoreSession() async {
    if (isClosed || _busy) return;
    final token = ++_generation;
    _busy = true;
    emit(const AuthLoading(AuthAction.restore));
    try {
      final result = await getCurrentUserUseCase();
      if (isClosed || token != _generation) return;
      switch (result) {
        case Success<UserEntity?>(:final data):
          emit(
            data == null
                ? const AuthUnauthenticated()
                : AuthAuthenticated(data),
          );
        case ErrorResult<UserEntity?>(:final failure):
          emit(AuthError(failure, AuthAction.restore));
      }
    } catch (_) {
      if (!isClosed && token == _generation) {
        emit(const AuthError(UnknownFailure(), AuthAction.restore));
      }
    } finally {
      _busy = false;
    }
  }

  Future<void> login({required String email, required String password}) async {
    if (isClosed || _busy) return;
    final token = ++_generation;
    _busy = true;
    emit(const AuthLoading(AuthAction.login));
    try {
      final result = await loginUseCase(email: email, password: password);
      if (isClosed || token != _generation) return;
      switch (result) {
        case Success<UserEntity>(:final data):
          emit(AuthAuthenticated(data));
        case ErrorResult<UserEntity>(:final failure):
          emit(AuthError(failure, AuthAction.login));
      }
    } catch (_) {
      if (!isClosed && token == _generation) {
        emit(const AuthError(UnknownFailure(), AuthAction.login));
      }
    } finally {
      _busy = false;
    }
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    if (isClosed || _busy) return;
    final token = ++_generation;
    _busy = true;
    emit(const AuthLoading(AuthAction.signUp));
    try {
      final result = await signupUseCase(
        fullName: fullName,
        email: email,
        password: password,
      );
      if (isClosed || token != _generation) return;
      switch (result) {
        case Success<UserEntity>(:final data):
          emit(AuthAuthenticated(data));
        case ErrorResult<UserEntity>(:final failure):
          emit(AuthError(failure, AuthAction.signUp));
      }
    } catch (_) {
      if (!isClosed && token == _generation) {
        emit(const AuthError(UnknownFailure(), AuthAction.signUp));
      }
    } finally {
      _busy = false;
    }
  }

  Future<void> logout() async {
    if (isClosed || _busy) return;
    final token = ++_generation;
    _busy = true;
    emit(const AuthLoading(AuthAction.logout));
    try {
      final result = await logoutUseCase();
      if (isClosed || token != _generation) return;
      switch (result) {
        case Success<void>():
          emit(const AuthUnauthenticated());
        case ErrorResult<void>(:final failure):
          emit(AuthError(failure, AuthAction.logout));
      }
    } catch (_) {
      if (!isClosed && token == _generation) {
        emit(const AuthError(UnknownFailure(), AuthAction.logout));
      }
    } finally {
      _busy = false;
    }
  }

  @override
  Future<void> close() async {
    ++_generation;
    await _subscription?.cancel();
    await super.close();
  }
}
