import '../../domain/repositories/profile_repository.dart';
import '../datasources/auth/auth_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final AuthRemoteDataSource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  Future<void> updatePhotoUrl({
    required String userId,
    required String photoUrl,
  }) {
    return remote.updatePhotoUrl(userId: userId, photoUrl: photoUrl);
  }
}
