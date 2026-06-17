# Auth Screens — Parent

Status: `done`

---

## Goal

Implement the full parent authentication flow as a `features/auth` feature following the project clean-architecture rules. This includes 6 screens from the Stitch design, the full data/domain/presentation layer, DI registration, route wiring, and localization strings. Backend APIs are not ready — all remote datasource calls must be stubbed with `throw UnimplementedError('TODO: wire up when backend is ready')` so the full contract is in place but nothing crashes at runtime. The UI must match the Stitch designs exactly.

---

## Pre-Implementation Step — Fetch Stitch Designs

**Before writing any screen code**, use the Stitch MCP to fetch all 6 screens. Use `curl -L` on each hosted URL the MCP returns to download images and inspect code/specs.

Stitch project:
- **Title:** Scolair LMS App
- **Project ID:** `16421847842765854662`

Screens to fetch:

| Screen name | Screen ID |
|---|---|
| Parent Login | `749a1579a2a94d118ce818ca57623edf` |
| Organization Email Login | `b4cfc43a9d624982a0725a0b3bc74b94` |
| Parent OTP Verification | `5a385e1fa6c54ceb8481c36fd78e0a60` |
| Parent Reset Password | `7531d6a662d3498a9b169df888d178dc` |
| Parent Forgot Password | `bda43af4add648ca8e52e7e5b36b5c2d` |
| Biometric Unlock | `fd1a5cbcdb484ec093938b487992cebc` |

Study each design for: layout, colors (match `AppColors`), typography (match `AppTextStyles`), spacing values in `.w`/`.h`/`.sp`/`.r` units, illustrations or SVG assets, button states, field states, animations, and any transition hints.

---

## Success Criteria

- All 6 screens render pixel-close to the Stitch designs.
- All 6 screens are navigable following the flow below.
- Full clean-architecture layer exists for auth (data / domain / presentation).
- All data calls are stubbed — no crash, no real API call.
- DI registers auth dependencies without errors at app start.
- **Every screen dart file is under 250 lines.** Extract sub-widgets into private classes or separate files in `presentation/widgets/` to stay within this limit.
- `flutter analyze` passes with zero issues.
- `dart format --set-exit-if-changed .` passes.
- `dart run build_runner build --delete-conflicting-outputs` produces valid generated files.
- `dart run build_runner build --delete-conflicting-outputs` produces valid generated files.
- All user-visible strings use `context.l10n.*` — no hardcoded English inside widgets.
- RTL-safe: no hardcoded `left`/`right` alignment or padding.

---

## Screen File Size Rule

**Hard limit: no screen dart file may exceed 250 lines.**

To stay within this limit:
- Extract every repeated or sizeable chunk of UI into a private `_Widget` class at the bottom of the same file, or into a named file in `presentation/widgets/` if used by more than one screen.
- Keep the `build` method of `_XxxView` under ~30 lines by delegating to extracted widgets.
- Shared elements (logo header, form footer links, error banners) must be extracted into `presentation/widgets/` and reused across screens.
- Do not duplicate widget code between screen files.

---

## Navigation Flow

```
App start
  └─► Login Screen  (initialRoute = '/login')
        ├─► [login success] ──────────────────────────────► Home Screen
        ├─► [needs OTP] ──────────────────────────────────► OTP Verification Screen
        │                                                       └─► [verified] ──► Home Screen
        ├─► "Login with org email" ────────────────────────► Org Email Login Screen
        │                                                       ├─► [success] ───► Home Screen
        │                                                       └─► [back] ──────► Login Screen
        └─► "Forgot password?" ───────────────────────────► Forgot Password Screen
                                                                └─► [email sent] ► OTP Verification Screen
                                                                                      └─► [verified] ─► Reset Password Screen
                                                                                                            └─► [success] ──► Login Screen

Biometric Unlock Screen  (shown when app resumes with saved token + biometric enabled)
  ├─► [success] ──► Home Screen
  └─► "Use password" ──► Login Screen
```

