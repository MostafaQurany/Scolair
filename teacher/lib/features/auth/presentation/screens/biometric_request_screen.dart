import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../cubit/biometric_request/biometric_request_cubit.dart';
import '../cubit/biometric_request/biometric_request_state.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_surface.dart';

class BiometricRequestScreen extends StatelessWidget {
  const BiometricRequestScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<BiometricRequestCubit>(),
    child: const _BiometricRequestView(),
  );
}

class _BiometricRequestView extends StatefulWidget {
  const _BiometricRequestView();

  @override
  State<_BiometricRequestView> createState() => _BiometricRequestViewState();
}

class _BiometricRequestViewState extends State<_BiometricRequestView> {
  bool _dontShowAgain = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricRequestCubit, BiometricRequestState>(
      listener: _handleState,
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        return Scaffold(
          body: AuthSurface(
            centered: true,
            child: _BiometricRequestBody(
              isLoading: isLoading,
              dontShowAgain: _dontShowAgain,
              onToggleDontShow: (v) =>
                  setState(() => _dontShowAgain = v ?? false),
              onEnable: () => context
                  .read<BiometricRequestCubit>()
                  .enableBiometric(dontShowAgain: _dontShowAgain),
              onDismiss: () => context.read<BiometricRequestCubit>().dismiss(
                dontShowAgain: _dontShowAgain,
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleState(BuildContext context, BiometricRequestState state) {
    state.whenOrNull(
      enabled: () => _goHome(context),
      dismissed: () => _goHome(context),
      unavailable: () =>
          AppSnackBar.showError(context, context.l10n.biometricUnavailable),
      failed: (msg) {
        if (msg != 'cancelled') {
          AppSnackBar.showError(context, context.l10n.authErrorGeneric);
        }
      },
    );
  }

  void _goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteNames.homeLayout,
      (_) => false,
    );
  }
}

class _BiometricRequestBody extends StatelessWidget {
  const _BiometricRequestBody({
    required this.isLoading,
    required this.dontShowAgain,
    required this.onToggleDontShow,
    required this.onEnable,
    required this.onDismiss,
  });

  final bool isLoading;
  final bool dontShowAgain;
  final ValueChanged<bool?> onToggleDontShow;
  final VoidCallback onEnable;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AuthBrandMark(),
        SizedBox(height: 24.h),
        AuthCard(
          padding: EdgeInsetsDirectional.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96.r,
                height: 96.r,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.18),
                      blurRadius: 28.r,
                      spreadRadius: 4.r,
                    ),
                  ],
                ),
                child: Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Icon(
                      Icons.fingerprint,
                      size: 54.r,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                context.l10n.biometricRequestTitle,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                context.l10n.biometricRequestSubtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              CheckboxListTile(
                value: dontShowAgain,
                onChanged: onToggleDontShow,
                title: Text(
                  context.l10n.biometricDontShowAgainLabel,
                  style: textTheme.bodyMedium,
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(height: 16.h),
              AuthPrimaryButton(
                label: context.l10n.biometricEnableButton,
                onPressed: onEnable,
                isLoading: isLoading,
              ),
              SizedBox(height: 4.h),
              SizedBox(
                width: double.infinity,
                height: 44.h,
                child: TextButton(
                  onPressed: isLoading ? null : onDismiss,
                  child: Text(
                    context.l10n.biometricNotNowButton,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
