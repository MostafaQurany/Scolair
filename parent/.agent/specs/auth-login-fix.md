# Spec: Parent Auth Login Fix + Animations
status: pending

## Context
The parent auth feature was already built (see `parent/.agent/project-memory.md`). However the `login_screen.dart` shows email + password — which is wrong. The real parent design (Stitch `749a1579a2a94d118ce818ca57623edf`) shows a **phone number + Send OTP** flow. This spec fixes the login screen, adds the required `PhoneLoginCubit`, updates `OtpArgs` / `OtpFlowType`, and adds entry animations to all 6 auth screens.

Before writing any UI code, **fetch the Stitch designs** using the Stitch MCP:
- Parent Login: `749a1579a2a94d118ce818ca57623edf`

---

## Task 1 — Update `OtpFlowType` and `OtpArgs`

### `parent/lib/features/auth/presentation/screens/otp_flow_type.dart`
```dart
enum OtpFlowType { phoneLogin, forgotPassword }
```
Rename `login` → `phoneLogin`. Parent OTP is always triggered by phone, never email.

### `parent/lib/features/auth/presentation/screens/otp_args.dart`
```dart
class OtpArgs {
  const OtpArgs({required this.identifier, required this.flow});
  final String identifier; // full phone with country code for phoneLogin; email for forgotPassword
  final OtpFlowType flow;
}
```
Rename `email` → `identifier`.

After this change, update all usages across the codebase (`forgot_password_screen.dart`, `otp_verification_screen.dart`).

---

## Task 2 — Add `SendOtp` data + domain + cubit

### `parent/lib/features/auth/data/models/send_otp_request_data.dart`
```dart
import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request_data.g.dart';

@JsonSerializable()
class SendOtpRequestData {
  const SendOtpRequestData({required this.phone, required this.countryCode});

  final String phone;
  @JsonKey(name: 'country_code') final String countryCode;

  factory SendOtpRequestData.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$SendOtpRequestDataToJson(this);
}
```

### `parent/lib/core/network/api_endpoints.dart` — add:
```dart
static const String sendOtp = '/auth/send-otp';
```

### `parent/lib/core/network/api_client.dart` — add method:
```dart
import '../../features/auth/data/models/send_otp_request_data.dart';
// ...
@POST(ApiEndpoints.sendOtp)
Future<void> sendOtp(@Body() SendOtpRequestData request);
```

### `parent/lib/features/auth/data/datasources/remote/auth_remote_datasource.dart` — add:
```dart
Future<void> sendOtp(String countryCode, String phone) async {
  throw UnimplementedError('sendOtp not implemented'); // TODO: wire up when backend is ready
}
```

### `parent/lib/features/auth/domain/repositories/auth_repository.dart` — add:
```dart
Future<ApiResult<void>> sendOtp(String countryCode, String phone);
```

### `parent/lib/features/auth/data/repositories/auth_repository_impl.dart` — add:
```dart
@override
Future<ApiResult<void>> sendOtp(String countryCode, String phone) =>
    _voidResult(() => _datasource.sendOtp(countryCode, phone));
```

### `parent/lib/features/auth/domain/usecases/send_otp_usecase.dart`
```dart
import 'package:parent/core/network/api_result.dart';
import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  const SendOtpUseCase(this._repository);
  final AuthRepository _repository;

  Future<ApiResult<void>> call({
    required String countryCode,
    required String phone,
  }) =>
      _repository.sendOtp(countryCode, phone);
}
```

### `parent/lib/features/auth/presentation/cubit/phone_login/phone_login_state.dart`
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_login_state.freezed.dart';

@freezed
sealed class PhoneLoginState with _$PhoneLoginState {
  const factory PhoneLoginState.initial() = _Initial;
  const factory PhoneLoginState.loading() = _Loading;
  const factory PhoneLoginState.sent() = _Sent;
  const factory PhoneLoginState.error(String message) = _Error;
}
```

### `parent/lib/features/auth/presentation/cubit/phone_login/phone_login_cubit.dart`
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/send_otp_usecase.dart';
import 'phone_login_state.dart';

class PhoneLoginCubit extends Cubit<PhoneLoginState> {
  PhoneLoginCubit(this._sendOtp) : super(const PhoneLoginState.initial());

  final SendOtpUseCase _sendOtp;

  Future<void> sendOtp(String countryCode, String phone) async {
    emit(const PhoneLoginState.loading());
    final result = await _sendOtp(countryCode: countryCode, phone: phone);
    result.when(
      success: (_) => emit(const PhoneLoginState.sent()),
      failure: (f) => emit(PhoneLoginState.error(f.message)),
    );
  }
}
```

