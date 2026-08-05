import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) => getIt<OnboardingCubit>(),
      child: const _OnboardingView(),
    );
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _entranceCtrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim = CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut);
    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _entranceCtrl.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    context.read<OnboardingCubit>().changePage(index);
    _entranceCtrl
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) => state.whenOrNull(
        navigate: (r) => Navigator.pushReplacementNamed(context, r),
      ),
      builder: (context, state) {
        final pageIndex = state.whenOrNull(initial: (i) => i) ?? 0;
        final cubit = context.read<OnboardingCubit>();
        final isRtl = Directionality.of(context) == TextDirection.rtl;
        final reduceMotion = MediaQuery.of(context).disableAnimations;
        final slideAnim = reduceMotion
            ? const AlwaysStoppedAnimation(Offset.zero)
            : Tween<Offset>(
                begin: Offset(isRtl ? 0.3 : -0.3, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut),
              );
        final (asset, title, body) = switch (pageIndex) {
          0 => (
            AppAssets.onboarding1,
            context.l10n.onboardingPage1Title,
            context.l10n.onboardingPage1Body,
          ),
          1 => (
            AppAssets.onboarding2,
            context.l10n.onboardingPage2Title,
            context.l10n.onboardingPage2Body,
          ),
          _ => (
            AppAssets.onboarding3,
            context.l10n.onboardingPage3Title,
            context.l10n.onboardingPage3Body,
          ),
        };

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                _TopBar(pageIndex: pageIndex, onSkip: cubit.finish),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: 3,
                        onPageChanged: _onPageChanged,
                        allowImplicitScrolling: true,
                        itemBuilder: (_, _) => const SizedBox.shrink(),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 16.h,
                          ),
                          child: SlideTransition(
                            position: slideAnim,
                            child: FadeTransition(
                              opacity: _fadeAnim,
                              child: _IllustrationCard(assetPath: asset),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Text(
                    body,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 24.h),
                _DotIndicator(currentPage: pageIndex, count: 3),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: _AnimatedButton(
                    label: pageIndex < 2
                        ? context.l10n.onboardingNextButton
                        : context.l10n.onboardingDoneButton,
                    onPressed: () => pageIndex < 2
                        ? _pageController.nextPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                          )
                        : cubit.finish(),
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

class _IllustrationCard extends StatelessWidget {
  const _IllustrationCard({required this.assetPath});
  final String assetPath;

  @override
  Widget build(BuildContext context) => DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 32,
            spreadRadius: 8,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Image.asset(assetPath, fit: BoxFit.contain),
      ),
    );
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.pageIndex, required this.onSkip});
  final int pageIndex;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 60.h,
      child: Row(
        children: [
          SizedBox(width: 88.w),
          Expanded(
            child: Text(
              'Scolair',
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceMono(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
            ),
          ),
          SizedBox(
            width: 88.w,
            child: pageIndex < 2
                ? TextButton(
                    onPressed: onSkip,
                    child: Text(
                      context.l10n.onboardingSkipButton,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.currentPage, required this.count});
  final int currentPage;
  final int count;

  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 24.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : Theme.of(context).colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
}

class _AnimatedButton extends StatefulWidget {
  const _AnimatedButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );
    _scale = Tween<double>(begin: 1, end: 0.97).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Listener(
      onPointerDown: (_) => _ctrl.forward(),
      onPointerUp: (_) => _ctrl.reverse(),
      onPointerCancel: (_) => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: widget.onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.darkTextPrimary,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              widget.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.darkTextPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
}
