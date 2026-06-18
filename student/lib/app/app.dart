import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../core/constants/app_route_names.dart';
import '../core/di/dependency_injection.dart';
import '../core/storage/app_shared_preferences.dart';
import '../core/theme/app_theme.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/onboarding/presentation/screens/OnboardingScreen.dart';
import '../features/splash/presentation/cubit/splash_cubit.dart';
import '../features/splash/presentation/screens/SplashScreen.dart';
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
            AppRouteNames.splash: (_) => BlocProvider(
              create: (context) => SplashCubit(getIt<AppSharedPreferences>()),
              child: const SplashScreen(),
            ),
            AppRouteNames.onboarding: (context) => OnboardingScreen(
              preferences: getIt<AppSharedPreferences>(),
            ),
            AppRouteNames.home: (_) => const HomeScreen(),
          },
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
