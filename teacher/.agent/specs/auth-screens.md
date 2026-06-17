# Spec: Teacher Auth Screens
status: pending

## Context
The teacher Flutter app (`teacher/`) has only a `home` feature. This spec builds the complete auth feature from scratch. The design mirrors the **fixed parent** auth flow (phone + OTP), with teacher-specific copy. The backend is not ready — all remote data source methods throw `UnimplementedError`.

The parent project's fixed `auth-login-fix.md` spec defines the canonical phone+OTP login design. Follow the same patterns here; adjust role-specific strings only.

---

## Screens (6 total)
| Screen | File | Flow |
|---|---|---|
| Login | `login_screen.dart` | phone + OTP → home |
| Org Email Login | `org_email_login_screen.dart` | email + password → home |
| OTP Verification | `otp_verification_screen.dart` | verify code → home OR reset password |
| Forgot Password | `forgot_password_screen.dart` | email → OTP |
| Reset Password | `reset_password_screen.dart` | new password → login |
| Biometric Unlock | `biometric_unlock_screen.dart` | fingerprint/face → home |

---

## Package to Add

In `teacher/pubspec.yaml`:
```yaml
local_auth: ^2.3.0
```

Android/iOS permissions — same as student spec.

---

## File Structure to Create

```
teacher/lib/features/auth/
  data/
    datasources/remote/auth_remote_datasource.dart
    models/
      login_request_data.dart + .g.dart
      login_response_data.dart + .g.dart
      send_otp_request_data.dart + .g.dart
      otp_verify_request_data.dart + .g.dart
      otp_verify_response_data.dart + .g.dart
      forgot_password_request_data.dart + .g.dart
      reset_password_request_data.dart + .g.dart
    repositories/auth_repository_impl.dart
  domain/
    entities/auth_token.dart
    repositories/auth_repository.dart
    usecases/
      send_otp_usecase.dart
      login_usecase.dart         ← org email login
      verify_otp_usecase.dart
      forgot_password_usecase.dart
      reset_password_usecase.dart
  presentation/
    cubit/
      phone_login/phone_login_cubit.dart + phone_login_state.dart + .freezed.dart
      login/login_cubit.dart + login_state.dart + .freezed.dart
      otp/otp_cubit.dart + otp_state.dart + .freezed.dart
      forgot_password/forgot_password_cubit.dart + state + .freezed.dart
      reset_password/reset_password_cubit.dart + state + .freezed.dart
      biometric/biometric_cubit.dart + biometric_state.dart + .freezed.dart
    screens/
      login_screen.dart
      org_email_login_screen.dart
      otp_verification_screen.dart
      otp_args.dart
      otp_flow_type.dart
      forgot_password_screen.dart
      reset_password_screen.dart
      reset_password_args.dart
      biometric_unlock_screen.dart
    widgets/
      auth_surface.dart
      auth_text_field.dart
      auth_primary_button.dart
      auth_otp_fields.dart
```

---

## Data Layer

### Models

**`send_otp_request_data.dart`** — copy from `parent/lib/features/auth/data/models/send_otp_request_data.dart` exactly.

**`login_request_data.dart`** — `{ email, password }` (for org email login):
```dart
@JsonSerializable()
class LoginRequestData {
  const LoginRequestData({required this.email, required this.password});
  final String email;
  final String password;
  // fromJson / toJson
}
```

All other models (`login_response_data`, `otp_verify_request_data`, `otp_verify_response_data`, `forgot_password_request_data`, `reset_password_request_data`) — copy from student spec.

### `auth_remote_datasource.dart`

```dart
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._apiClient);
  final ApiClient _apiClient;
  // ignore: unused_field

  Future<void> sendOtp(String countryCode, String phone) async {
    throw UnimplementedError('sendOtp not implemented'); // TODO: wire up when backend is ready
  }

  Future<LoginResponseData> orgLogin(String email, String password) async {
    throw UnimplementedError('orgLogin not implemented');
  }

  Future<OtpVerifyResponseData> verifyOtp(String identifier, String otp) async {
    throw UnimplementedError('verifyOtp not implemented');
  }

  Future<void> forgotPassword(String email) async {
    throw UnimplementedError('forgotPassword not implemented');
  }

  Future<void> resetPassword(String token, String newPassword, String confirmPassword) async {
    throw UnimplementedError('resetPassword not implemented');
  }
}
```

### `auth_repository_impl.dart`
Copy generic `_authResult<T>`, `_voidResult`, and `_fromDio` helpers from the fixed parent. Add `sendOtp` and `orgLogin` in addition to the student methods.

---

## Domain Layer

### `auth_repository.dart`
```dart
abstract interface class AuthRepository {
  Future<ApiResult<void>> sendOtp(String countryCode, String phone);
  Future<ApiResult<AuthToken>> orgLogin(String email, String password);
  Future<ApiResult<AuthToken>> verifyOtp(String identifier, String otp);
  Future<ApiResult<void>> forgotPassword(String email);
  Future<ApiResult<void>> resetPassword(String token, String newPassword, String confirmPassword);
}
```

