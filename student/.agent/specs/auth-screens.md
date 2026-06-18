# Spec: Student Auth Screens
status: pending

## Context
The student Flutter app (`student/`) has only a `home` feature. This spec builds the complete auth feature from scratch: data layer (stubbed), domain layer, presentation layer (Cubit + Freezed), and 5 screens. The backend is not ready — all remote data source methods throw `UnimplementedError` with a TODO comment.

Before writing any UI code, **fetch the Stitch design** using the Stitch MCP:
- Student Login (Refined): `323c143486cb4137a3ed7e6ea75ab174`

Use the parent project (`parent/lib/features/auth/`) as the reference implementation for non-login screens. Copy class/widget names exactly so all three apps stay consistent.

---

## Screens (5 total)
| Screen | File | Flow |
|---|---|---|
| Login | `login_screen.dart` | email + password → home |
| OTP Verification | `otp_verification_screen.dart` | verify code → home OR reset password |
| Forgot Password | `forgot_password_screen.dart` | email → OTP screen |
| Reset Password | `reset_password_screen.dart` | new password → login |
| Biometric Unlock | `biometric_unlock_screen.dart` | fingerprint/face → home |

No `org_email_login_screen.dart` — students do not have an org portal login.

---

## Package to Add

In `student/pubspec.yaml`, add:
```yaml
local_auth: ^2.3.0
```

Run `flutter pub get` after adding.

For Android: add to `student/android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>
<uses-permission android:name="android.permission.USE_FINGERPRINT"/>
```

For iOS: add to `student/ios/Runner/Info.plist`:
```xml
<key>NSFaceIDUsageDescription</key>
<string>Authenticate to access Scolair</string>
```

---

## File Structure to Create

```
student/lib/features/auth/
  data/
    datasources/
      remote/
        auth_remote_datasource.dart
    models/
      login_request_data.dart
      login_request_data.g.dart          ← generated
      login_response_data.dart
      login_response_data.g.dart         ← generated
      otp_verify_request_data.dart
      otp_verify_request_data.g.dart     ← generated
      otp_verify_response_data.dart
      otp_verify_response_data.g.dart    ← generated
      forgot_password_request_data.dart
      forgot_password_request_data.g.dart ← generated
      reset_password_request_data.dart
      reset_password_request_data.g.dart  ← generated
    repositories/
      auth_repository_impl.dart
  domain/
    entities/
      auth_token.dart
    repositories/
      auth_repository.dart
    usecases/
      login_usecase.dart
      verify_otp_usecase.dart
      forgot_password_usecase.dart
      reset_password_usecase.dart
  presentation/
    cubit/
      login/
        login_cubit.dart
        login_state.dart
        login_state.freezed.dart         ← generated
      otp/
        otp_cubit.dart
        otp_state.dart
        otp_state.freezed.dart           ← generated
      forgot_password/
        forgot_password_cubit.dart
        forgot_password_state.dart
        forgot_password_state.freezed.dart ← generated
      reset_password/
        reset_password_cubit.dart
        reset_password_state.dart
        reset_password_state.freezed.dart  ← generated
      biometric/
        biometric_cubit.dart
        biometric_state.dart
        biometric_state.freezed.dart       ← generated
    screens/
      login_screen.dart
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

**`login_request_data.dart`**
```dart
@JsonSerializable()
class LoginRequestData {
  const LoginRequestData({required this.email, required this.password});
  final String email;
  final String password;
  factory LoginRequestData.fromJson(Map<String, dynamic> json) => _$LoginRequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestDataToJson(this);
}
```

**`login_response_data.dart`**
```dart
@JsonSerializable()
class LoginResponseData {
  const LoginResponseData({required this.accessToken, required this.refreshToken});
  @JsonKey(name: 'access_token') final String accessToken;
  @JsonKey(name: 'refresh_token') final String refreshToken;
  factory LoginResponseData.fromJson(Map<String, dynamic> json) => _$LoginResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}
