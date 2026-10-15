import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:streetbite/data/datasources/auth/auth_remote_data_source.dart';
import 'package:streetbite/data/datasources/auth/auth_remote_data_source_impl.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'core/network/dio_client.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // Singleton: one shared Dio client.
  if (!sl.isRegistered<Dio>()) {
    sl.registerLazySingleton<Dio>(DioClient.create);
  }

  // Reuse the Firebase Authentication SDK instance.
  if (!sl.isRegistered<FirebaseAuth>()) {
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  }

  // Reuse the Firestore SDK instance.
  if (!sl.isRegistered<FirebaseFirestore>()) {
    sl.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
  }

  if (!sl.isRegistered<AuthRepository>()) {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
    );
  }
}