---

## Package to Add

Add to `parent/pubspec.yaml` under `dependencies`:

```yaml
local_auth: ^2.3.0
```

Check pub.dev for the latest stable version compatible with the project Flutter SDK (`^3.12.0`) before adding.

---

## Scope

In scope:
- `lib/features/auth/` — full feature folder (data, domain, presentation).
- `lib/core/network/api_client.dart` — add auth API method stubs.
- `lib/core/network/api_endpoints.dart` — add auth endpoint constants.
- `lib/core/constants/app_route_names.dart` — add 6 auth route constants.
- `lib/app/app.dart` — register 6 new routes; change `initialRoute` to `AppRouteNames.login`.
- `lib/core/di/dependency_injection.dart` — register auth classes.
- `lib/l10n/app_en.arb` and `lib/l10n/app_ar.arb` — add all auth string keys.
- `parent/pubspec.yaml` — add `local_auth`.

Out of scope:
- Token persistence / auto-login logic.
- Real biometric gating at app startup.
- The Home screen itself.

---

## Task Checklist

- [x] Read `.agent/project-rules.md`.
- [x] Read `.agent/project-memory.md`.
- [x] Fetch all 6 Stitch screens via the Stitch MCP. Study layouts, colors, spacing, animations.
- [x] Add `local_auth` to `pubspec.yaml`. Run `flutter pub get`.
- [x] **Data layer** — create models, remote datasource, repository impl.
- [x] **Domain layer** — create entity, repository contract, use cases.
- [x] Run `dart run build_runner build --delete-conflicting-outputs`.
- [x] **Shared auth widgets** — `auth_text_field.dart`, `auth_primary_button.dart`, plus any shared layout widgets extracted from the Stitch designs.
- [x] **Screens** — implement all 6, each under 250 lines, extracting sub-widgets as needed.
- [x] **Core updates** — api_client stubs, api_endpoints, route names, DI, app.dart, ARB strings.
- [x] Run `dart format --set-exit-if-changed .`.
- [x] Run `flutter analyze`. Fix all issues.
- [x] Update this spec status to `done`.
- [x] Update `.agent/project-memory.md`.

---

## Files to Create

```
parent/lib/features/auth/
├── data/
│   ├── datasources/remote/auth_remote_datasource.dart
│   ├── models/
│   │   ├── login_request_data.dart + .g.dart
│   │   ├── login_response_data.dart + .g.dart
│   │   ├── otp_verify_request_data.dart + .g.dart
│   │   ├── otp_verify_response_data.dart + .g.dart
│   │   ├── forgot_password_request_data.dart + .g.dart
│   │   └── reset_password_request_data.dart + .g.dart
│   └── repositories/auth_repository_impl.dart
├── domain/
│   ├── entities/auth_token.dart
│   ├── repositories/auth_repository.dart
│   └── usecases/
│       ├── login_usecase.dart
│       ├── org_login_usecase.dart
│       ├── verify_otp_usecase.dart
│       ├── forgot_password_usecase.dart
│       └── reset_password_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── login/{login_cubit, login_state, login_state.freezed}.dart
    │   ├── otp/{otp_cubit, otp_state, otp_state.freezed}.dart
    │   ├── forgot_password/{forgot_password_cubit, _state, _state.freezed}.dart
    │   ├── reset_password/{reset_password_cubit, _state, _state.freezed}.dart
    │   └── biometric/{biometric_cubit, _state, _state.freezed}.dart
    ├── screens/
    │   ├── login_screen.dart                   ← max 250 lines
    │   ├── org_email_login_screen.dart         ← max 250 lines
    │   ├── otp_verification_screen.dart        ← max 250 lines
    │   ├── forgot_password_screen.dart         ← max 250 lines
    │   ├── reset_password_screen.dart          ← max 250 lines
    │   ├── biometric_unlock_screen.dart        ← max 250 lines
    │   └── otp_flow_type.dart                  ← enum only
    └── widgets/
        ├── auth_text_field.dart
        ├── auth_primary_button.dart
        └── (any shared layout widgets extracted from Stitch designs)
```

