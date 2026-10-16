import '../../../core/errors/result.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  const SignupUseCase(this.repository);

  Future<Result<UserEntity>> call({
    required String fullName,
    required String email,
    required String password,
  }) {
    return repository.signUp(
      fullName: fullName.trim(),
      email: email.trim(),
      password: password,
    );
  }
}
