import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
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
  final _usernameController = TextEditingController();
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
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero,)
        .animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeIn);
    _entryCtrl.forward();
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _usernameController.dispose();
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
                usernameController: _usernameController,
                passwordController: _passwordController,
                obscurePassword: _obscurePassword,
                isLoading: state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ),
                onTogglePassword: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                onSubmit: _submit,
                onForgotPassword: () =>
                    Navigator.pushNamed(context, AppRouteNames.forgotPassword),
                onRegister: () =>
                    Navigator.pushNamed(context, AppRouteNames.register),
                onGoogleLogin: () => _googleLogin(context),
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
        _usernameController.text.trim(),
        _passwordController.text,
      );
    }
  }

  Future<void> _googleLogin(BuildContext context) async {
    final googleSignIn = GoogleSignIn(
      scopes: ['email', 'openid'],
      serverClientId:
          '1037955830206-ts4o5a3dgmc1pat80r2vmi7rh3o3jv31.apps.googleusercontent.com',
    );
    try {
      final account = await googleSignIn.signIn();
      if (account == null) return;
      final auth = await account.authentication;
      final idToken = auth.idToken;
      if (idToken == null || !context.mounted) return;
      context.read<LoginCubit>().googleLogin(idToken);
    } catch (e) {
      AppSnackBar.showError(context, e.toString());
    }
  }

  void _handleState(BuildContext context, LoginState state) {
    state.whenOrNull(
      success: (_) => Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteNames.home,
        (_) => false,
      ),
      error: (msg) => AppSnackBar.showError(context, msg),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody({
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.obscurePassword,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onSubmit,
    required this.onForgotPassword,
    required this.onRegister,
    required this.onGoogleLogin,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;
  final VoidCallback onForgotPassword;
  final VoidCallback onRegister;
  final VoidCallback onGoogleLogin;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const AuthBrandMark(),
          SizedBox(height: 36.h),
          AuthCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.loginTitle, style: Theme.of(context).textTheme.titleLarge),
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
                  controller: usernameController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.contact_mail_outlined),
                  validator: (v) => (v == null || v.trim().isEmpty)
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
                    onPressed: onTogglePassword,
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
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
                AuthPrimaryButton(
                  label: context.l10n.loginButton,
                  onPressed: onSubmit,
                  isLoading: isLoading,
                ),
                SizedBox(height: 12.h),
                _GoogleButton(onPressed: onGoogleLogin),
                SizedBox(height: 12.h),
                Center(
                  child: TextButton(
                    onPressed: onRegister,
                    child: Text(context.l10n.createAccountButton),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.g_mobiledata_rounded, size: 24),
        label: Text(context.l10n.continueWithGoogleButton),
      ),
    );
  }
}
