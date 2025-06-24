// import 'package:doclib/features/auth/data/datasources/auth_patient_remote_data_source.dart';
// import 'package:doclib/features/auth/data/repositories/auth_repository_impl.dart';
// import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';
// import 'package:doclib/features/auth/domain/usecases/login_usecase.dart';
// import 'package:doclib/features/auth/domain/usecases/signup_usecase.dart';
// import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
// import 'package:get_it/get_it.dart';
// // import 'pacakge:http ';
// import 'package:http/http.dart' as http;

// final getIt = GetIt.instance;
// Future<void> initAuthFuture() async {
//   getIt.registerLazySingleton<http.Client>(() => http.Client());
//   getIt.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSoureceImpl(getIt()),
//   );
//   getIt.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(getIt()),
//   );
//   getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecase(getIt()));
//   getIt.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(getIt()));
//   getIt.registerLazySingleton<AuthBlocBloc>(
//     () => AuthBlocBloc(getIt(), getIt()),
//   );
// }

import 'package:doclib/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:doclib/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:doclib/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';
import 'package:doclib/features/auth/domain/usecases/cach_token_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/get_cached_token_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/get_cached_user.dart';
import 'package:doclib/features/auth/domain/usecases/login_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/signup_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:doclib/features/drugs/data/datasources/drug_remote_data_source.dart';
import 'package:doclib/features/drugs/data/repositories/drug_repo_impl.dart';
import 'package:doclib/features/drugs/domain/repositories/drug_repository.dart';
import 'package:doclib/features/drugs/domain/usecases/get_common_drugs.dart';
import 'package:doclib/features/drugs/presentation/bloc/drugs_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initAuthFuture() async {
  // 1. Register low-level dependencies first
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  final localBox = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => localBox);
  // 2. Register data sources
  getIt.registerLazySingleton<DrugRemoteDataSource>(
    () => DrugRemoteDataSourceImpl(getIt<http.Client>()),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSoureceImpl(client: getIt<http.Client>()),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(localBox),
  );

  // 3. Register repositories
  getIt.registerLazySingleton<DrugsRepository>(
    () => DrugRepoImpl(getIt<DrugRemoteDataSource>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSourece: getIt<AuthRemoteDataSource>(),
      authLocalDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  // 4. Register use cases
  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetCommonDrugsUseCase>(
    () => GetCommonDrugsUseCase(getIt<DrugsRepository>()),
  );
  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<CachTokenUsecase>(
    () => CachTokenUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetCachedTokenUsecase>(
    () => GetCachedTokenUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetCachedUserUseCase>(
    () => GetCachedUserUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<VerifyOtpUsecase>(
    () => VerifyOtpUsecase(getIt<AuthRepository>()),
  );

  // 5. Register BLoC (assuming it takes use cases as parameters)
  getIt.registerFactory<AuthBlocBloc>(
    () => AuthBlocBloc(
      verifyOtpUsecase: getIt<VerifyOtpUsecase>(),
      getCachedUserUseCase: getIt<GetCachedUserUseCase>(),
      cachTokenUsecase: getIt<CachTokenUsecase>(),
      getCachedTokenUsecase: getIt<GetCachedTokenUsecase>(),
      loginUsecase: getIt<LoginUsecase>(),
      signUpUseCase: getIt<SignUpUseCase>(),
    ),
  );
  getIt.registerFactory<DrugsBloc>(
    () => DrugsBloc(getCommonDrugsUseCase: getIt<GetCommonDrugsUseCase>()),
  );
}