### `parent/lib/core/di/dependency_injection.dart` — register:
```dart
..registerLazySingleton<SendOtpUseCase>(() => SendOtpUseCase(getIt()))
..registerFactory<PhoneLoginCubit>(() => PhoneLoginCubit(getIt()))
```

---

## Task 3 — Replace `login_screen.dart`

**Full replacement** of `parent/lib/features/auth/presentation/screens/login_screen.dart`.

Fetch Stitch design `749a1579a2a94d118ce818ca57623edf` for exact spacing and visual details.

Layout (top → bottom):
1. `AuthBrandMark(label: context.l10n.appName)` — logo + "Scolair" wordmark
2. `SizedBox(height: 36.h)`
3. `AuthCard` containing:
   - Title: `context.l10n.loginTitle` (`AppTextStyles.titleLarge`)
   - Subtitle: `context.l10n.loginSubtitle` (secondary color)
   - `SizedBox(height: 22.h)`
   - Phone row: `Row` with country-code dropdown + phone text field
   - `SizedBox(height: 20.h)`
   - `AuthPrimaryButton` label `context.l10n.sendOtpButton`
   - `SizedBox(height: 12.h)`
   - Centered `TextButton` label `context.l10n.forgotPasswordLink`
4. `SizedBox(height: 16.h)`
5. `AuthSecondaryAction` label `context.l10n.orgLoginLink` (outlined style, use `OutlinedButton` via `AuthSecondaryAction` or a direct `OutlinedButton`)
6. `Spacer()` or `SizedBox` to push security note to bottom
7. `Text(context.l10n.phoneLoginSecurityNote)` — `AppTextStyles.caption` / small secondary

**Country-code dropdown** — use a `DropdownButton<String>` with 5 entries:
```dart
static const _codes = ['+1', '+44', '+966', '+20', '+971'];
static const _flags = ['🇺🇸', '🇬🇧', '🇸🇦', '🇪🇬', '🇦🇪'];
```
Display: `'${_flags[i]} ${_codes[i]}'` in the dropdown items. Selected value shown in dropdown button.
Put selected `countryCode` in widget state: `String _countryCode = '+1';`

**Navigation on `PhoneLoginState.sent`**:
```dart
Navigator.pushNamed(
  context,
  AppRouteNames.otpVerification,
  arguments: OtpArgs(
    identifier: '$_countryCode${_phoneController.text.trim()}',
    flow: OtpFlowType.phoneLogin,
  ),
);
```

**No back button** — `AuthSurface(isBack: false, child: ...)` (this is the root screen).

**BlocProvider**:
```dart
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<PhoneLoginCubit>(),
    child: const _LoginView(),
  );
}
```

**`_LoginView`** must be a `StatefulWidget` with `SingleTickerProviderStateMixin` for entry animation (see Animation section below).

**Max 250 lines** — if `_LoginView` + `_LoginBody` together exceed 250 lines, split `_LoginBody` into a separate private widget in the same file.

---

## Task 4 — Update `otp_verification_screen.dart`

File: `parent/lib/features/auth/presentation/screens/otp_verification_screen.dart`

Changes:
1. Import `phone_login_cubit.dart` and `phone_login_state.dart`
2. Default args: `OtpArgs(identifier: '', flow: OtpFlowType.phoneLogin)`
3. Pass `email: args.identifier` → rename to `identifier: args.identifier` everywhere
4. Add `PhoneLoginCubit` to `MultiBlocProvider`:
   ```dart
   BlocProvider(create: (_) => getIt<PhoneLoginCubit>()),
   ```
5. Resend logic:
   ```dart
   void _resend() {
     if (widget.flow == OtpFlowType.phoneLogin) {
       context.read<PhoneLoginCubit>().sendOtp('+1', widget.identifier);
     } else {
       context.read<ForgotPasswordCubit>().sendResetCode(widget.identifier);
     }
   }
   ```
6. Add `BlocListener<PhoneLoginCubit, PhoneLoginState>` for resend feedback:
   ```dart
   listener: (context, state) => state.whenOrNull(
     sent: () => ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(context.l10n.otpResend)),
     ),
     error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(msg)),
     ),
   ),
   ```
   Use `MultiBlocListener` wrapping the existing `BlocListener<ForgotPasswordCubit>`.
7. Update `_OtpVerificationView` fields: `identifier` instead of `email`. The subtitle text can remain `context.l10n.otpSubtitle(widget.identifier)`.

---

## Task 5 — Update `forgot_password_screen.dart`

