import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/send_otp_usecase.dart';
import '../../features/auth/domain/usecases/verify_otp_usecase.dart';
import '../../features/auth/presentation/cubit/biometric/biometric_cubit.dart';
import '../../features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import '../../features/auth/presentation/cubit/login/login_cubit.dart';
import '../../features/auth/presentation/cubit/otp/otp_cubit.dart';
import '../../features/auth/presentation/cubit/phone_login/phone_login_cubit.dart';
import '../../features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import '../../features/home/data/datasources/local/home_local_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_summary_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../network/api_client.dart';
import '../network/dio_factory.dart';
import '../storage/app_secure_storage.dart';
import '../storage/app_shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  if (getIt.isRegistered<SharedPreferences>()) {
    return;
  }

  getIt
    // Infrastructure
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton<AppSharedPreferences>(
      () => AppSharedPreferences(getIt()),
    )
    ..registerLazySingleton<AppSecureStorage>(AppSecureStorage.new)
    ..registerLazySingleton<Dio>(() => DioFactory.create(getIt()))
    ..registerLazySingleton<ApiClient>(() => ApiClient(getIt()))
    // Auth
    ..registerLazySingleton<AuthRemoteDataSource>(AuthRemoteDataSource.new)
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<SendOtpUseCase>(() => SendOtpUseCase(getIt()))
    ..registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()))
    ..registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(getIt()))
    ..registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(getIt()),
    )
    ..registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(getIt()),
    )
    ..registerFactory<PhoneLoginCubit>(() => PhoneLoginCubit(getIt()))
    ..registerFactory<LoginCubit>(() => LoginCubit(getIt()))
    ..registerFactory<OtpCubit>(() => OtpCubit(getIt()))
    ..registerFactory<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(getIt()),
    )
    ..registerFactory<ResetPasswordCubit>(
      () => ResetPasswordCubit(getIt()),
    )
    ..registerFactory<BiometricCubit>(BiometricCubit.new)
    // Home
    ..registerLazySingleton<HomeLocalDataSource>(HomeLocalDataSource.new)
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<GetHomeSummaryUseCase>(
      () => GetHomeSummaryUseCase(getIt()),
    )
    ..registerFactory<HomeCubit>(() => HomeCubit(getIt()));
}
