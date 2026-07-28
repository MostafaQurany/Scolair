// add the unfouce even when navigation should be unfouce too
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../core/utils/unfocus_navigatio_observer.dart';

import '../core/constants/app_route_names.dart';
import '../core/di/dependency_injection.dart';
import '../core/navigation/navigation_service.dart';
import '../core/localization/cubit/locale_cubit.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/cubit/theme_cubit.dart';
import '../features/auth/presentation/screens/biometric_request_screen.dart';
import '../features/auth/presentation/screens/biometric_unlock_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/org_email_login_screen.dart';
import '../features/auth/presentation/screens/otp_verification_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/home/presentation/screens/home_layout.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/homework/domain/entities/homework_list_item.dart';
import '../features/homework/presentation/screens/homework_details_screen.dart';
import '../features/homework/presentation/screens/homework_form_screen.dart';
import '../features/homework/presentation/screens/homework_questions_slider_screen.dart';
import '../features/homework/presentation/screens/homework_questions_slider_screen_args.dart';
import '../features/homework/presentation/screens/homework_submission_detail_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/classes/presentation/screens/class_detail_screen.dart';
import '../features/classes/presentation/screens/classes_screen.dart';
import '../features/courses/data/models/courses_models.dart';
import '../features/courses/presentation/screens/course_details_screen.dart';
import '../features/courses/presentation/screens/course_form_screen.dart';
import '../features/courses/presentation/screens/course_students_screen.dart';
import '../features/courses/presentation/screens/courses_list_screen.dart';
import '../features/courses/presentation/screens/lesson_details_screen.dart';
import '../features/courses/presentation/screens/lesson_form_screen.dart';
import '../features/courses/presentation/screens/my_courses_screen.dart';
import '../features/courses/presentation/screens/pdf_viewer_screen.dart';
import '../features/homework/presentation/screens/homework_list_screen.dart';
import '../features/profile_settings/presentation/screens/account_information_screen.dart';
import '../features/auth/presentation/screens/change_password_screen.dart';
import '../features/profile_settings/presentation/screens/edit_profile_screen.dart';
import '../features/profile_settings/presentation/screens/help_support_screen.dart';
import '../features/profile_settings/presentation/screens/language_settings_screen.dart';
import '../features/profile_settings/presentation/screens/notification_preferences_screen.dart';
import '../features/profile_settings/presentation/screens/profile_settings_screen.dart';
import '../features/profile_settings/presentation/screens/security_settings_screen.dart';
import '../features/profile_settings/presentation/screens/theme_settings_screen.dart';
import '../features/profile_settings/presentation/screens/toolkit_whiteboard_screen.dart';
import '../features/question/presentation/screens/question_bank_screen.dart';
import '../features/question/presentation/screens/question_form_screen.dart';
import '../features/quiz/data/models/quiz_models.dart';
import '../features/quiz/presentation/cubit/quiz_details_cubit.dart';
import '../features/quiz/presentation/screens/quiz_details_screen.dart';
import '../features/quiz/presentation/screens/quiz_form_screen.dart';
import '../features/quiz/presentation/screens/quiz_questions_slider_screen.dart';
import '../features/quiz/presentation/screens/quiz_settings_screen.dart';
import '../features/quiz/presentation/screens/quizzes_list_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(360, 780),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          bloc: getIt<ThemeCubit>(),
          builder: (context, themeMode) => BlocBuilder<LocaleCubit, Locale>(
            bloc: getIt<LocaleCubit>(),
            builder: (context, locale) => MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: getIt<NavigationService>().navigatorKey,
              title: 'Scolair',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              locale: locale,
              initialRoute: AppRouteNames.splash,

              navigatorObservers: [UnfocusNavigationObserver()],

              onGenerateInitialRoutes: (_) => [
                MaterialPageRoute(
                  settings: const RouteSettings(name: AppRouteNames.splash),
                  builder: (_) => const SplashScreen(),
                ),
              ],
              routes: {
                AppRouteNames.splash: (_) => const SplashScreen(),
                AppRouteNames.onboarding: (_) => const OnboardingScreen(),
                AppRouteNames.home: (_) => const HomeScreen(),
                AppRouteNames.homeLayout: (_) => const HomeLayout(),
                AppRouteNames.login: (_) => const LoginScreen(),
                AppRouteNames.orgEmailLogin: (_) => const OrgEmailLoginScreen(),
                AppRouteNames.otpVerification: (_) =>
                    const OtpVerificationScreen(),
                AppRouteNames.forgotPassword: (_) =>
                    const ForgotPasswordScreen(),
                AppRouteNames.resetPassword: (_) => const ResetPasswordScreen(),
                AppRouteNames.biometricUnlock: (_) =>
                    const BiometricUnlockScreen(),
                AppRouteNames.biometricRequest: (_) =>
                    const BiometricRequestScreen(),
                AppRouteNames.myCourses: (_) => const MyCoursesScreen(),
                AppRouteNames.quizzesList: (_) => const QuizzesListScreen(),
                AppRouteNames.homeworkList: (_) => const HomeworkListScreen(),
                AppRouteNames.teacherProfile: (_) =>
                    const ProfileSettingsScreen(),
                AppRouteNames.profileSettings: (_) =>
                    const ProfileSettingsScreen(),
                AppRouteNames.editProfile: (_) => const EditProfileScreen(),
                AppRouteNames.accountInformation: (_) =>
                    const AccountInformationScreen(),
                AppRouteNames.languageSettings: (_) =>
                    const LanguageSettingsScreen(),
                AppRouteNames.themeSettings: (_) => const ThemeSettingsScreen(),
                AppRouteNames.notificationPreferences: (_) =>
                    const NotificationPreferencesScreen(),
                AppRouteNames.securitySettings: (_) =>
                    const SecuritySettingsScreen(),
                AppRouteNames.changePassword: (_) =>
                    const ChangePasswordScreen(),
                AppRouteNames.helpSupport: (_) => const HelpSupportScreen(),
                AppRouteNames.toolkitWhiteboard: (_) =>
                    const ToolkitWhiteboardScreen(),
              },
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case AppRouteNames.homeworkCreate:
                  case AppRouteNames.homeworkEdit:
                    return MaterialPageRoute(
                      builder: (_) => HomeworkFormScreen(
                        editingHomework:
                            settings.arguments as HomeworkListItem?,
                      ),
                    );
                  case AppRouteNames.homeworkDetails:
                    return MaterialPageRoute(
                      builder: (_) => HomeworkDetailsScreen(
                        homeworkName: settings.arguments as String,
                      ),
                    );
                  case AppRouteNames.homeworkQuestionsSlider:
                    final args =
                        settings.arguments as HomeworkQuestionsSliderScreenArgs;
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: args.cubit,
                        child: HomeworkQuestionsSliderScreen(
                          homework: args.homework,
                        ),
                      ),
                    );
                  case AppRouteNames.homeworkSubmissionDetails:
                    return MaterialPageRoute(
                      builder: (_) => HomeworkSubmissionDetailScreen(
                        submissionName: settings.arguments as String,
                      ),
                    );
                  case AppRouteNames.classDetail:
                    return MaterialPageRoute(
                      builder: (_) => ClassDetailScreen(
                        classCode: settings.arguments as String,
                      ),
                    );
                  case AppRouteNames.courseForm:
                    return MaterialPageRoute(
                      builder: (_) => CourseFormScreen(
                        editingCourse: settings.arguments as CourseModel?,
                      ),
                    );
                  case AppRouteNames.courseStudents:
                    final args = settings.arguments as CourseStudentsScreenArgs;
                    return MaterialPageRoute(
                      builder: (_) => CourseStudentsScreen(
                        courseName: args.courseName,
                        courseTitle: args.courseTitle,
                      ),
                    );
                  case AppRouteNames.courseDetails:
                    return MaterialPageRoute(
                      builder: (_) => CourseDetailsScreen(
                        courseName: settings.arguments as String,
                      ),
                    );
                  case AppRouteNames.lessonForm:
                    final args = settings.arguments as LessonFormScreenArgs;
                    return MaterialPageRoute(
                      builder: (_) => LessonFormScreen(
                        chapterName: args.chapterName,
                        editingLesson: args.editingLesson,
                      ),
                    );
                  case AppRouteNames.lessonDetails:
                    final args = settings.arguments as LessonDetailsScreenArgs;
                    return MaterialPageRoute(
                      builder: (_) => LessonDetailsScreen(
                        lessonName: args.lessonName,
                        chapterName: args.chapterName,
                      ),
                    );
                  case AppRouteNames.quizDetails:
                    return MaterialPageRoute(
                      builder: (_) => QuizDetailsScreen(
                        quizName: settings.arguments as String,
                      ),
                    );
                  case AppRouteNames.pdfViewer:
                    return MaterialPageRoute(
                      builder: (_) => PdfViewerScreen(
                        fileUrl: settings.arguments as String,
                      ),
                    );
                  case AppRouteNames.quizQuestionsSlider:
                    final args =
                        settings.arguments as QuizQuestionsSliderScreenArgs;
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: args.cubit,
                        child: QuizQuestionsSliderScreen(
                          quiz: args.quiz,
                          initialIndex: args.initialIndex,
                        ),
                      ),
                    );
                  case AppRouteNames.quizSettings:
                    final cubit = settings.arguments as QuizDetailsCubit;
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: cubit,
                        child: const QuizSettingsScreen(),
                      ),
                    );
                  case AppRouteNames.questionBank:
                    final args = settings.arguments as QuestionBankScreenArgs;
                    return MaterialPageRoute(
                      builder: (_) => QuestionBankScreen(
                        blockedTypes: args.blockedTypes,
                        blockedQuestionNames: args.blockedQuestionNames,
                        confirmLabel: args.confirmLabel,
                      ),
                    );
                  case AppRouteNames.questionForm:
                    return MaterialPageRoute(
                      builder: (_) => QuestionFormScreen(
                        editingQuestion: settings.arguments as QuestionModel?,
                      ),
                    );
                  case AppRouteNames.quizForm:
                    return MaterialPageRoute(
                      builder: (_) => QuizFormScreen(
                        editingQuiz: settings.arguments as QuizSummaryModel?,
                      ),
                    );
                  default:
                    return null;
                }
              },
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,

              builder: (context, child) {
                return GestureDetector(
                  onTap: () {
                    // Using FocusManager inside the global builder context to guarantee
                    // it hits the correct scope regardless of the current context state.
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: child!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
