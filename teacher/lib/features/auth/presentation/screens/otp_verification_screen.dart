import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';
import '../cubit/otp/otp_cubit.dart';
import '../cubit/otp/otp_state.dart';
import '../widgets/auth_otp_fields.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_surface.dart';
import 'otp_args.dart';
import 'otp_flow_type.dart';
import 'reset_password_args.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as OtpArgs? ??
        const OtpArgs(identifier: '', flow: OtpFlowType.forgotPassword);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<OtpCubit>()),
        BlocProvider(create: (_) => getIt<ForgotPasswordCubit>()),
      ],
      child: _OtpVerificationView(
        identifier: args.identifier,
        flow: args.flow,
        sessionId: args.sessionId,
      ),
    );
  }
}

class _OtpVerificationView extends StatefulWidget {
  const _OtpVerificationView({
    required this.identifier,
    required this.flow,
    required this.sessionId,
  });

  final String identifier;
  final OtpFlowType flow;
  final String sessionId;

  @override
  State<_OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<_OtpVerificationView>
    with SingleTickerProviderStateMixin {
  String _otp = '';

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
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: _handleForgotResend,
        ),
      ],
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: _handleOtpState,
        builder: (context, state) => Scaffold(
          body: AuthSurface(
            isBack: true,
            centered: true,
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: _OtpBody(
                  identifier: widget.identifier,
                  isLoading: state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  ),
                  onOtpChanged: (v) => _otp = v,
                  onVerify: _verify,
                  onResend: _resend,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _verify() {
    if (_otp.length == 6) {
      context.read<OtpCubit>().verify(widget.sessionId, _otp);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.authErrorOtpInvalid)));
    }
  }

  void _resend() {
    context.read<ForgotPasswordCubit>().sendResetCode(widget.identifier);
  }

  void _handleOtpState(BuildContext context, OtpState state) {
    state.whenOrNull(
      success: (resetToken) => Navigator.pushNamed(
        context,
        AppRouteNames.resetPassword,
        arguments: ResetPasswordArgs(token: resetToken),
      ),
      error: (msg) => AppSnackBar.showError(context, msg),
    );
  }

  void _handleForgotResend(BuildContext context, ForgotPasswordState state) {
    state.whenOrNull(
      sent: (_) => AppSnackBar.showSuccess(context, context.l10n.otpResend),
      error: (msg) => AppSnackBar.showError(context, msg),
    );
  }
}

class _OtpBody extends StatelessWidget {
  const _OtpBody({
    required this.identifier,
    required this.isLoading,
    required this.onOtpChanged,
    required this.onVerify,
    required this.onResend,
  });

  final String identifier;
  final bool isLoading;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onVerify;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthHeader(
          title: context.l10n.otpTitle,
          subtitle: context.l10n.otpSubtitle(identifier),
          icon: Icons.lock_person_outlined,
        ),
        SizedBox(height: 24.h),
        AuthCard(
          padding: EdgeInsetsDirectional.all(24.r),
          child: Column(
            children: [
              AuthOtpFields(onChanged: onOtpChanged),
              SizedBox(height: 18.h),
              TextButton.icon(
                onPressed: onResend,
                icon: Icon(Icons.refresh_outlined, size: 16.r),
                label: Text(context.l10n.otpResend),
              ),
              SizedBox(height: 22.h),
              AuthPrimaryButton(
                label: context.l10n.otpVerifyButton,
                onPressed: onVerify,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
