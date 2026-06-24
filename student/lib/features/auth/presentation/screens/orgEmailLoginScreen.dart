import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../cubit/phone_login/phone_login_cubit.dart';
import '../cubit/phone_login/phone_login_state.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_surface.dart';
import '../widgets/auth_text_field.dart';
import 'otp_args.dart';
import 'otp_flow_type.dart';

class OrgEmailLoginScreen extends StatelessWidget {
  const OrgEmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<PhoneLoginCubit>(),
    child: const _PhoneLoginView(),
  );
}

class _PhoneLoginView extends StatefulWidget {
  const _PhoneLoginView();

  @override
  State<_PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<_PhoneLoginView>
    with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  String _countryCode = '+1';

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
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneLoginCubit, PhoneLoginState>(
      listener: _handleState,
      builder: (context, state) => Scaffold(
        body: AuthSurface(
          isBack: true,
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: _PhoneLoginBody(
                phoneController: _phoneController,
                countryCode: _countryCode,
                isLoading: state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ),
                onCountryChanged: (v) => setState(() => _countryCode = v),
                onSendOtp: _sendOtp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendOtp() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) return;
    context.read<PhoneLoginCubit>().sendOtp(_countryCode, phone);
  }

  void _handleState(BuildContext context, PhoneLoginState state) {
    state.whenOrNull(
      sent: () => Navigator.pushNamed(
        context,
        AppRouteNames.otpVerification,
        arguments: OtpArgs(
          identifier: '$_countryCode${_phoneController.text.trim()}',
          flow: OtpFlowType.phoneLogin,
        ),
      ),
      error: (_) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.authErrorGeneric))),
    );
  }
}

class _PhoneLoginBody extends StatelessWidget {
  const _PhoneLoginBody({
    required this.phoneController,
    required this.countryCode,
    required this.isLoading,
    required this.onCountryChanged,
    required this.onSendOtp,
  });

  final TextEditingController phoneController;
  final String countryCode;
  final bool isLoading;
  final ValueChanged<String> onCountryChanged;
  final VoidCallback onSendOtp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthBrandMark(compact: true),
              SizedBox(height: 16.h),
              Text(context.l10n.orgLoginTitle, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 6.h),
              Text(
                context.l10n.orgLoginSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 22.h),
              _PhoneRow(
                phoneController: phoneController,
                countryCode: countryCode,
                onCountryChanged: onCountryChanged,
              ),
              SizedBox(height: 20.h),
              AuthPrimaryButton(
                label: context.l10n.sendOtpButton,
                onPressed: onSendOtp,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          context.l10n.phoneLoginSecurityNote,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 12.sp,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _PhoneRow extends StatelessWidget {
  const _PhoneRow({
    required this.phoneController,
    required this.countryCode,
    required this.onCountryChanged,
  });

  final TextEditingController phoneController;
  final String countryCode;
  final ValueChanged<String> onCountryChanged;

  static const _codes = ['+1', '+44', '+966', '+20', '+971'];
  static const _flags = ['🇺🇸', '🇬🇧', '🇸🇦', '🇪🇬', '🇦🇪'];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 56.h,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: countryCode,
              items: List.generate(
                _codes.length,
                    (i) => DropdownMenuItem(
                  value: _codes[i],
                  child: Text('${_flags[i]} ${_codes[i]}'),
                ),
              ),
              onChanged: (v) {
                if (v != null) onCountryChanged(v);
              },
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: AuthTextField(
            label: context.l10n.phoneNumberLabel,
            hint: context.l10n.phoneNumberHint,
            controller: phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(Icons.phone_outlined),
          ),
        ),
      ],
    );
  }
}
