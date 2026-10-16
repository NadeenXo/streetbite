import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:streetbite/core/errors/failures.dart';
import 'package:streetbite/core/errors/result.dart';
import 'package:streetbite/domain/entities/user_entity.dart';
import 'package:streetbite/domain/repositories/auth_repository.dart';
import 'package:streetbite/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:streetbite/domain/usecases/auth/login_usecase.dart';
import 'package:streetbite/domain/usecases/auth/logout_usecase.dart';
import 'package:streetbite/domain/usecases/auth/observe_auth_state_usecase.dart';
import 'package:streetbite/domain/usecases/auth/signup_usecase.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/auth/auth_state.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;
  late StreamController<String?> authEvents;

  const user = UserEntity(
    id: 'uid-123',
    fullName: 'Test User',
    email: 'test@example.com',
  );

  setUp(() {
    repository = MockAuthRepository();
    authEvents = StreamController<String?>.broadcast();
    when(
      () => repository.authStateChanges(),
    ).thenAnswer((_) => authEvents.stream);
  });

  tearDown(() => authEvents.close());

  AuthCubit buildCubit() => AuthCubit(
    loginUseCase: LoginUseCase(repository),
    signupUseCase: SignupUseCase(repository),
    logoutUseCase: LogoutUseCase(repository),
    getCurrentUserUseCase: GetCurrentUserUseCase(repository),
    observeAuthStateUseCase: ObserveAuthStateUseCase(repository),
  );

  blocTest<AuthCubit, AuthState>(
    'login: loading then authenticated',
    build: () {
      when(
        () => repository.login(email: 'test@example.com', password: '123456'),
      ).thenAnswer((_) async => const Success<UserEntity>(user));
      return buildCubit();
    },
    act: (cubit) => cubit.login(email: 'test@example.com', password: '123456'),
    expect: () => [
      const AuthLoading(AuthAction.login),
      const AuthAuthenticated(user),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'login failure is represented as AuthError',
    build: () {
      when(
        () => repository.login(email: 'test@example.com', password: 'wrong'),
      ).thenAnswer(
        (_) async =>
            const ErrorResult<UserEntity>(AuthFailure('invalid-credential')),
      );
      return buildCubit();
    },
    act: (cubit) => cubit.login(email: 'test@example.com', password: 'wrong'),
    expect: () => [
      const AuthLoading(AuthAction.login),
      const AuthError(AuthFailure('invalid-credential'), AuthAction.login),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'signup: loading then authenticated',
    build: () {
      when(
        () => repository.signUp(
          fullName: 'Test User',
          email: 'test@example.com',
          password: '123456',
        ),
      ).thenAnswer((_) async => const Success<UserEntity>(user));
      return buildCubit();
    },
    act: (cubit) => cubit.signUp(
      fullName: 'Test User',
      email: 'test@example.com',
      password: '123456',
    ),
    expect: () => [
      const AuthLoading(AuthAction.signUp),
      const AuthAuthenticated(user),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'logout: loading then unauthenticated',
    build: () {
      when(
        () => repository.logout(),
      ).thenAnswer((_) async => const Success<void>(null));
      return buildCubit();
    },
    act: (cubit) => cubit.logout(),
    expect: () => [
      const AuthLoading(AuthAction.logout),
      const AuthUnauthenticated(),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'restores a persisted session using the auth stream',
    build: () {
      when(
        () => repository.getCurrentUser(),
      ).thenAnswer((_) async => const Success<UserEntity?>(user));
      return buildCubit();
    },
    act: (cubit) async {
      cubit.start();
      authEvents.add(user.id);
      await Future<void>.delayed(const Duration(milliseconds: 10));
    },
    expect: () => [
      const AuthLoading(AuthAction.restore),
      const AuthAuthenticated(user),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'restores an unauthenticated session',
    build: buildCubit,
    act: (cubit) async {
      cubit.start();
      authEvents.add(null);
      await Future<void>.delayed(const Duration(milliseconds: 10));
    },
    expect: () => [
      const AuthLoading(AuthAction.restore),
      const AuthUnauthenticated(),
    ],
  );
}
