import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_surface.dart';
import '../widgets/auth_text_field.dart';
import 'otp_args.dart';
import 'otp_flow_type.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ForgotPasswordCubit>(),
    child: const _ForgotPasswordView(),
  );
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

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
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: _handleState,
      builder: (context, state) => Scaffold(
        body: AuthSurface(
          isBack: true,
          centered: true,
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: _ForgotPasswordBody(
                formKey: _formKey,
                emailController: _emailController,
                isLoading: state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ),
                onSubmit: _submit,
                onBack: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordCubit>().sendResetCode(
        _emailController.text.trim(),
      );
    }
  }

  void _handleState(BuildContext context, ForgotPasswordState state) {
    state.whenOrNull(
      sent: (sessionId) => Navigator.pushNamed(
        context,
        AppRouteNames.otpVerification,
        arguments: OtpArgs(
          identifier: _emailController.text.trim(),
          flow: OtpFlowType.forgotPassword,
          sessionId: sessionId,
        ),
      ),
      error: (msg) => AppSnackBar.showError(context, msg),
    );
  }
}

class _ForgotPasswordBody extends StatelessWidget {
  const _ForgotPasswordBody({
    required this.formKey,
    required this.emailController,
    required this.isLoading,
    required this.onSubmit,
    required this.onBack,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final bool isLoading;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AuthBrandMark(compact: true),
        SizedBox(height: 32.h),
        AuthCard(
          padding: EdgeInsetsDirectional.all(24.r),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  context.l10n.forgotPasswordTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8.h),
                Text(
                  context.l10n.forgotPasswordSubtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 24.h),
                AuthTextField(
                  label: context.l10n.emailLabel,
                  hint: context.l10n.emailHint,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.contact_mail_outlined),
                  validator: _requiredValidator(context),
                ),
                SizedBox(height: 18.h),
                AuthPrimaryButton(
                  label: context.l10n.sendResetLinkButton,
                  onPressed: onSubmit,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 22.h),
        AuthSecondaryAction(
          label: context.l10n.usePasswordFallback,
          icon: Icons.arrow_back,
          onPressed: onBack,
        ),
      ],
    );
  }

  FormFieldValidator<String> _requiredValidator(BuildContext context) {
    return (value) => (value == null || value.trim().isEmpty)
        ? context.l10n.authErrorGeneric
        : null;
  }
}