---

## Files to Modify

| File | Change |
|---|---|
| `lib/core/network/api_client.dart` | Add 5 auth API abstract method stubs |
| `lib/core/network/api_endpoints.dart` | Add 5 auth endpoint string constants |
| `lib/core/constants/app_route_names.dart` | Add 6 auth route name constants |
| `lib/app/app.dart` | Register 6 auth routes; change `initialRoute` to `AppRouteNames.login` |
| `lib/core/di/dependency_injection.dart` | Register all auth classes |
| `lib/l10n/app_en.arb` | Add all auth string keys (English) |
| `lib/l10n/app_ar.arb` | Add all auth string keys (Arabic) |
| `pubspec.yaml` | Add `local_auth` |

---

## Data Layer Details

### Models (`@JsonSerializable`)

```dart
// login_request_data.dart
@JsonSerializable()
class LoginRequestData {
  const LoginRequestData({required this.email, required this.password});
  final String email;
  final String password;
  factory LoginRequestData.fromJson(Map<String, dynamic> json) => _$LoginRequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestDataToJson(this);
}
```

Same pattern for:
- `LoginResponseData` → fields: `accessToken`, `refreshToken`
- `OtpVerifyRequestData` → fields: `email`, `otp`
- `OtpVerifyResponseData` → fields: `accessToken`, `refreshToken`
- `ForgotPasswordRequestData` → fields: `email`
- `ResetPasswordRequestData` → fields: `token`, `newPassword`, `confirmPassword`

### `auth_remote_datasource.dart`

```dart
abstract interface class AuthRemoteDataSource {
  Future<LoginResponseData> login(LoginRequestData request);
  Future<LoginResponseData> orgLogin(LoginRequestData request);
  Future<OtpVerifyResponseData> verifyOtp(OtpVerifyRequestData request);
  Future<void> forgotPassword(ForgotPasswordRequestData request);
  Future<void> resetPassword(ResetPasswordRequestData request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<LoginResponseData> login(LoginRequestData request) {
    // TODO: wire up when backend is ready
    throw UnimplementedError('login not implemented');
  }
  // same stub for all other methods
}
```

### `auth_repository_impl.dart`

Wraps each datasource call in `try/catch`. Returns `ApiResult<T>`. Maps response models to `AuthToken` entity inline (no separate mapper file — auth is small).

---

## Domain Layer Details

### `auth_token.dart`

```dart
class AuthToken {
  const AuthToken({required this.accessToken, required this.refreshToken});
  final String accessToken;
  final String refreshToken;
}
```

### `auth_repository.dart` (abstract interface)

```dart
abstract interface class AuthRepository {
  Future<ApiResult<AuthToken>> login(String email, String password);
  Future<ApiResult<AuthToken>> orgLogin(String email, String password);
  Future<ApiResult<AuthToken>> verifyOtp(String email, String otp);
  Future<ApiResult<void>> forgotPassword(String email);
  Future<ApiResult<void>> resetPassword(String token, String newPassword, String confirmPassword);
}
```

### Use cases

One class per action, single `call()` method. Example:

```dart
class LoginUseCase {
  const LoginUseCase(this._repository);
  final AuthRepository _repository;
  Future<ApiResult<AuthToken>> call(String email, String password) =>
      _repository.login(email, password);
}
```

---

## Presentation Layer Details

### Freezed State Pattern (all cubits follow this)

```dart
@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(AuthToken token) = _Success;
  const factory LoginState.error(String message) = _Error;
}
```

States per cubit:

| Cubit | States |
|---|---|
| `LoginCubit` | initial / loading / success(AuthToken) / error(String) |
| `OtpCubit` | initial / loading / success(AuthToken) / error(String) |
| `ForgotPasswordCubit` | initial / loading / sent / error(String) |
| `ResetPasswordCubit` | initial / loading / success / error(String) |
| `BiometricCubit` | initial / checking / authenticated / unavailable / failed(String) |

