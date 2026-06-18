import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
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
        const OtpArgs(email: '', flow: OtpFlowType.login);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<OtpCubit>()),
        BlocProvider(create: (_) => getIt<ForgotPasswordCubit>()),
      ],
      child: _OtpVerificationView(args: args),
    );
  }
}

class _OtpVerificationView extends StatefulWidget {
  const _OtpVerificationView({required this.args});

  final OtpArgs args;

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
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic));
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
        BlocListener<OtpCubit, OtpState>(listener: _handleOtpState),
        BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: _handleResendState,
        ),
      ],
      child: BlocBuilder<OtpCubit, OtpState>(
        builder: (context, state) => Scaffold(
          body: AuthSurface(
            isBack: true,
            centered: true,
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: _OtpBody(
                  email: widget.args.email,
                  isLoading: state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  ),
                  onChanged: (v) => _otp = v,
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
    context.read<OtpCubit>().verify(widget.args.email, _otp);
  }

  void _resend() {
    context.read<ForgotPasswordCubit>().sendResetCode(widget.args.email);
  }

  void _handleOtpState(BuildContext context, OtpState state) {
    state.whenOrNull(
      success: (token) {
        if (widget.args.flow == OtpFlowType.forgotPassword) {
          Navigator.pushNamed(
            context,
            AppRouteNames.resetPassword,
            arguments: ResetPasswordArgs(token: token.accessToken),
          );
        } else {
          Navigator.pushReplacementNamed(context, AppRouteNames.home);
        }
      },
      error: (_) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.authErrorOtpInvalid)),
      ),
    );
  }

  void _handleResendState(BuildContext context, ForgotPasswordState state) {
    state.whenOrNull(
      sent: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.otpResend)),
      ),
      error: (_) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.authErrorGeneric)),
      ),
    );
  }
}

class _OtpBody extends StatelessWidget {
  const _OtpBody({
    required this.email,
    required this.isLoading,
    required this.onChanged,
    required this.onVerify,
    required this.onResend,
  });

  final String email;
  final bool isLoading;
  final ValueChanged<String> onChanged;
  final VoidCallback onVerify;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      padding: EdgeInsetsDirectional.all(24.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthHeader(
            title: context.l10n.otpTitle,
            subtitle: context.l10n.otpSubtitle(email),
            icon: Icons.lock_person_outlined,
          ),
          SizedBox(height: 24.h),
          AuthOtpFields(onChanged: onChanged),
          SizedBox(height: 16.h),
          TextButton.icon(
            onPressed: onResend,
            icon: const Icon(Icons.refresh, size: 18),
            label: Text(context.l10n.otpResend),
          ),
          SizedBox(height: 8.h),
          AuthPrimaryButton(
            label: context.l10n.otpVerifyButton,
            onPressed: onVerify,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
