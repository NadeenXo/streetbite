import '../../core/errors/result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Result<void>> logout();

  Future<Result<UserEntity?>> getCurrentUser();

  Stream<String?> authStateChanges();
}