### Cubit constructors

- `LoginCubit(LoginUseCase loginUseCase, OrgLoginUseCase orgLoginUseCase)`
- `OtpCubit(VerifyOtpUseCase verifyOtpUseCase)`
- `ForgotPasswordCubit(ForgotPasswordUseCase forgotPasswordUseCase)`
- `ResetPasswordCubit(ResetPasswordUseCase resetPasswordUseCase)`
- `BiometricCubit()` — uses `local_auth` directly

### Shared Widgets

**`auth_text_field.dart`**
- Wraps `TextFormField` using the project `InputDecorationTheme` (defined in `AppTheme` — no custom decoration needed).
- Parameters: `label`, `hint`, `controller`, `keyboardType`, `textInputAction`, `obscureText`, `onChanged`, `validator`, optional `suffixIcon`.
- RTL-safe: no hardcoded `TextDirection`.

**`auth_primary_button.dart`**
- Full-width `FilledButton` using `FilledButtonThemeData` from `AppTheme`.
- Parameters: `label`, `onPressed`, `isLoading`.
- When `isLoading`: show `SizedBox(width: 20.r, height: 20.r, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))` and disable `onPressed`.
- Width: `double.infinity`. Height: `52.h`.

### Screen Structure Pattern

Every screen file must follow this structure to stay under 250 lines:

```dart
// login_screen.dart

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

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: _handleState,
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: _LoginBody(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            isLoading: state is _Loading,
            onLogin: () { /* call cubit */ },
            onForgotPassword: () { /* navigate */ },
            onOrgLogin: () { /* navigate */ },
          ),
        ),
      ),
    );
  }

  void _handleState(BuildContext context, LoginState state) {
    state.whenOrNull(
      success: (_) => Navigator.pushReplacementNamed(context, AppRouteNames.home),
      error: (msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg))),
    );
  }
}

class _LoginBody extends StatelessWidget {
  // ... all the form widgets here; keep this under ~80 lines
}
```

The key rule: `_LoginBody` (or similar extracted widget) holds all the form/layout code. The `State` class holds only controllers, lifecycle, and event wiring.

### Navigation (Navigator only, no go_router)

- Push forward: `Navigator.pushNamed(context, AppRouteNames.xxx, arguments: {...})`
- Replace on auth success: `Navigator.pushReplacementNamed(context, AppRouteNames.home)`
- After reset password: `Navigator.pushNamedAndRemoveUntil(context, AppRouteNames.login, (_) => false)`
- Back: `Navigator.pop(context)`

### OTP screen arguments

Pass as a plain `Map<String, dynamic>` in route arguments:

```dart
Navigator.pushNamed(
  context,
  AppRouteNames.otpVerification,
  arguments: {'email': email, 'flow': OtpFlowType.forgotPassword},
);
```

Extract in `OtpVerificationScreen`:

```dart
final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
final email = args['email'] as String;
final flow = args['flow'] as OtpFlowType;
```

### Biometric

`BiometricCubit` calls `local_auth` directly:

```dart
Future<void> checkAndAuthenticate(String localizedReason) async {
  emit(const BiometricState.checking());
  final auth = LocalAuthentication();
  final canCheck = await auth.canCheckBiometrics;
  if (!canCheck) { emit(const BiometricState.unavailable()); return; }
  try {
    final ok = await auth.authenticate(localizedReason: localizedReason);
    emit(ok ? const BiometricState.authenticated() : const BiometricState.failed('Cancelled'));
  } catch (e) {
    emit(BiometricState.failed(e.toString()));
  }
}
```

---

## OtpFlowType

`lib/features/auth/presentation/screens/otp_flow_type.dart`:

```dart
enum OtpFlowType { login, forgotPassword }
```