`auth_token.dart` — copy from student spec (identical).

### Usecases
- `SendOtpUseCase` — copy from `parent/lib/features/auth/domain/usecases/send_otp_usecase.dart`
- `LoginUseCase` — calls `orgLogin(email, password)`
- `VerifyOtpUseCase`, `ForgotPasswordUseCase`, `ResetPasswordUseCase` — copy from student

---

## Presentation Layer

### Cubit States

**`phone_login_state.dart`** — `initial / loading / sent / error(String)` — copy from parent.
**`login_state.dart`** — `initial / loading / success(AuthToken) / error(String)` — same as student.
**`otp_state.dart`**, **`forgot_password_state.dart`**, **`reset_password_state.dart`**, **`biometric_state.dart`** — copy from student.

### Cubits

**`phone_login_cubit.dart`** — copy from parent (uses `SendOtpUseCase`).
**`login_cubit.dart`** — handles org email login via `LoginUseCase.call(email, password)` → emits `LoginState.success(token)`.
All other cubits — copy from student.

---

## Shared Widgets

Copy all four from parent exactly:
- `auth_surface.dart`
- `auth_text_field.dart`
- `auth_otp_fields.dart`
- `auth_primary_button.dart` — with press-scale animation (see parent spec Task 7)

---

## Screens

### Entry Animation (ALL screens)
Same pattern as student and parent. Every `_XxxView` state:
- `with SingleTickerProviderStateMixin`
- `_entryCtrl` (400 ms), `_slide` (offset 0→0 from 0.06), `_fade`
- `_entryCtrl.forward()` in `initState`
- Wrap body in `FadeTransition` + `SlideTransition`

### `OtpFlowType` and `OtpArgs` (teacher — same as fixed parent)
```dart
// otp_flow_type.dart
enum OtpFlowType { phoneLogin, forgotPassword }

// otp_args.dart
class OtpArgs {
  const OtpArgs({required this.identifier, required this.flow});
  final String identifier; // phone+countryCode for phoneLogin, email for forgotPassword
  final OtpFlowType flow;
}
```

### `login_screen.dart` (phone + OTP)

Layout identical to fixed parent `login_screen.dart`, with teacher copy:
- Title: `context.l10n.loginTitle` ("Teacher Login")
- Subtitle: `context.l10n.loginSubtitle` ("Access your classroom dashboard.")
- Country-code dropdown + phone field
- `AuthPrimaryButton` "Send OTP" → `PhoneLoginCubit.sendOtp(countryCode, phone)`
- On `PhoneLoginState.sent` → push `OtpArgs(identifier: '$countryCode$phone', flow: OtpFlowType.phoneLogin)`
- `OutlinedButton` "Use organization email" → push `AppRouteNames.orgEmailLogin`
- `TextButton` "Forgot password?" → push `AppRouteNames.forgotPassword`
- Security note at bottom: `context.l10n.phoneLoginSecurityNote`

`BlocProvider(create: (_) => getIt<PhoneLoginCubit>(), child: const _LoginView())`

`AuthSurface(isBack: false, child: ...)`

### `org_email_login_screen.dart`

Layout identical to parent `org_email_login_screen.dart`, with teacher subtitle:
- `AuthBrandMark(compact: true)`
- Title: `orgLoginTitle`, Subtitle: `orgLoginSubtitle` ("Enter your school email to continue")
- Email field + Password field
- `AuthPrimaryButton` "Continue" → `LoginCubit.orgLogin(email, password)`
- On `LoginState.success` → `pushReplacementNamed(AppRouteNames.home)`

`BlocProvider(create: (_) => getIt<LoginCubit>(), child: const _OrgEmailLoginView())`
`AuthSurface(isBack: true, centered: true, child: ...)`

### `otp_verification_screen.dart`

Copy from fixed parent. Key differences from student:
- Uses `identifier` not `email`
- Resend: `if flow == phoneLogin` → `PhoneLoginCubit.sendOtp` else `ForgotPasswordCubit`
- Default: `OtpArgs(identifier: '', flow: OtpFlowType.phoneLogin)`
- `MultiBlocProvider` includes `PhoneLoginCubit` + `OtpCubit` + `ForgotPasswordCubit`
- `BlocListener<PhoneLoginCubit>` for phone resend snackbar

### `forgot_password_screen.dart`

Copy from parent exactly. Uses `OtpArgs(identifier: email, flow: OtpFlowType.forgotPassword)`.

### `reset_password_screen.dart`

Copy from parent/student exactly. Uses `ResetPasswordArgs(token: ...)`.

### `biometric_unlock_screen.dart`

Copy from parent/student exactly.

---

## Files to Modify

### `teacher/lib/core/errors/failures.dart`
Add `ServerFailure`:
```dart
final class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}
```

