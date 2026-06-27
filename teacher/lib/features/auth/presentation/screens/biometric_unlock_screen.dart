import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/biometric/biometric_cubit.dart';
import '../cubit/biometric/biometric_state.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_surface.dart';

class BiometricUnlockScreen extends StatelessWidget {
  const BiometricUnlockScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<BiometricCubit>(),
    child: const _BiometricUnlockView(),
  );
}

class _BiometricUnlockView extends StatefulWidget {
  const _BiometricUnlockView();

  @override
  State<_BiometricUnlockView> createState() => _BiometricUnlockViewState();
}

class _BiometricUnlockViewState extends State<_BiometricUnlockView>
    with SingleTickerProviderStateMixin {
  late AnimationController _entryCtrl;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeIn);
    _entryCtrl.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<BiometricCubit>().checkAndAuthenticate(
          context.l10n.biometricPrompt,
        );
      }
    });
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricCubit, BiometricState>(
      listener: _handleState,
      builder: (context, state) => Scaffold(
        body: AuthSurface(
          centered: true,
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: _BiometricBody(
                isLoading: state.maybeWhen(
                  checking: () => true,
                  orElse: () => false,
                ),
                onRetry: () => context
                    .read<BiometricCubit>()
                    .checkAndAuthenticate(context.l10n.biometricPrompt),
                onUsePassword: () => Navigator.pushReplacementNamed(
                  context,
                  AppRouteNames.login,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleState(BuildContext context, BiometricState state) {
    state.whenOrNull(
      authenticated: () => Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteNames.homeLayout,
        (_) => false,
      ),
      unavailable: () => _showError(context),
      failed: (_) => _showError(context),
    );
  }

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.l10n.authErrorGeneric)));
  }
}

class _BiometricBody extends StatelessWidget {
  const _BiometricBody({
    required this.isLoading,
    required this.onRetry,
    required this.onUsePassword,
  });

  final bool isLoading;
  final VoidCallback onRetry;
  final VoidCallback onUsePassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96.r,
          height: 96.r,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: Icon(Icons.fingerprint, color: AppColors.primary, size: 56.r),
        ),
        SizedBox(height: 24.h),
        AuthHeader(
          title: context.l10n.biometricTitle,
          subtitle: context.l10n.biometricSubtitle,
        ),
        SizedBox(height: 28.h),
        AuthPrimaryButton(
          label: context.l10n.biometricPrompt,
          onPressed: onRetry,
          isLoading: isLoading,
        ),
        SizedBox(height: 12.h),
        TextButton(
          onPressed: onUsePassword,
          child: Text(context.l10n.usePasswordFallback),
        ),
      ],
    );
  }
}
