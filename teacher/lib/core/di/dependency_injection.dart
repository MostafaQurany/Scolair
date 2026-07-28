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
import '../../features/home/data/datasources/local/teacher_home_local_datasource.dart';
import '../../features/home/data/repositories/teacher_home_repository_impl.dart';
import '../../features/home/domain/repositories/teacher_home_repository.dart';
import '../../features/home/domain/usecases/get_teacher_home_usecase.dart';
import '../../features/home/domain/usecases/get_wall_posts_usecase.dart';
import '../../features/home/domain/usecases/toggle_wall_post_like_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../navigation/navigation_service.dart';
import '../network/api_client.dart';
import '../network/dio_factory.dart';
import '../storage/app_secure_storage.dart';
import '../storage/app_shared_preferences.dart';
import '../theme/cubit/theme_cubit.dart';
import '../localization/cubit/locale_cubit.dart';
import '../repositories/upload_repository.dart';
import '../usecases/upload_file_usecase.dart';
import '../../features/courses/data/datasources/remote/courses_remote_datasource.dart';
import '../../features/courses/data/repositories/courses_repository_impl.dart';
import '../../features/courses/domain/repositories/courses_repository.dart';
import '../../features/courses/domain/usecases/courses_usecases.dart';
import '../../features/courses/presentation/cubit/courses_cubit.dart';
import '../../features/courses/presentation/cubit/course_details_cubit.dart';
import '../../features/courses/presentation/cubit/lesson_details_cubit.dart';
import '../../features/courses/presentation/cubit/chapter_lessons_cubit.dart';
import '../../features/courses/presentation/cubit/course_form_cubit.dart';
import '../../features/courses/presentation/cubit/course_students_cubit.dart';
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
import '../../features/homework/presentation/cubit/details/homework_details_cubit.dart';
import '../../features/homework/presentation/cubit/submissions/homework_submissions_cubit.dart';
import '../../features/homework/presentation/cubit/grading/homework_grading_cubit.dart';
import '../../features/profile_settings/data/datasources/remote/profile_settings_remote_datasource.dart';
import '../../features/profile_settings/data/repositories/profile_settings_repository_impl.dart';
import '../../features/profile_settings/domain/repositories/profile_settings_repository.dart';
import '../../features/profile_settings/domain/usecases/profile_usecases.dart';
import '../../features/profile_settings/presentation/cubit/authenticated_user_cubit.dart';
import '../../features/profile_settings/presentation/cubit/notification_preferences_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  if (getIt.isRegistered<SharedPreferences>()) {
    return;
  }

  getIt
    // Navigation
    ..registerLazySingleton<NavigationService>(NavigationService.new)
    // Storage
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton<AppSharedPreferences>(
      () => AppSharedPreferences(getIt()),
    )
    ..registerLazySingleton<AppSecureStorage>(AppSecureStorage.new)
    ..registerLazySingleton<ThemeCubit>(() => ThemeCubit(getIt()))
    ..registerLazySingleton<LocaleCubit>(() => LocaleCubit(getIt()))
    // Network
    ..registerLazySingleton<Dio>(() => DioFactory.create(getIt(), getIt()))
    ..registerLazySingleton<ApiClient>(() => ApiClient(getIt()))
    // Home feature
    ..registerLazySingleton<TeacherHomeLocalDataSource>(
      TeacherHomeLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<TeacherHomeRepository>(
      () => TeacherHomeRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<GetTeacherHomeUseCase>(
      () => GetTeacherHomeUseCase(getIt()),
    )
    ..registerLazySingleton<GetWallPostsUseCase>(
      () => GetWallPostsUseCase(getIt()),
    )
    ..registerLazySingleton<ToggleWallPostLikeUseCase>(
      () => ToggleWallPostLikeUseCase(getIt()),
    )
    ..registerFactory<TeacherHomeCubit>(
      () => TeacherHomeCubit(getIt(), getIt(), getIt()),
    )
    // Auth — data
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt()),
    )
    // Repositories
    ..registerLazySingleton<UploadRepository>(
      () => UploadRepositoryImpl(getIt()),
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
    ..registerLazySingleton<GetSharedCoursesUseCase>(
      () => GetSharedCoursesUseCase(getIt()),
    )
    ..registerLazySingleton<GetStudentsUseCase>(
      () => GetStudentsUseCase(getIt()),
    )
    ..registerLazySingleton<AddStudentUseCase>(() => AddStudentUseCase(getIt()))
    ..registerLazySingleton<RemoveStudentUseCase>(
      () => RemoveStudentUseCase(getIt()),
    )
    ..registerLazySingleton<GetInstructorsUseCase>(
      () => GetInstructorsUseCase(getIt()),
    )
    ..registerLazySingleton<AddInstructorUseCase>(
      () => AddInstructorUseCase(getIt()),
    )
    ..registerLazySingleton<RemoveInstructorUseCase>(
      () => RemoveInstructorUseCase(getIt()),
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
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactory<CourseStudentsCubit>(
      () => CourseStudentsCubit(getIt(), getIt(), getIt()),
    )
    ..registerFactory<LessonDetailsCubit>(
      () => LessonDetailsCubit(getIt(), getIt(), getIt()),
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
      () => QuizDetailsCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
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
      () => question_presentation.QuestionFormCubit(getIt(), getIt(), getIt()),
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
    )
    ..registerLazySingleton<GetHomeworkDetailsUseCase>(
      () => GetHomeworkDetailsUseCase(getIt()),
    )
    ..registerLazySingleton<CreateHomeworkRemoteUseCase>(
      () => CreateHomeworkRemoteUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateHomeworkRemoteUseCase>(
      () => UpdateHomeworkRemoteUseCase(getIt()),
    )
    ..registerLazySingleton<AddHomeworkQuestionUseCase>(
      () => AddHomeworkQuestionUseCase(getIt()),
    )
    ..registerLazySingleton<RemoveHomeworkQuestionUseCase>(
      () => RemoveHomeworkQuestionUseCase(getIt()),
    )
    ..registerLazySingleton<GetHomeworkSubmissionsUseCase>(
      () => GetHomeworkSubmissionsUseCase(getIt()),
    )
    ..registerLazySingleton<GetSubmissionDetailsUseCase>(
      () => GetSubmissionDetailsUseCase(getIt()),
    )
    ..registerLazySingleton<DownloadAnswerFileUseCase>(
      () => DownloadAnswerFileUseCase(getIt()),
    )
    ..registerLazySingleton<GradeSubmissionUseCase>(
      () => GradeSubmissionUseCase(getIt()),
    )
    ..registerFactory<HomeworkDetailsCubit>(
      () => HomeworkDetailsCubit(
        getDetailsUseCase: getIt(),
        updateRemoteUseCase: getIt(),
        deleteUseCase: getIt(),
        addQuestionUseCase: getIt(),
        removeQuestionUseCase: getIt(),
        getSubmissionsUseCase: getIt(),
        uploadFileUseCase: getIt(),
      ),
    )
    ..registerFactory<HomeworkSubmissionsCubit>(
      () => HomeworkSubmissionsCubit(getIt()),
    )
    ..registerFactory<HomeworkGradingCubit>(
      () => HomeworkGradingCubit(
        getDetailsUseCase: getIt(),
        gradeUseCase: getIt(),
        downloadUseCase: getIt(),
      ),
    )
    // Profile Settings Feature
    ..registerLazySingleton<ProfileSettingsRemoteDataSource>(
      () => ProfileSettingsRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<ProfileSettingsRepository>(
      () => ProfileSettingsRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<GetUserProfileUseCase>(
      () => GetUserProfileUseCase(getIt()),
    )
    ..registerLazySingleton<EditUserProfileUseCase>(
      () => EditUserProfileUseCase(getIt()),
    )
    ..registerLazySingleton<UploadProfileImageUseCase>(
      () => UploadProfileImageUseCase(getIt()),
    )
    ..registerLazySingleton<AuthenticatedUserCubit>(
      () => AuthenticatedUserCubit(
        getUserProfileUseCase: getIt(),
        editUserProfileUseCase: getIt(),
        uploadProfileImageUseCase: getIt(),
      ),
    )
    ..registerLazySingleton<NotificationPreferencesCubit>(
      () => NotificationPreferencesCubit(getIt()),
    );
}
