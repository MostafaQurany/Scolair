import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnboardingCubit>(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        state.whenOrNull(
          navigate: (route) => Navigator.pushReplacementNamed(context, route),
        );
      },
      builder: (context, state) {
        final pageIndex = state.whenOrNull(initial: (i) => i) ?? 0;
        final cubit = context.read<OnboardingCubit>();
        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    onPageChanged: cubit.changePage,
                    itemBuilder: (_, index) => _OnboardingPage(index),
                  ),
                ),
                _DotIndicator(currentPage: pageIndex, count: 3),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (pageIndex < 2)
                        TextButton(
                          onPressed: cubit.finish,
                          child: Text(
                            context.l10n.onboardingSkipButton,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.lightTextSecondary,
                            ),
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.darkTextPrimary,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 14.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                          if (pageIndex < 2) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            cubit.finish();
                          }
                        },
                        child: Text(
                          pageIndex < 2
                              ? context.l10n.onboardingNextButton
                              : context.l10n.onboardingDoneButton,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage(this.pageIndex);

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    final (title, body, icon) = switch (pageIndex) {
      0 => (
          context.l10n.onboardingPage1Title,
          context.l10n.onboardingPage1Body,
          Icons.cast_for_education,
        ),
      1 => (
          context.l10n.onboardingPage2Title,
          context.l10n.onboardingPage2Body,
          Icons.groups,
        ),
      _ => (
          context.l10n.onboardingPage3Title,
          context.l10n.onboardingPage3Body,
          Icons.rocket_launch,
        ),
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 120.r, color: AppColors.primary),
          SizedBox(height: 40.h),
          Text(
            title,
            style: AppTextStyles.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            body,
            style: AppTextStyles.body.copyWith(
              color: AppColors.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.currentPage, required this.count});

  final int currentPage;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 20.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.lightDivider,
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}