### `teacher/lib/core/network/api_endpoints.dart`
Add:
```dart
static const String sendOtp = '/auth/send-otp';
static const String orgLogin = '/auth/org-login';
static const String verifyOtp = '/auth/verify-otp';
static const String forgotPassword = '/auth/forgot-password';
static const String resetPassword = '/auth/reset-password';
```

### `teacher/lib/core/network/api_client.dart`
Add auth methods (same as parent — includes `sendOtp` and `orgLogin`):
```dart
@POST(ApiEndpoints.sendOtp)
Future<void> sendOtp(@Body() SendOtpRequestData request);

@POST(ApiEndpoints.orgLogin)
Future<LoginResponseData> orgLogin(@Body() LoginRequestData request);

@POST(ApiEndpoints.verifyOtp)
Future<OtpVerifyResponseData> verifyOtp(@Body() OtpVerifyRequestData request);

@POST(ApiEndpoints.forgotPassword)
Future<void> forgotPassword(@Body() ForgotPasswordRequestData request);

@POST(ApiEndpoints.resetPassword)
Future<void> resetPassword(@Body() ResetPasswordRequestData request);
```

### `teacher/lib/core/constants/app_route_names.dart`
```dart
abstract final class AppRouteNames {
  static const String home = '/';
  static const String login = '/login';
  static const String orgEmailLogin = '/login/org-email';
  static const String otpVerification = '/otp-verification';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String biometricUnlock = '/biometric-unlock';
}
```

### `teacher/lib/app/app.dart`
- `initialRoute: AppRouteNames.login`
- Register all 6 auth routes + existing `home` route

### `teacher/lib/core/di/dependency_injection.dart`
```dart
// Auth
..registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(getIt()))
..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()))
..registerLazySingleton<SendOtpUseCase>(() => SendOtpUseCase(getIt()))
..registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()))
..registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(getIt()))
..registerLazySingleton<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(getIt()))
..registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase(getIt()))
..registerFactory<PhoneLoginCubit>(() => PhoneLoginCubit(getIt()))
..registerFactory<LoginCubit>(() => LoginCubit(getIt()))
..registerFactory<OtpCubit>(() => OtpCubit(getIt()))
..registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(getIt()))
..registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(getIt()))
..registerFactory<BiometricCubit>(BiometricCubit.new)
```

### `teacher/lib/l10n/app_en.arb`
Add all auth strings (same keys as parent, with teacher-specific copy):
```json
"loginTitle": "Teacher Login",
"loginSubtitle": "Access your classroom dashboard.",
"phoneNumberLabel": "Phone Number",
"phoneNumberHint": "Enter your phone number",
"sendOtpButton": "Send OTP",
"orgLoginLink": "Use organization email",
"orgLoginTitle": "Organization login",
"orgLoginSubtitle": "Enter your school email to continue",
"orgLoginButton": "Continue",
"phoneLoginSecurityNote": "Your teacher account is tied to your school credentials.",
"emailLabel": "Email",
"emailHint": "Enter your email",
"passwordLabel": "Password",
"passwordHint": "Enter your password",
"forgotPasswordLink": "Forgot password?",
"otpTitle": "Verify your identity",
"otpSubtitle": "We sent a 6-digit code to {identifier}",
"@otpSubtitle": { "placeholders": { "identifier": {} } },
"otpResend": "Resend code",
"otpVerifyButton": "Verify",
"forgotPasswordTitle": "Forgot password?",
"forgotPasswordSubtitle": "Enter your email and we will send you a reset code",
"sendResetLinkButton": "Send reset code",
"resetPasswordTitle": "Reset password",
"newPasswordLabel": "New password",
"newPasswordHint": "Enter new password",
"confirmPasswordLabel": "Confirm password",
"confirmPasswordHint": "Re-enter new password",
"resetPasswordButton": "Reset password",
"passwordMismatch": "Passwords do not match",
"biometricTitle": "Welcome back",
"biometricSubtitle": "Use biometrics to unlock",
"biometricPrompt": "Authenticate to access Scolair",
"usePasswordFallback": "Use password instead",
"authErrorInvalidCredentials": "Incorrect credentials",
"authErrorOtpInvalid": "Invalid or expired code",
"authErrorGeneric": "Something went wrong. Please try again"
```

### `teacher/lib/l10n/app_ar.arb`
Translate all new keys to Arabic (copy from parent `app_ar.arb`; adjust teacher-specific strings):
```json
"loginTitle": "دخول المعلم",
"loginSubtitle": "ادخل إلى لوحة الفصل الدراسي.",
"orgLoginSubtitle": "أدخل بريد مدرستك للمتابعة",
"phoneLoginSecurityNote": "حسابك كمعلم مرتبط ببيانات اعتماد مدرستك."
```
All other keys — same Arabic translations as parent `app_ar.arb`.

---

## Verification

```bash
cd teacher
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
dart format --set-exit-if-changed .
flutter analyze
```

Fix all issues. Then:
- Create `teacher/.agent/project-memory.md` recording all auth files created
- Update this spec status → `done`
