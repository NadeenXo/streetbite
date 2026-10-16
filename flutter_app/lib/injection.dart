import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:streetbite/data/datasources/auth/auth_remote_data_source.dart';
import 'package:streetbite/data/datasources/auth/auth_remote_data_source_impl.dart';
import 'package:streetbite/data/datasources/meals/meal_local_data_source.dart';
import 'package:streetbite/data/datasources/meals/meal_local_data_source_impl.dart';
import 'package:streetbite/data/datasources/meals/meal_remote_data_source.dart';
import 'package:streetbite/data/datasources/meals/meal_remote_data_source_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/meal_data_source_factory.dart';
import 'data/repositories/meal_repository_impl.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/meal_repository.dart';
import 'domain/usecases/auth/get_current_user_usecase.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'domain/usecases/auth/logout_usecase.dart';
import 'domain/usecases/auth/observe_auth_state_usecase.dart';
import 'domain/usecases/auth/signup_usecase.dart';
import 'core/network/dio_client.dart';
import 'presentation/blocs/auth/auth_cubit.dart';
import 'presentation/blocs/cart/cart_bloc.dart';
import 'presentation/blocs/meals/meal_bloc.dart';
import 'domain/usecases/meals/get_meals_usecase.dart';

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

  if (!sl.isRegistered<SharedPreferences>()) {
    final preferences = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(preferences);
  }

  if (!sl.isRegistered<MealRemoteDataSource>()) {
    sl.registerLazySingleton<MealRemoteDataSource>(
      () => MealRemoteDataSourceImpl(dio: sl<Dio>()),
    );
  }

  if (!sl.isRegistered<MealLocalDataSource>()) {
    sl.registerLazySingleton<MealLocalDataSource>(
      () => MealLocalDataSourceImpl(preferences: sl<SharedPreferences>()),
    );
  }

  if (!sl.isRegistered<MealDataSourceFactory>()) {
    sl.registerLazySingleton<MealDataSourceFactory>(
      () => MealDataSourceFactory(
        remote: sl<MealRemoteDataSource>(),
        local: sl<MealLocalDataSource>(),
      ),
    );
  }

  if (!sl.isRegistered<MealRepository>()) {
    sl.registerLazySingleton<MealRepository>(
      () => MealRepositoryImpl(factory: sl<MealDataSourceFactory>()),
    );
  }

  if (!sl.isRegistered<GetMealsUseCase>()) {
    sl.registerLazySingleton<GetMealsUseCase>(
      () => GetMealsUseCase(sl<MealRepository>()),
    );
  }

  // Factory registration:
  // Each HomeScreen provider receives a fresh MealBloc.
  // BlocProvider is responsible for closing the instance.
  if (!sl.isRegistered<MealBloc>()) {
    sl.registerFactory<MealBloc>(
      () => MealBloc(getMealsUseCase: sl<GetMealsUseCase>()),
    );
  }

  if (!sl.isRegistered<CartBloc>()) {
    sl.registerFactory<CartBloc>(CartBloc.new);
  }

  if (!sl.isRegistered<AuthRemoteDataSource>()) {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseAuth: sl<FirebaseAuth>(),
        firestore: sl<FirebaseFirestore>(),
      ),
    );
  }

  if (!sl.isRegistered<AuthRepository>()) {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
    );
  }

  if (!sl.isRegistered<SignupUseCase>()) {
    sl.registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<LoginUseCase>()) {
    sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<LogoutUseCase>()) {
    sl.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<GetCurrentUserUseCase>()) {
    sl.registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<ObserveAuthStateUseCase>()) {
    sl.registerLazySingleton<ObserveAuthStateUseCase>(
      () => ObserveAuthStateUseCase(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<AuthCubit>()) {
    sl.registerFactory<AuthCubit>(
      () => AuthCubit(
        loginUseCase: sl<LoginUseCase>(),
        signupUseCase: sl<SignupUseCase>(),
        logoutUseCase: sl<LogoutUseCase>(),
        getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
        observeAuthStateUseCase: sl<ObserveAuthStateUseCase>(),
      ),
    );
  }
}
