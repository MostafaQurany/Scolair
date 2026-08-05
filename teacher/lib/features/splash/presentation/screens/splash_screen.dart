import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) => getIt<SplashCubit>()..start(),
      child: const _SplashView(),
    );
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) => BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        state.whenOrNull(
          navigate: (route) =>
              Navigator.pushNamedAndRemoveUntil(context, route, (_) => false),
        );
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.logo, width: 120.w),
              SizedBox(height: 20.h),
              SizedBox(
                width: 120.w,
                child: LinearProgressIndicator(
                  color: AppColors.primary,
                  backgroundColor: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
}
