import '../../../core/errors/result.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  const GetCurrentUserUseCase(this.repository);

  Future<Result<UserEntity?>> call() {
    return repository.getCurrentUser();
  }
}