In `OtpVerificationScreen` listener:
- `OtpFlowType.login` → `Navigator.pushReplacementNamed(context, AppRouteNames.home)`
- `OtpFlowType.forgotPassword` → `Navigator.pushNamed(context, AppRouteNames.resetPassword, arguments: {'token': token})`

---

## Route Names

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

---

## API Endpoints to Add

```dart
static const String login = '/auth/login';
static const String orgLogin = '/auth/org-login';
static const String verifyOtp = '/auth/verify-otp';
static const String forgotPassword = '/auth/forgot-password';
static const String resetPassword = '/auth/reset-password';
```

---

## API Client Method Stubs to Add

```dart
@POST(ApiEndpoints.login)
Future<LoginResponseData> login(@Body() LoginRequestData request);

@POST(ApiEndpoints.orgLogin)
Future<LoginResponseData> orgLogin(@Body() LoginRequestData request);

@POST(ApiEndpoints.verifyOtp)
Future<OtpVerifyResponseData> verifyOtp(@Body() OtpVerifyRequestData request);

@POST(ApiEndpoints.forgotPassword)
Future<void> forgotPassword(@Body() ForgotPasswordRequestData request);

@POST(ApiEndpoints.resetPassword)
Future<void> resetPassword(@Body() ResetPasswordRequestData request);
```

---

## DI Registration

```dart
// Auth — add after existing registrations
..registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(getIt()))
..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()))
..registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()))
..registerLazySingleton<OrgLoginUseCase>(() => OrgLoginUseCase(getIt()))
..registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(getIt()))
..registerLazySingleton<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(getIt()))
..registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase(getIt()))
..registerFactory<LoginCubit>(() => LoginCubit(getIt(), getIt()))
..registerFactory<OtpCubit>(() => OtpCubit(getIt()))
..registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(getIt()))
..registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(getIt()))
..registerFactory<BiometricCubit>(BiometricCubit.new)
```

---

## app.dart Changes

```dart
initialRoute: AppRouteNames.login,
routes: {
  AppRouteNames.home: (_) => const HomeScreen(),
  AppRouteNames.login: (_) => const LoginScreen(),
  AppRouteNames.orgEmailLogin: (_) => const OrgEmailLoginScreen(),
  AppRouteNames.otpVerification: (_) => const OtpVerificationScreen(),
  AppRouteNames.forgotPassword: (_) => const ForgotPasswordScreen(),
  AppRouteNames.resetPassword: (_) => const ResetPasswordScreen(),
  AppRouteNames.biometricUnlock: (_) => const BiometricUnlockScreen(),
},
```

---

## Localization Keys

### `app_en.arb` — add these entries

```json
"loginTitle": "Welcome back",
"loginSubtitle": "Log in to your Scolair parent account",
"emailLabel": "Email",
"emailHint": "Enter your email",
"passwordLabel": "Password",
"passwordHint": "Enter your password",
"forgotPasswordLink": "Forgot password?",
"loginButton": "Log in",
"orgLoginLink": "Log in with organization email",
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
"biometricSubtitle": "Use biometrics to unlock",
"biometricPrompt": "Authenticate to access Scolair",
"usePasswordFallback": "Use password instead",
"authErrorInvalidCredentials": "Incorrect email or password",
"authErrorOtpInvalid": "Invalid or expired code",
"authErrorGeneric": "Something went wrong. Please try again"
```

### `app_ar.arb` — same keys in Arabic

