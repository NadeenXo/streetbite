import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  if (!sl.isRegistered<Dio>()) {
    sl.registerLazySingleton<Dio>(
      DioClient.create,
    );
  }
}