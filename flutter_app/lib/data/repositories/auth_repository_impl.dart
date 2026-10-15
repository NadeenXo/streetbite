import '../../core/errors/error_handler.dart';
import '../../core/errors/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<UserEntity>> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUp(
        fullName: fullName,
        email: email,
        password: password,
      );

      return Success(user);
    } catch (error) {
      return ErrorResult(ErrorHandler.fromException(error));
    }
  }

  @override
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );

      return Success(user);
    } catch (error) {
      return ErrorResult(ErrorHandler.fromException(error));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await remoteDataSource.logout();

      return const Success<void>(null);
    } catch (error) {
      return ErrorResult(ErrorHandler.fromException(error));
    }
  }

  @override
  Future<Result<UserEntity?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();

      return Success(user);
    } catch (error) {
      return ErrorResult(ErrorHandler.fromException(error));
    }
  }

  @override
  Stream<String?> authStateChanges() {
    return remoteDataSource.authStateChanges();
  }
}
