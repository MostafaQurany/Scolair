import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_surface.dart';
import '../widgets/auth_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<RegisterCubit>(),
    child: const _RegisterView(),
  );
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _verifyTerms = false;

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
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<RegisterCubit, RegisterState>(
      listener: _handleState,
      builder: (context, state) => Scaffold(
        body: AuthSurface(
          isBack: true,
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: _RegisterBody(
                formKey: _formKey,
                fullNameController: _fullNameController,
                emailController: _emailController,
                passwordController: _passwordController,
                obscurePassword: _obscurePassword,
                verifyTerms: _verifyTerms,
                isLoading: state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ),
                onTogglePassword: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                onToggleTerms: (v) => setState(() => _verifyTerms = v ?? false),
                onSubmit: _submit,
                onLogin: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ),
    );

  void _submit() {
    if (!_verifyTerms) return;
    if (_formKey.currentState?.validate() ?? false) {
      context.read<RegisterCubit>().register(
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        verifyTerms: _verifyTerms,
      );
    }
  }

  void _handleState(BuildContext context, RegisterState state) {
    state.whenOrNull(
      success: () {
        AppSnackBar.showSuccess(context, context.l10n.registerSuccess);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouteNames.login,
          (_) => false,
        );
      },
      error: (msg) => AppSnackBar.showError(context, msg),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody({
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.verifyTerms,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onToggleTerms,
    required this.onSubmit,
    required this.onLogin,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool verifyTerms;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final ValueChanged<bool?> onToggleTerms;
  final VoidCallback onSubmit;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) => Form(
      key: formKey,
      child: Column(
        children: [
          const AuthBrandMark(),
          SizedBox(height: 36.h),
          AuthCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.registerTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 22.h),
                AuthTextField(
                  label: context.l10n.fullNameLabel,
                  hint: context.l10n.fullNameHint,
                  controller: fullNameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: _required(context),
                ),
                SizedBox(height: 14.h),
                AuthTextField(
                  label: context.l10n.emailLabel,
                  hint: context.l10n.emailHint,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.contact_mail_outlined),
                  validator: _required(context),
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
                  validator: _required(context),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Checkbox(value: verifyTerms, onChanged: onToggleTerms),
                    Expanded(
                      child: Text(
                        context.l10n.agreeTermsLabel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                AuthPrimaryButton(
                  label: context.l10n.createAccountButton,
                  onPressed: verifyTerms ? onSubmit : null,
                  isLoading: isLoading,
                ),
                SizedBox(height: 12.h),
                Center(
                  child: TextButton(
                    onPressed: onLogin,
                    child: Text(context.l10n.alreadyHaveAccountLink),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  FormFieldValidator<String> _required(BuildContext context) =>
      (v) => (v == null || v.trim().isEmpty)
      ? context.l10n.authErrorGeneric
      : null;
}