```json
"loginTitle": "مرحباً بعودتك",
"loginSubtitle": "سجّل دخولك إلى حساب ولي أمر سكولير",
"emailLabel": "البريد الإلكتروني",
"emailHint": "أدخل بريدك الإلكتروني",
"passwordLabel": "كلمة المرور",
"passwordHint": "أدخل كلمة المرور",
"forgotPasswordLink": "نسيت كلمة المرور؟",
"loginButton": "تسجيل الدخول",
"orgLoginLink": "تسجيل الدخول ببريد المؤسسة",
"orgLoginTitle": "دخول المؤسسة",
"orgLoginSubtitle": "أدخل بريد مؤسستك للمتابعة",
"orgLoginButton": "متابعة",
"otpTitle": "تحقق من بريدك الإلكتروني",
"otpSubtitle": "أرسلنا رمزاً مكوناً من 6 أرقام إلى {email}",
"@otpSubtitle": { "placeholders": { "email": {} } },
"otpResend": "إعادة إرسال الرمز",
"otpVerifyButton": "تحقق",
"forgotPasswordTitle": "نسيت كلمة المرور؟",
"forgotPasswordSubtitle": "أدخل بريدك الإلكتروني وسنرسل لك رمز إعادة التعيين",
"sendResetLinkButton": "إرسال رمز الاستعادة",
"resetPasswordTitle": "إعادة تعيين كلمة المرور",
"newPasswordLabel": "كلمة المرور الجديدة",
"newPasswordHint": "أدخل كلمة المرور الجديدة",
"confirmPasswordLabel": "تأكيد كلمة المرور",
"confirmPasswordHint": "أعد إدخال كلمة المرور الجديدة",
"resetPasswordButton": "إعادة التعيين",
"passwordMismatch": "كلمتا المرور غير متطابقتين",
"biometricTitle": "مرحباً بعودتك",
"biometricSubtitle": "استخدم المقاييس الحيوية لفتح القفل",
"biometricPrompt": "المصادقة للوصول إلى سكولير",
"usePasswordFallback": "استخدم كلمة المرور بدلاً من ذلك",
"authErrorInvalidCredentials": "البريد الإلكتروني أو كلمة المرور غير صحيحة",
"authErrorOtpInvalid": "الرمز غير صالح أو منتهي الصلاحية",
"authErrorGeneric": "حدث خطأ ما. يرجى المحاولة مرة أخرى"
```

---

## Architecture Rules Compliance

- All code follows `features/auth/data`, `domain`, `presentation` layers.
- Models stay in `data/models/` — never passed directly to widgets.
- Cubits call use cases only — no Dio/API calls inside cubits.
- Screens compose widgets and connect cubits via `BlocProvider` / `BlocConsumer`.
- `AppColors`, `AppTextStyles`, and `AppTheme` tokens used throughout.
- `flutter_screenutil_plus` `.w`/`.h`/`.sp`/`.r` for all sizes.
- All visible strings via `context.l10n.*`.
- Navigation via `Navigator` only — no `go_router`.
- DI via `get_it` — no direct instantiation in widgets.
- No `BuildContext` inside cubits.

---

## Validation Plan

Run in this order after implementation:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed .
flutter analyze
```

All must pass with zero errors. Existing home tests must still pass.

---

## Completion Notes

- Status: Done.
- Completed work: Added `local_auth`, full `features/auth` data/domain/presentation layers, Freezed Cubits, JSON models, six Navigator-based auth screens, shared auth widgets, route constants, API endpoint/client declarations, DI registrations, and English/Arabic ARB strings. Remote datasource methods intentionally throw `UnimplementedError('TODO: wire up when backend is ready')`.
- Stitch notes: Used Stitch MCP `list_screens` for project `16421847842765854662`, downloaded the returned hosted HTML/screenshot artifacts with `curl -L`, and inspected the available auth/reference screens under `.agent/stitch-auth/`. The exposed Stitch tool set in this session did not include a targeted `get_screen`/`fetch_screen_code` method, so screens not directly visible in the project listing were implemented from the same extracted auth layout, color, typography, and spacing system.
- Validation run: `flutter pub get`; `dart run build_runner build --delete-conflicting-outputs`; `flutter gen-l10n`; `dart format --set-exit-if-changed .`; `flutter analyze`; `flutter test`.
- Skipped validation: None.
- Follow-up tasks: Add token persistence, backend auth wiring, and app-start biometric gating when backend/session requirements are ready.
