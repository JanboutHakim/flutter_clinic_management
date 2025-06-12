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

import 'package:doclib/features/auth/data/datasources/auth_patient_remote_data_source.dart';
import 'package:doclib/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';
import 'package:doclib/features/auth/domain/usecases/login_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/signup_usecase.dart';
import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> initAuthFuture() async {
  // 1. Register low-level dependencies first
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  // 2. Register data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSoureceImpl(client: getIt<http.Client>()),
  );

  // 3. Register repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSourece: getIt<AuthRemoteDataSource>(),
    ),
  );

  // 4. Register use cases
  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(authRepository: getIt<AuthRepository>()),
  );

  // 5. Register BLoC (assuming it takes use cases as parameters)
  getIt.registerFactory<AuthBlocBloc>(
    () => AuthBlocBloc(
      loginUsecase: getIt<LoginUsecase>(),
      signUpUseCase: getIt<SignUpUseCase>(),
    ),
  );
}
