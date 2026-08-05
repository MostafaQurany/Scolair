import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/change_password/change_password_cubit.dart';
import '../cubit/change_password/change_password_state.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ChangePasswordCubit>(),
    child: const _ChangePasswordView(),
  );
}

class _ChangePasswordView extends StatefulWidget {
  const _ChangePasswordView();

  @override
  State<_ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<_ChangePasswordView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

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
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: _handleState,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Theme.of(context).colorScheme.primary),
          title: Text(context.l10n.changePasswordTitle),
          centerTitle: true,
        ),
        body: SafeArea(
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 28.h),
                child: _ChangePasswordBody(
                  formKey: _formKey,
                  oldPasswordController: _oldPasswordController,
                  newPasswordController: _newPasswordController,
                  confirmPasswordController: _confirmPasswordController,
                  obscureOld: _obscureOld,
                  obscureNew: _obscureNew,
                  obscureConfirm: _obscureConfirm,
                  isLoading: state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  ),
                  onToggleOld: () => setState(() => _obscureOld = !_obscureOld),
                  onToggleNew: () => setState(() => _obscureNew = !_obscureNew),
                  onToggleConfirm: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                  onSubmit: _submit,
                ),
              ),
            ),
          ),
        ),
      ),
    );

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ChangePasswordCubit>().changePassword(
        oldPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
      );
    }
  }

  void _handleState(BuildContext context, ChangePasswordState state) {
    state.whenOrNull(
      success: () {
        AppSnackBar.showSuccess(context, context.l10n.updatePasswordSuccess);
        Navigator.pop(context);
      },
      error: (msg) => AppSnackBar.showError(context, msg),
    );
  }
}

class _ChangePasswordBody extends StatelessWidget {
  const _ChangePasswordBody({
    required this.formKey,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.obscureOld,
    required this.obscureNew,
    required this.obscureConfirm,
    required this.isLoading,
    required this.onToggleOld,
    required this.onToggleNew,
    required this.onToggleConfirm,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final bool obscureOld;
  final bool obscureNew;
  final bool obscureConfirm;
  final bool isLoading;
  final VoidCallback onToggleOld;
  final VoidCallback onToggleNew;
  final VoidCallback onToggleConfirm;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                shape: BoxShape.circle,
                border: Border.all(color: colors.outlineVariant),
              ),
              child: Icon(
                Icons.lock_reset_rounded,
                color: AppColors.primary,
                size: 30.r,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            context.l10n.changePasswordTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.changePasswordSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          SizedBox(height: 28.h),
          AuthTextField(
            label: context.l10n.currentPasswordLabel,
            hint: context.l10n.passwordHint,
            controller: oldPasswordController,
            obscureText: obscureOld,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: onToggleOld,
              icon: Icon(
                obscureOld
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? context.l10n.authErrorGeneric
                : null,
          ),
          SizedBox(height: 14.h),
          AuthTextField(
            label: context.l10n.newPasswordLabel,
            hint: context.l10n.newPasswordHint,
            controller: newPasswordController,
            obscureText: obscureNew,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: onToggleNew,
              icon: Icon(
                obscureNew
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? context.l10n.authErrorGeneric
                : null,
          ),
          SizedBox(height: 14.h),
          AuthTextField(
            label: context.l10n.confirmPasswordLabel,
            hint: context.l10n.confirmPasswordHint,
            controller: confirmPasswordController,
            obscureText: obscureConfirm,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: onToggleConfirm,
              icon: Icon(
                obscureConfirm
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return context.l10n.authErrorGeneric;
              }
              if (v != newPasswordController.text) {
                return context.l10n.passwordMismatch;
              }
              return null;
            },
          ),
          SizedBox(height: 28.h),
          AuthPrimaryButton(
            label: context.l10n.updatePasswordButton,
            onPressed: onSubmit,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
