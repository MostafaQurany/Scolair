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
import '../../features/auth/presentation/cubit/biometric_request/biometric_request_cubit.dart';
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
import '../../features/courses/presentation/cubit/chapter_lessons_cubit.dart';
import '../../features/courses/presentation/cubit/course_form_cubit.dart';
import '../../features/courses/presentation/cubit/lesson_form_cubit.dart';
import '../../features/quiz/data/datasources/remote/quiz_remote_datasource.dart';
import '../../features/quiz/data/repositories/quiz_repository_impl.dart';
import '../../features/quiz/domain/repositories/quiz_repository.dart';
import '../../features/quiz/domain/usecases/quiz_usecases.dart';
import '../../features/quiz/presentation/cubit/quizzes_cubit.dart';
import '../../features/quiz/presentation/cubit/quiz_form_cubit.dart';
import '../../features/quiz/presentation/cubit/quiz_details_cubit.dart';
import '../../features/question/data/datasources/remote/question_remote_datasource.dart'
    as question_data;
import '../../features/question/data/repositories/question_repository_impl.dart'
    as question_data;
import '../../features/question/domain/repositories/question_repository.dart'
    as question_domain;
import '../../features/question/domain/usecases/question_usecases.dart'
    as question_domain;
import '../../features/question/presentation/cubit/question_form_cubit.dart'
    as question_presentation;
import '../../features/question/presentation/cubit/question_bank_cubit.dart'
    as question_presentation;
