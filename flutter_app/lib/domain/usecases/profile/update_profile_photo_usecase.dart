import '../../repositories/profile_repository.dart';

class UpdateProfilePhotoUseCase {
  final ProfileRepository repository;

  UpdateProfilePhotoUseCase(this.repository);

  Future<void> call({required String userId, required String photoUrl}) {
    return repository.updatePhotoUrl(userId: userId, photoUrl: photoUrl);
  }
}
