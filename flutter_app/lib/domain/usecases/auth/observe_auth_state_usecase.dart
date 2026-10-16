import '../../repositories/auth_repository.dart';

class ObserveAuthStateUseCase {
  final AuthRepository repository;

  const ObserveAuthStateUseCase(this.repository);

  Stream<String?> call() {
    return repository.authStateChanges();
  }
}