File: `parent/lib/features/auth/presentation/screens/forgot_password_screen.dart`

Change navigation to use `identifier` instead of `email`:
```dart
OtpArgs(
  identifier: _emailController.text.trim(),
  flow: OtpFlowType.forgotPassword,
)
```

---

## Task 6 — Add Entry Animations to ALL 6 screens

Add this pattern to every auth screen's `_XxxView` class. These screens already exist:
- `login_screen.dart` — `_LoginView` (new from Task 3)
- `org_email_login_screen.dart` — `_OrgEmailLoginView`
- `otp_verification_screen.dart` — `_OtpVerificationView`
- `forgot_password_screen.dart` — `_ForgotPasswordView`
- `reset_password_screen.dart` — `_ResetPasswordView`
- `biometric_unlock_screen.dart` — `_BiometricUnlockView`

For each `_XxxView`:
1. Add `with SingleTickerProviderStateMixin` to `State<_XxxView>`
2. Add fields:
   ```dart
   late AnimationController _entryCtrl;
   late Animation<Offset> _slide;
   late Animation<double> _fade;
   ```
3. In `initState()`:
   ```dart
   _entryCtrl = AnimationController(
     vsync: this,
     duration: const Duration(milliseconds: 400),
   );
   _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
       .animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic));
   _fade = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeIn);
   _entryCtrl.forward();
   ```
4. In `dispose()`: `_entryCtrl.dispose();`
5. Wrap the `_XxxBody(...)` call in `builder:` with:
   ```dart
   FadeTransition(
     opacity: _fade,
     child: SlideTransition(position: _slide, child: _XxxBody(...)),
   )
   ```

---

## Task 7 — Animate `AuthPrimaryButton`

File: `parent/lib/features/auth/presentation/widgets/auth_primary_button.dart`

Convert to `StatefulWidget`. Add press-scale:
```dart
class AuthPrimaryButton extends StatefulWidget {
  const AuthPrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  State<AuthPrimaryButton> createState() => _AuthPrimaryButtonState();
}

class _AuthPrimaryButtonState extends State<AuthPrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressCtrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96)
        .animate(CurvedAnimation(parent: _pressCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressCtrl.forward(),
      onTapUp: (_) => _pressCtrl.reverse(),
      onTapCancel: () => _pressCtrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: SizedBox(
          width: double.infinity,
          height: 52.h,
          child: FilledButton(
            onPressed: widget.isLoading ? null : widget.onPressed,
            child: widget.isLoading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(
                      color: AppColors.darkTextPrimary,
                      strokeWidth: 2,
                    ),
                  )
                : Text(widget.label),
          ),
        ),
      ),
    );
  }
}
```

---

## Task 8 — Update Localization

### `parent/lib/l10n/app_en.arb` — update/add these keys:
```json
"loginTitle": "Parent Login",
"loginSubtitle": "Sign in to access your child's academic dashboard.",
"phoneNumberLabel": "Phone Number",
"phoneNumberHint": "Enter your phone number",
"sendOtpButton": "Send OTP",
"orgLoginLink": "Use organization email",
"phoneLoginSecurityNote": "Your parent account protects sensitive child information."
```
Keep all existing keys. Only update `loginTitle` and `loginSubtitle`; the rest are new.

### `parent/lib/l10n/app_ar.arb` — add Arabic for new keys:
```json
"loginTitle": "دخول ولي الأمر",
"loginSubtitle": "سجّل دخولك للاطلاع على لوحة متابعة طفلك الأكاديمية.",
"phoneNumberLabel": "رقم الهاتف",
"phoneNumberHint": "أدخل رقم هاتفك",
"sendOtpButton": "إرسال رمز التحقق",
"orgLoginLink": "استخدام بريد المؤسسة",
"phoneLoginSecurityNote": "حساب ولي الأمر يحمي بيانات طفلك الحساسة."
```

---

## Task 9 — Run Build Runner + Verify

```bash
cd parent
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
dart format --set-exit-if-changed .
flutter analyze
```

Fix all warnings and errors before marking done.

---

## Task 10 — Update project memory

Update `parent/.agent/project-memory.md`:
- Record that login screen was changed from email+password to phone+OTP
- Record `PhoneLoginCubit`, `SendOtpUseCase`, `send_otp_request_data.dart` were added
- Record that `OtpArgs.email` was renamed to `OtpArgs.identifier`
- Record that `OtpFlowType.login` was renamed to `OtpFlowType.phoneLogin`
- Record that entry animations were added to all 6 auth screens
- Record that `AuthPrimaryButton` now has press-scale animation

Update this spec status to `done`.
