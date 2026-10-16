import '../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<UserModel> login({required String email, required String password});

  Future<void> logout();

  Future<UserModel?> getCurrentUser();

  Stream<String?> authStateChanges();

  Future<void> updatePhotoUrl({
    required String userId,
    required String photoUrl,
  });
}
