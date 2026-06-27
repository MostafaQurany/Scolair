import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/change_password_usecase.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/org_login_usecase.dart';
import '../../features/auth/domain/usecases/refresh_token_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/send_otp_usecase.dart';
import '../../features/auth/domain/usecases/verify_otp_usecase.dart';
import '../../features/auth/presentation/cubit/biometric/biometric_cubit.dart';
import '../../features/auth/presentation/cubit/change_password/change_password_cubit.dart';
import '../../features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import '../../features/auth/presentation/cubit/login/login_cubit.dart';
import '../../features/auth/presentation/cubit/otp/otp_cubit.dart';
import '../../features/auth/presentation/cubit/register/register_cubit.dart';
import '../../features/auth/presentation/cubit/phone_login/phone_login_cubit.dart';
import '../../features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import '../../features/home/data/datasources/local/home_local_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_summary_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../network/api_client.dart';
import '../network/dio_factory.dart';
import '../storage/app_secure_storage.dart';
import '../storage/app_shared_preferences.dart';
import '../../features/courses/data/datasources/remote/courses_remote_datasource.dart';
import '../../features/courses/data/repositories/courses_repository_impl.dart';
import '../../features/courses/domain/repositories/courses_repository.dart';
import '../../features/courses/domain/usecases/courses_usecases.dart';
import '../../features/courses/presentation/cubit/courses_cubit.dart';
import '../../features/courses/presentation/cubit/course_details_cubit.dart';
import '../../features/courses/presentation/cubit/lesson_details_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  if (getIt.isRegistered<SharedPreferences>()) {
    return;
  }

  getIt
    // Storage
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton<AppSharedPreferences>(
      () => AppSharedPreferences(getIt()),
    )
    ..registerLazySingleton<AppSecureStorage>(AppSecureStorage.new)
    // Network
    ..registerLazySingleton<Dio>(() => DioFactory.create(getIt()))
    ..registerLazySingleton<ApiClient>(() => ApiClient(getIt()))
    // Home feature
    ..registerLazySingleton<HomeLocalDataSource>(HomeLocalDataSource.new)
    ..registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(getIt()))
    ..registerLazySingleton<GetHomeSummaryUseCase>(
      () => GetHomeSummaryUseCase(getIt()),
    )
    ..registerFactory<HomeCubit>(() => HomeCubit(getIt()))
    // Auth — data
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()),
    )
    // Auth — use cases
    ..registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()))
    ..registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(getIt()))
    ..registerLazySingleton<GoogleLoginUseCase>(
      () => GoogleLoginUseCase(getIt()),
    )
    ..registerLazySingleton<RefreshTokenUseCase>(
      () => RefreshTokenUseCase(getIt()),
    )
    ..registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(getIt()))
    ..registerLazySingleton<ForgotPasswordSendOtpUseCase>(
      () => ForgotPasswordSendOtpUseCase(getIt()),
    )
    ..registerLazySingleton<ForgotPasswordVerifyOtpUseCase>(
      () => ForgotPasswordVerifyOtpUseCase(getIt()),
    )
    ..registerLazySingleton<ForgotPasswordResetUseCase>(
      () => ForgotPasswordResetUseCase(getIt()),
    )
    ..registerLazySingleton<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(getIt()),
    )
    // Auth — cubits
    ..registerFactory<LoginCubit>(() => LoginCubit(getIt(), getIt()))
    ..registerFactory<RegisterCubit>(() => RegisterCubit(getIt()))
    ..registerFactory<OtpCubit>(() => OtpCubit(getIt()))
    ..registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(getIt()))
    ..registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(getIt()))
    ..registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit(getIt()))
    ..registerFactory<PhoneLoginCubit>(PhoneLoginCubit.new)
    ..registerFactory<BiometricCubit>(BiometricCubit.new)
    // Splash & Onboarding
    ..registerFactory<SplashCubit>(() => SplashCubit(getIt(), getIt(), getIt()))
    ..registerFactory<OnboardingCubit>(() => OnboardingCubit(getIt()))
    // Courses Feature
    ..registerLazySingleton<CoursesRemoteDataSource>(
      () => CoursesRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<CoursesRepository>(
      () => CoursesRepositoryImpl(getIt()),
    )
    // Use Cases
    ..registerLazySingleton<ListCoursesUseCase>(() => ListCoursesUseCase(getIt()))
    ..registerLazySingleton<GetCourseUseCase>(() => GetCourseUseCase(getIt()))
    ..registerLazySingleton<CreateCourseUseCase>(() => CreateCourseUseCase(getIt()))
    ..registerLazySingleton<UpdateCourseUseCase>(() => UpdateCourseUseCase(getIt()))
    ..registerLazySingleton<DeleteCourseUseCase>(() => DeleteCourseUseCase(getIt()))
    ..registerLazySingleton<GetChaptersUseCase>(() => GetChaptersUseCase(getIt()))
    ..registerLazySingleton<GetChapterUseCase>(() => GetChapterUseCase(getIt()))
    ..registerLazySingleton<CreateChapterUseCase>(() => CreateChapterUseCase(getIt()))
    ..registerLazySingleton<UpdateChapterUseCase>(() => UpdateChapterUseCase(getIt()))
    ..registerLazySingleton<DeleteChapterUseCase>(() => DeleteChapterUseCase(getIt()))
    ..registerLazySingleton<GetLessonsUseCase>(() => GetLessonsUseCase(getIt()))
    ..registerLazySingleton<GetLessonUseCase>(() => GetLessonUseCase(getIt()))
    ..registerLazySingleton<CreateLessonUseCase>(() => CreateLessonUseCase(getIt()))
    ..registerLazySingleton<UploadFileUseCase>(() => UploadFileUseCase(getIt()))
    ..registerLazySingleton<UpdateLessonUseCase>(() => UpdateLessonUseCase(getIt()))
    ..registerLazySingleton<DeleteLessonUseCase>(() => DeleteLessonUseCase(getIt()))
    ..registerLazySingleton<GetMyCoursesUseCase>(() => GetMyCoursesUseCase(getIt()))
    // Cubits
    ..registerFactory<CoursesCubit>(() => CoursesCubit(getIt(), getIt()))
    ..registerFactory<CourseDetailsCubit>(() => CourseDetailsCubit(getIt(), getIt(), getIt()))
    ..registerFactory<LessonDetailsCubit>(() => LessonDetailsCubit(getIt()));
}
