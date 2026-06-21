import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../core/constants/app_route_names.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/screens/biometric_unlock_screen.dart';
import '../features/auth/presentation/screens/change_password_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/otp_verification_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Scolair',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: AppRouteNames.splash,
          routes: {
            AppRouteNames.splash: (_) => const SplashScreen(),
            AppRouteNames.onboarding: (_) => const OnboardingScreen(),
            AppRouteNames.home: (_) => const HomeScreen(),
            AppRouteNames.login: (_) => const LoginScreen(),
            AppRouteNames.register: (_) => const RegisterScreen(),
            AppRouteNames.otpVerification: (_) => const OtpVerificationScreen(),
            AppRouteNames.forgotPassword: (_) => const ForgotPasswordScreen(),
            AppRouteNames.resetPassword: (_) => const ResetPasswordScreen(),
            AppRouteNames.changePassword: (_) => const ChangePasswordScreen(),
            AppRouteNames.biometricUnlock: (_) => const BiometricUnlockScreen(),
          },
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
