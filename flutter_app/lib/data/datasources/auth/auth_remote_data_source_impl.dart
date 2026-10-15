import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/errors/exceptions.dart';
import '../../models/user_builder.dart';
import '../../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw const AppFirebaseException('user-not-created');
      }

      final user = UserBuilder()
          .setId(firebaseUser.uid)
          .setFullName(fullName.trim())
          .setEmail(firebaseUser.email ?? email.trim())
          .build();

      await firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toJson());

      return user;
    } on FirebaseAuthException catch (error) {
      throw AppFirebaseException(error.code);
    } on FirebaseException catch (error) {
      throw AppFirebaseException(error.code);
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw const AppFirebaseException('user-not-found');
      }

      final snapshot = await firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (!snapshot.exists || snapshot.data() == null) {
        throw const AppFirebaseException('profile-not-found');
      }

      return UserModel.fromJson(snapshot.data()!);
    } on FirebaseAuthException catch (error) {
      throw AppFirebaseException(error.code);
    } on FirebaseException catch (error) {
      throw AppFirebaseException(error.code);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (error) {
      throw AppFirebaseException(error.code);
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    try {
      final snapshot = await firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (!snapshot.exists || snapshot.data() == null) {
        throw const AppFirebaseException('profile-not-found');
      }

      return UserModel.fromJson(snapshot.data()!);
    } on FirebaseException catch (error) {
      throw AppFirebaseException(error.code);
    }
  }

  @override
  Stream<String?> authStateChanges() {
    return firebaseAuth.authStateChanges().map((user) => user?.uid);
  }
}
