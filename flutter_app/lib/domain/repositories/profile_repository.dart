abstract interface class ProfileRepository {
  Future<void> updatePhotoUrl({
    required String userId,
    required String photoUrl,
  });
}
