import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ishara/core/utils/api_service.dart';
import 'package:ishara/core/utils/local_storage_service.dart';
import 'package:ishara/features/auth/data/data_sources/auth_data_source.dart';
import 'package:ishara/features/auth/data/repos/auth_repo_impl.dart';
import 'package:ishara/features/auth/domain/repos/auth_repo.dart';
import 'package:ishara/features/camera/data/repos/translation_repo_impl.dart';
import 'package:ishara/features/camera/presentation/manager/camera_cubit.dart';
import 'package:ishara/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:ishara/features/home/data/repos/home_repo_impl.dart';
import 'package:ishara/features/home/domain/repo/home_repo.dart';
import 'package:ishara/features/home/presentation/manager/home_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService(sl()));
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl(), sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(sl()));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl(), sl()));
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSource(sl()));
  sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(sl()));
  sl.registerLazySingleton<TranslationRepoImpl>(() => TranslationRepoImpl(sl()));
  sl.registerLazySingleton<HomeCubit>(() => HomeCubit(sl()));
  sl.registerLazySingleton<CameraCubit>(() => CameraCubit(sl()));
}
