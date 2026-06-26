import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sokrio_user/core/network/network_info.dart';
import 'package:sokrio_user/data/datasources/user_local_data_source.dart';
import 'package:sokrio_user/data/datasources/user_remote_data_source.dart';
import 'package:sokrio_user/data/repositories/user_repository_impl.dart';
import 'package:sokrio_user/domain/repositories/user_repository.dart';
import 'package:sokrio_user/domain/usecases/get_users.dart';
import 'package:sokrio_user/presentation/providers/user_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'x-api-key': 'free_user_3FdkgBKPLlZVRRyBrRPbq5k0JjM',
      },
    ),
  );
  
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
  sl.registerLazySingleton<Dio>(() => dio);
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetUsers(sl()));

  sl.registerFactory(
    () => UserProvider(getUsers: sl()),
  );
}
