import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';

import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_surface.dart';
import '../widgets/auth_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<LoginCubit>(),
    child: const _LoginView(),
  );
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: _handleState,
      builder: (context, state) => Scaffold(
        body: AuthSurface(
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: _LoginBody(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                obscurePassword: _obscurePassword,
                onTogglePassword: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                isLoading: state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ),
                onSubmit: _submit,
                onForgotPassword: () =>
                    Navigator.pushNamed(context, AppRouteNames.forgotPassword),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  void _handleState(BuildContext context, LoginState state) {
    state.whenOrNull(
      success: (_) => Navigator.pushReplacementNamed(
        context,
        AppRouteNames.home,
      ),
      error: (_) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.authErrorInvalidCredentials)),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.isLoading,
    required this.onSubmit,
    required this.onForgotPassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final bool isLoading;
  final VoidCallback onSubmit;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthBrandMark(label: context.l10n.appName),
        SizedBox(height: 36.h),
        AuthCard(
          padding: EdgeInsetsDirectional.all(24.r),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.loginTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  context.l10n.loginSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 22.h),
                AuthTextField(
                  label: context.l10n.emailLabel,
                  hint: context.l10n.emailHint,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty)
                          ? context.l10n.authErrorGeneric
                          : null,
                ),
                SizedBox(height: 14.h),
                AuthTextField(
                  label: context.l10n.passwordLabel,
                  hint: context.l10n.passwordHint,
                  controller: passwordController,
                  obscureText: obscurePassword,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: onTogglePassword,
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty)
                          ? context.l10n.authErrorGeneric
                          : null,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: onForgotPassword,
                    child: Text(context.l10n.forgotPasswordLink),
                  ),
                ),
                SizedBox(height: 8.h),
                AuthPrimaryButton(
                  label: context.l10n.loginButton,
                  onPressed: onSubmit,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
