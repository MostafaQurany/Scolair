import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../cubit/reset_password/reset_password_cubit.dart';
import '../cubit/reset_password/reset_password_state.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_surface.dart';
import '../widgets/auth_text_field.dart';
import 'reset_password_args.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ResetPasswordArgs? ??
        const ResetPasswordArgs(token: '');

    return BlocProvider(
      create: (_) => getIt<ResetPasswordCubit>(),
      child: _ResetPasswordView(token: args.token),
    );
  }
}

class _ResetPasswordView extends StatefulWidget {
  const _ResetPasswordView({required this.token});

  final String token;

  @override
  State<_ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<_ResetPasswordView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: _handleState,
      builder: (context, state) => Scaffold(
        body: AuthSurface(
          isBack: true,
          centered: true,
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: _ResetPasswordBody(
                formKey: _formKey,
                newPasswordController: _newPasswordController,
                confirmPasswordController: _confirmPasswordController,
                isLoading: state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ),
                onSubmit: _submit,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ResetPasswordCubit>().reset(
        widget.token,
        _newPasswordController.text,
        _confirmPasswordController.text,
      );
    }
  }

  void _handleState(BuildContext context, ResetPasswordState state) {
    state.whenOrNull(
      success: () => Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteNames.login,
        (_) => false,
      ),
      error: (_) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.authErrorGeneric)),
      ),
    );
  }
}

class _ResetPasswordBody extends StatelessWidget {
  const _ResetPasswordBody({
    required this.formKey,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      padding: EdgeInsetsDirectional.all(24.r),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AuthHeader(
              title: context.l10n.resetPasswordTitle,
              subtitle: context.l10n.forgotPasswordSubtitle,
              icon: Icons.lock_reset_outlined,
            ),
            SizedBox(height: 24.h),
            AuthTextField(
              label: context.l10n.newPasswordLabel,
              hint: context.l10n.newPasswordHint,
              controller: newPasswordController,
              obscureText: true,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.lock_outline),
              validator: (value) =>
                  (value == null || value.trim().isEmpty)
                      ? context.l10n.authErrorGeneric
                      : null,
            ),
            SizedBox(height: 14.h),
            AuthTextField(
              label: context.l10n.confirmPasswordLabel,
              hint: context.l10n.confirmPasswordHint,
              controller: confirmPasswordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              prefixIcon: const Icon(Icons.lock_outline),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.l10n.authErrorGeneric;
                }
                if (value != newPasswordController.text) {
                  return context.l10n.passwordMismatch;
                }
                return null;
              },
            ),
            SizedBox(height: 22.h),
            AuthPrimaryButton(
              label: context.l10n.resetPasswordButton,
              onPressed: onSubmit,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