```

**`otp_verify_request_data.dart`**
```dart
@JsonSerializable()
class OtpVerifyRequestData {
  const OtpVerifyRequestData({required this.email, required this.otp});
  final String email;
  final String otp;
  // fromJson / toJson
}
```

**`otp_verify_response_data.dart`**
```dart
@JsonSerializable()
class OtpVerifyResponseData {
  const OtpVerifyResponseData({required this.accessToken, required this.refreshToken});
  @JsonKey(name: 'access_token') final String accessToken;
  @JsonKey(name: 'refresh_token') final String refreshToken;
  // fromJson / toJson
}
```

**`forgot_password_request_data.dart`**
```dart
@JsonSerializable()
class ForgotPasswordRequestData {
  const ForgotPasswordRequestData({required this.email});
  final String email;
  // fromJson / toJson
}
```

**`reset_password_request_data.dart`**
```dart
@JsonSerializable()
class ResetPasswordRequestData {
  const ResetPasswordRequestData({
    required this.token,
    required this.newPassword,
    required this.confirmPassword,
  });
  final String token;
  @JsonKey(name: 'new_password') final String newPassword;
  @JsonKey(name: 'confirm_password') final String confirmPassword;
  // fromJson / toJson
}
```

### `auth_remote_datasource.dart`
```dart
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._apiClient);
  final ApiClient _apiClient;
  // ignore: unused_field

  Future<LoginResponseData> login(String email, String password) async {
    throw UnimplementedError('login not implemented'); // TODO: wire up when backend is ready
  }

  Future<OtpVerifyResponseData> verifyOtp(String email, String otp) async {
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
Use the same generic helper pattern as the parent project. Copy `_authResult<T>` and `_voidResult` helpers, and `_fromDio` error mapping from `parent/lib/features/auth/data/repositories/auth_repository_impl.dart`.

---

## Domain Layer

### `auth_token.dart`
```dart
class AuthToken {
  const AuthToken({required this.accessToken, required this.refreshToken});
  final String accessToken;
  final String refreshToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthToken &&
          other.accessToken == accessToken &&
          other.refreshToken == refreshToken;

  @override
  int get hashCode => Object.hash(accessToken, refreshToken);
}
```

### `auth_repository.dart`
```dart
abstract interface class AuthRepository {
  Future<ApiResult<AuthToken>> login(String email, String password);
  Future<ApiResult<AuthToken>> verifyOtp(String email, String otp);
  Future<ApiResult<void>> forgotPassword(String email);
  Future<ApiResult<void>> resetPassword(String token, String newPassword, String confirmPassword);
}
```

### Usecases
Each is a single-method class calling one repository method. Pattern:
```dart
class LoginUseCase {
  const LoginUseCase(this._repository);
  final AuthRepository _repository;
  Future<ApiResult<AuthToken>> call(String email, String password) =>
      _repository.login(email, password);
}
```
Apply same pattern for `VerifyOtpUseCase`, `ForgotPasswordUseCase`, `ResetPasswordUseCase`.

---

## Presentation Layer

### Cubit States (Freezed)

**`login_state.dart`**
```dart
@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(AuthToken token) = _Success;
  const factory LoginState.error(String message) = _Error;
}
```

**`otp_state.dart`** — same shape, `success(AuthToken token)`
**`forgot_password_state.dart`** — `initial / loading / sent / error(String)`
**`reset_password_state.dart`** — `initial / loading / success / error(String)`
**`biometric_state.dart`** — `initial / checking / authenticated / unavailable / failed`

### Cubits

**`login_cubit.dart`**
```dart
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._login) : super(const LoginState.initial());
  final LoginUseCase _login;

  Future<void> login(String email, String password) async {
    emit(const LoginState.loading());
    final result = await _login(email, password);
    result.when(
      success: (token) => emit(LoginState.success(token)),
      failure: (f) => emit(LoginState.error(f.message)),
    );
  }
}
```

**`otp_cubit.dart`** — `verify(String email, String otp)` → calls `VerifyOtpUseCase`

**`forgot_password_cubit.dart`** — `sendResetCode(String email)` → calls `ForgotPasswordUseCase`; emits `sent` on success

**`reset_password_cubit.dart`** — `reset(String token, String newPass, String confirm)` → calls `ResetPasswordUseCase`

**`biometric_cubit.dart`** — uses `local_auth`; `checkAndAuthenticate(String reason)`:
```dart
final _auth = LocalAuthentication();

Future<void> checkAndAuthenticate(String reason) async {
  emit(const BiometricState.checking());
  final canAuth = await _auth.canCheckBiometrics;
  if (!canAuth) { emit(const BiometricState.unavailable()); return; }
  final authenticated = await _auth.authenticate(
    localizedReason: reason,
    options: const AuthenticationOptions(biometricOnly: true),
  );
  emit(authenticated ? const BiometricState.authenticated() : const BiometricState.failed());
}
```

---

## Shared Widgets

Copy these four files **exactly** from the parent project (they are identical):
- `auth_surface.dart` from `parent/lib/features/auth/presentation/widgets/auth_surface.dart`
- `auth_text_field.dart` from `parent/lib/features/auth/presentation/widgets/auth_text_field.dart`
- `auth_otp_fields.dart` from `parent/lib/features/auth/presentation/widgets/auth_otp_fields.dart`

**`auth_primary_button.dart`** — copy from parent BUT ensure it has the press-scale animation (the parent version will have been updated by `auth-login-fix.md` spec). If the parent version still lacks the animation, implement it here too:
- Convert to `StatefulWidget` with `SingleTickerProviderStateMixin`
- `AnimationController` 100 ms, `Curves.easeInOut`
- `GestureDetector` `onTapDown` → `forward()`, `onTapUp`/`onTapCancel` → `reverse()`
- Wrap `FilledButton` in `ScaleTransition(scale: Tween(1.0, 0.96).animate(ctrl))`

---

## Screens

### Entry Animation (ALL screens)

Every `_XxxView` state class must add `with SingleTickerProviderStateMixin` and this pattern:

```dart
late AnimationController _entryCtrl;
late Animation<Offset> _slide;
late Animation<double> _fade;

@override
void initState() {
  super.initState();
  _entryCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
      .animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic));
  _fade = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeIn);
  _entryCtrl.forward();
}

@override
void dispose() {
  _entryCtrl.dispose();
  // ... other dispose
  super.dispose();
}
```

Wrap `_XxxBody(...)` in:
```dart
FadeTransition(opacity: _fade, child: SlideTransition(position: _slide, child: _XxxBody(...)))
```

### `login_screen.dart`

Fetch Stitch design `323c143486cb4137a3ed7e6ea75ab174` for exact spacing and visual details.

Expected layout:
1. `AuthBrandMark(label: context.l10n.appName)`
2. `SizedBox(height: 36.h)`
3. `AuthCard` containing `Form`:
   - Title: `context.l10n.loginTitle`
   - Subtitle: `context.l10n.loginSubtitle` (secondary color)
   - `SizedBox(height: 22.h)`
   - `AuthTextField` email (person_outline icon, emailAddress keyboard, next action)
   - `SizedBox(height: 14.h)`
   - `AuthTextField` password (lock_outline prefix, visibility toggle suffix, done action)
   - `Align(end)` `TextButton` "Forgot password?" → push `AppRouteNames.forgotPassword`
   - `SizedBox(height: 8.h)`
   - `AuthPrimaryButton` label `loginButton` → `LoginCubit.login(email, password)`

**No org email login link** — student login has no org portal.

`BlocProvider(create: (_) => getIt<LoginCubit>(), child: const _LoginView())`

On `LoginState.success` → `Navigator.pushReplacementNamed(context, AppRouteNames.home)`
On `LoginState.error` → SnackBar with `context.l10n.authErrorInvalidCredentials`

`AuthSurface(isBack: false, child: _LoginBody(...))`

### `otp_verification_screen.dart`

**`OtpFlowType`** for student:
```dart
enum OtpFlowType { login, forgotPassword }
```

**`OtpArgs`** for student:
```dart
class OtpArgs {
  const OtpArgs({required this.email, required this.flow});
  final String email;
  final OtpFlowType flow;
}
```

Screen behavior:
- `MultiBlocProvider` providing `OtpCubit` + `ForgotPasswordCubit`
- OTP code verified via `OtpCubit.verify(email, otp)`
- On `OtpState.success(token)`:
  - If `flow == OtpFlowType.forgotPassword` → push `AppRouteNames.resetPassword` with `ResetPasswordArgs(token: token.accessToken)`
  - Else → `pushReplacementNamed(AppRouteNames.home)`
- Resend → `ForgotPasswordCubit.sendResetCode(email)`
- `BlocListener<ForgotPasswordCubit>` → snackbar on sent/error
- `AuthSurface(isBack: true, centered: true, child: _OtpBody(...))`
- `_OtpBody`: `AuthHeader(title, subtitle: otpSubtitle(email), icon: Icons.lock_person_outlined)` + `AuthCard` with `AuthOtpFields` + `TextButton.icon` resend + `AuthPrimaryButton` verify

### `forgot_password_screen.dart`

Copy from parent exactly (class names identical). Only difference: uses student's `OtpArgs(email: ..., flow: OtpFlowType.forgotPassword)`.

Layout: `AuthBrandMark(compact: true)` + `AuthCard` with email field + send button.

### `reset_password_screen.dart`

Copy from parent exactly. Uses `ResetPasswordArgs(token: ...)`.

```dart
class ResetPasswordArgs {
  const ResetPasswordArgs({required this.token});
  final String token;
}
```

### `biometric_unlock_screen.dart`

Copy from parent exactly. Triggers `BiometricCubit.checkAndAuthenticate(context.l10n.biometricPrompt)` in `initState` via `WidgetsBinding.instance.addPostFrameCallback`.

On `BiometricState.authenticated` → `pushReplacementNamed(AppRouteNames.home)`
On `BiometricState.unavailable` → `pushReplacementNamed(AppRouteNames.login)`
On `BiometricState.failed` → show retry button

---

## Files to Modify

### `student/lib/core/errors/failures.dart`
Add `ServerFailure` between `NetworkFailure` and `CacheFailure`:
```dart
final class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}
```

### `student/lib/core/network/api_endpoints.dart`
Add:
```dart
static const String login = '/auth/login';
static const String verifyOtp = '/auth/verify-otp';
static const String forgotPassword = '/auth/forgot-password';
static const String resetPassword = '/auth/reset-password';
```

### `student/lib/core/network/api_client.dart`
Add auth methods (copy from parent, exclude `sendOtp` and `orgLogin`):
```dart
import '../../features/auth/data/models/login_request_data.dart';
import '../../features/auth/data/models/login_response_data.dart';
import '../../features/auth/data/models/otp_verify_request_data.dart';
import '../../features/auth/data/models/otp_verify_response_data.dart';
import '../../features/auth/data/models/forgot_password_request_data.dart';
import '../../features/auth/data/models/reset_password_request_data.dart';

@POST(ApiEndpoints.login)
Future<LoginResponseData> login(@Body() LoginRequestData request);

@POST(ApiEndpoints.verifyOtp)
Future<OtpVerifyResponseData> verifyOtp(@Body() OtpVerifyRequestData request);

@POST(ApiEndpoints.forgotPassword)
Future<void> forgotPassword(@Body() ForgotPasswordRequestData request);

@POST(ApiEndpoints.resetPassword)
Future<void> resetPassword(@Body() ResetPasswordRequestData request);
```

### `student/lib/core/constants/app_route_names.dart`
```dart
abstract final class AppRouteNames {
  static const String home = '/';
  static const String login = '/login';
  static const String otpVerification = '/otp-verification';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String biometricUnlock = '/biometric-unlock';
}
```

### `student/lib/app/app.dart`
- Import all screen files
- Change `initialRoute: AppRouteNames.login`
- Add routes:
  ```dart
  routes: {
    AppRouteNames.home: (_) => const HomeScreen(),
    AppRouteNames.login: (_) => const LoginScreen(),
    AppRouteNames.otpVerification: (_) => const OtpVerificationScreen(),
    AppRouteNames.forgotPassword: (_) => const ForgotPasswordScreen(),
    AppRouteNames.resetPassword: (_) => const ResetPasswordScreen(),
    AppRouteNames.biometricUnlock: (_) => const BiometricUnlockScreen(),
  },
  ```

### `student/lib/core/di/dependency_injection.dart`
Add after existing registrations:
```dart
// Auth
..registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(getIt()))
..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()))
..registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()))
..registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(getIt()))
..registerLazySingleton<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(getIt()))
..registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase(getIt()))
..registerFactory<LoginCubit>(() => LoginCubit(getIt()))
..registerFactory<OtpCubit>(() => OtpCubit(getIt()))
..registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(getIt()))
..registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(getIt()))
..registerFactory<BiometricCubit>(BiometricCubit.new)
```

### `student/lib/l10n/app_en.arb`
Add all auth string keys (merge with existing home keys):
```json
"loginTitle": "Student Login",
"loginSubtitle": "Sign in to access your academic workspace.",
"emailLabel": "Email",
"emailHint": "Enter your email",
"passwordLabel": "Password",
"passwordHint": "Enter your password",
"forgotPasswordLink": "Forgot password?",
"loginButton": "Log in",
"orgLoginTitle": "Organization login",
"orgLoginSubtitle": "Enter your organization email to continue",
"orgLoginButton": "Continue",
"otpTitle": "Verify your email",
"otpSubtitle": "We sent a 6-digit code to {email}",
"@otpSubtitle": { "placeholders": { "email": {} } },
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
"biometricSubtitle": "Use biometrics to sign in",
"biometricPrompt": "Authenticate to access Scolair",
"usePasswordFallback": "Use password instead",
"authErrorInvalidCredentials": "Incorrect email or password",
"authErrorOtpInvalid": "Invalid or expired code",
"authErrorGeneric": "Something went wrong. Please try again"
```

### `student/lib/l10n/app_ar.arb`
Create this file if it does not exist. Add Arabic for all the above keys (copy and translate from parent `app_ar.arb`; change role-specific text):
```json
{
  "@@locale": "ar",
  "appName": "سكولير",
  "loginTitle": "دخول الطالب",
  "loginSubtitle": "سجّل دخولك للوصول إلى مساحة عملك الأكاديمية.",
  "biometricSubtitle": "استخدم المقاييس الحيوية لتسجيل الدخول"
  // ... plus all other keys translated from parent app_ar.arb
}
```

---

## Verification

```bash
cd student
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
dart format --set-exit-if-changed .
flutter analyze
```

Fix all warnings and errors. Then update:
- `student/.agent/project-memory.md` (create if missing) — record all auth files created
- This spec status → `done`