import '../../features/homework/data/datasources/local/homework_mock_datasource.dart';
import '../../features/homework/data/datasources/remote/homework_remote_datasource.dart';
import '../../features/homework/data/repositories/homework_repository_impl.dart';
import '../../features/homework/domain/repositories/homework_repository.dart';
import '../../features/homework/domain/usecases/homework_usecases.dart';
import '../../features/homework/presentation/cubit/homework_list_cubit.dart';
import '../../features/homework/presentation/cubit/homework_form_cubit.dart';

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
      () => AuthRepositoryImpl(getIt(), getIt(), getIt()),
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
    ..registerFactory<BiometricRequestCubit>(
      () => BiometricRequestCubit(getIt()),
    )
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
    ..registerLazySingleton<ListCoursesUseCase>(
      () => ListCoursesUseCase(getIt()),
    )
    ..registerLazySingleton<GetCourseUseCase>(() => GetCourseUseCase(getIt()))
    ..registerLazySingleton<CreateCourseUseCase>(
      () => CreateCourseUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateCourseUseCase>(
      () => UpdateCourseUseCase(getIt()),
    )
    ..registerLazySingleton<DeleteCourseUseCase>(
      () => DeleteCourseUseCase(getIt()),
    )
    ..registerLazySingleton<GetChaptersUseCase>(
      () => GetChaptersUseCase(getIt()),
    )
    ..registerLazySingleton<GetChapterUseCase>(() => GetChapterUseCase(getIt()))
    ..registerLazySingleton<CreateChapterUseCase>(
      () => CreateChapterUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateChapterUseCase>(
      () => UpdateChapterUseCase(getIt()),
    )
    ..registerLazySingleton<DeleteChapterUseCase>(
      () => DeleteChapterUseCase(getIt()),
    )
    ..registerLazySingleton<GetLessonsUseCase>(() => GetLessonsUseCase(getIt()))
    ..registerLazySingleton<GetLessonUseCase>(() => GetLessonUseCase(getIt()))
    ..registerLazySingleton<CreateLessonUseCase>(
      () => CreateLessonUseCase(getIt()),
    )
    ..registerLazySingleton<UploadFileUseCase>(() => UploadFileUseCase(getIt()))
    ..registerLazySingleton<UpdateLessonUseCase>(
      () => UpdateLessonUseCase(getIt()),
    )
    ..registerLazySingleton<DeleteLessonUseCase>(
      () => DeleteLessonUseCase(getIt()),
    )
    ..registerLazySingleton<GetMyCoursesUseCase>(
      () => GetMyCoursesUseCase(getIt()),
    )
    // Cubits
    ..registerFactory<CoursesCubit>(
      () => CoursesCubit(getIt(), getIt(), getIt()),
    )
    ..registerFactory<ChapterLessonsCubit>(() => ChapterLessonsCubit(getIt()))
    ..registerFactory<CourseDetailsCubit>(
      () => CourseDetailsCubit(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactory<LessonDetailsCubit>(
      () => LessonDetailsCubit(getIt(), getIt()),
    )
    ..registerFactory<CourseFormCubit>(
      () => CourseFormCubit(getIt(), getIt(), getIt()),
    )
    ..registerFactory<LessonFormCubit>(
      () => LessonFormCubit(getIt(), getIt(), getIt()),
    )
    // Quiz Feature
    ..registerLazySingleton<QuizRemoteDataSource>(
      () => QuizRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<QuizRepository>(() => QuizRepositoryImpl(getIt()))
    ..registerLazySingleton<ListQuizzesUseCase>(
      () => ListQuizzesUseCase(getIt()),
    )
    ..registerLazySingleton<GetQuizUseCase>(() => GetQuizUseCase(getIt()))
    ..registerLazySingleton<CreateQuizUseCase>(() => CreateQuizUseCase(getIt()))
    ..registerLazySingleton<UpdateQuizUseCase>(() => UpdateQuizUseCase(getIt()))
    ..registerLazySingleton<DeleteQuizUseCase>(() => DeleteQuizUseCase(getIt()))
    ..registerLazySingleton<AddQuestionToQuizUseCase>(
      () => AddQuestionToQuizUseCase(getIt()),
    )
    ..registerLazySingleton<RemoveQuestionFromQuizUseCase>(
      () => RemoveQuestionFromQuizUseCase(getIt()),
    )
    ..registerFactory<QuizzesCubit>(() => QuizzesCubit(getIt(), getIt()))
    ..registerFactory<QuizFormCubit>(() => QuizFormCubit(getIt(), getIt()))
    ..registerFactory<QuizDetailsCubit>(
      () => QuizDetailsCubit(getIt(), getIt(), getIt(), getIt()),
    )
    // Question Feature
    ..registerLazySingleton<question_data.QuestionRemoteDataSource>(
      () => question_data.QuestionRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<question_domain.QuestionRepository>(
      () => question_data.QuestionRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<question_domain.ListQuestionsUseCase>(
      () => question_domain.ListQuestionsUseCase(getIt()),
    )
    ..registerLazySingleton<question_domain.GetQuestionUseCase>(
      () => question_domain.GetQuestionUseCase(getIt()),
    )
    ..registerLazySingleton<question_domain.CreateQuestionUseCase>(
      () => question_domain.CreateQuestionUseCase(getIt()),
    )
    ..registerLazySingleton<question_domain.UpdateQuestionUseCase>(
      () => question_domain.UpdateQuestionUseCase(getIt()),
    )
    ..registerLazySingleton<question_domain.DeleteQuestionUseCase>(
      () => question_domain.DeleteQuestionUseCase(getIt()),
    )
    ..registerFactory<question_presentation.QuestionFormCubit>(
      () => question_presentation.QuestionFormCubit(getIt(), getIt()),
    )
    ..registerFactory<question_presentation.QuestionBankCubit>(
      () => question_presentation.QuestionBankCubit(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    // Homework Feature
    ..registerLazySingleton<HomeworkMockDataSource>(
      HomeworkMockDataSourceImpl.new,
    )
    ..registerLazySingleton<HomeworkRemoteDataSource>(
      () => HomeworkRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<HomeworkRepository>(
      () => HomeworkRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<ListHomeworkUseCase>(
      () => ListHomeworkUseCase(getIt()),
    )
    ..registerLazySingleton<ListHomeworkPageUseCase>(
      () => ListHomeworkPageUseCase(getIt()),
    )
    ..registerLazySingleton<CreateHomeworkUseCase>(
      () => CreateHomeworkUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateHomeworkUseCase>(
      () => UpdateHomeworkUseCase(getIt()),
    )
    ..registerLazySingleton<DeleteHomeworkUseCase>(
      () => DeleteHomeworkUseCase(getIt()),
    )
    ..registerLazySingleton<DuplicateHomeworkUseCase>(
      () => DuplicateHomeworkUseCase(getIt()),
    )
    ..registerFactory<HomeworkListCubit>(
      () => HomeworkListCubit(getIt(), getIt()),
    )
    ..registerFactory<HomeworkFormCubit>(
      () => HomeworkFormCubit(getIt(), getIt()),
    );
}
