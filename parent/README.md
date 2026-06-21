# scolair_parent

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
Here is Claude's plan:
╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
Auth Integration Plan — Scolair Parent App

Context

The parent app has a complete auth UI (6 screens) and clean-architecture skeleton, but every API call throws UnimplementedError. The actual backend is a Frappe/LMS system at dev.scolair.site with paths and request/response
shapes that differ from the current stubs. This plan wires every screen to the real endpoints, adds a Register screen and a Change Password screen, fixes the 3-step forgot-password data flow (session_id → reset_token), adds
token-refresh logic to the auth interceptor, adds splash auto-login, and adds Google login (UI + backend).

 ---
Spec File

Create .agent/specs/auth-integration.md from the spec template before starting implementation. Track task status there as work progresses.

 ---
Step 1 — API Endpoints

File: lib/core/network/api_endpoints.dart

Replace all stub paths. The base URL becomes https://dev.scolair.site (Frappe dev instance).

┌─────────────────────────┬───────────────────────────────────────────────────────────┐
│        Constant         │                           Value                           │
├─────────────────────────┼───────────────────────────────────────────────────────────┤
│ baseUrl                 │ https://dev.scolair.site                                  │
├─────────────────────────┼───────────────────────────────────────────────────────────┤
│ login                   │ /api/method/lms.mobile.login                              │
├─────────────────────────┼───────────────────────────────────────────────────────────┤
│ register                │ /api/method/lms.mobile.sign_up                            │
├─────────────────────────┼───────────────────────────────────────────────────────────┤
│ googleLogin             │ /api/method/lms.mobile.google_login                       │
├─────────────────────────┼───────────────────────────────────────────────────────────┤
│ refreshToken            │ /api/method/lms.mobile.refresh                            │
├─────────────────────────┼───────────────────────────────────────────────────────────┤
│ logout                  │ /api/method/lms.mobile.logout                             │
├─────────────────────────┼───────────────────────────────────────────────────────────┤
│ forgotPasswordSendOtp   │ /api/method/lms.mobile.forgot_password_send_otp           │
├─────────────────────────┼───────────────────────────────────────────────────────────┤
│ forgotPasswordVerifyOtp │ /api/method/lms.mobile.forgot_password_verify_otp         │
├─────────────────────────┼───────────────────────────────────────────────────────────┤
│ forgotPasswordReset     │ /api/method/lms.mobile.forgot_password_reset_password     │
├─────────────────────────┼───────────────────────────────────────────────────────────┤
│ changePassword          │ /api/method/frappe.core.doctype.user.user.update_password │
└─────────────────────────┴───────────────────────────────────────────────────────────┘

Remove the unused stubs: health, orgLogin, verifyOtp, sendOtp, forgotPassword, resetPassword.

 ---
Step 2 — Models (Update Existing + New)

Directory: lib/features/auth/data/models/

Update existing

┌───────────────────────────────────┬─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│               File                │                                                                                         Change                                                                                          │
├───────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ login_request_data.dart           │ Rename field email → username (serialized as "username")                                                                                                                                │
├───────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ login_response_data.dart          │ Add state, message wrapper; nest tokens under data sub-object. Fields: accessToken, refreshToken, expiresIn, tokenType, scope inside a LoginTokenData inner class. Top-level has state: │
│                                   │  String, message: String, data: LoginTokenData.                                                                                                                                         │
├───────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ otp_verify_request_data.dart      │ Replace email + otp → sessionId + otp (serialized as "session_id", "otp")                                                                                                               │
├───────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ otp_verify_response_data.dart     │ Currently returns an auth token. Change to: state, message, data.resetToken (serialized as "reset_token")                                                                               │
├───────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ forgot_password_request_data.dart │ Already has email. No change to request. Add a response model: forgot_password_send_otp_response_data.dart with state, message, data.sessionId.                                         │
├───────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ reset_password_request_data.dart  │ Change fields to resetToken + newPassword (serialized as "reset_token", "new_password"). Remove confirmPassword — validation is UI-only.                                                │
├───────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ send_otp_request_data.dart        │ Remove entirely (no phone OTP in this API). Delete .g.dart too.                                                                                                                         │
└───────────────────────────────────┴─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

New files

┌───────────────────────────────────┬────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│               File                │                                                                             Fields                                                                             │
├───────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ register_request_data.dart        │ email, fullName ("full_name"), verifyTerms ("verify_terms", int), userCategory ("user_category", always ""), userType ("user_type", always "parent"), password │
├───────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ register_response_data.dart       │ state, message                                                                                                                                                 │
├───────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ google_login_request_data.dart    │ idToken ("id_token"), role ("role", always "parent")                                                                                                           │
├───────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ refresh_token_request_data.dart   │ refreshToken ("refresh_token")                                                                                                                                 │
├───────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ refresh_token_response_data.dart  │ state, message, data.accessToken, data.refreshToken, data.expiresIn                                                                                            │
├───────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ logout_request_data.dart          │ token (the access token)                                                                                                                                       │
├───────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ change_password_request_data.dart │ newPassword ("new_password"), oldPassword ("old_password"), logoutAllSessions ("logout_all_sessions", always 0)                                                │
└───────────────────────────────────┴────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

All models use @JsonSerializable() + fromJson/toJson pattern. Regenerate after changes: dart run build_runner build --delete-conflicting-outputs.

 ---
Step 3 — Secure Storage

File: lib/core/storage/app_secure_storage.dart

Add:
- readRefreshToken() / saveRefreshToken(token) / clearRefreshToken() (key: 'refresh_token')
- clearAll() — clears both access and refresh tokens on logout/session expiry

 ---
Step 4 — Auth Interceptor (Token Refresh)

File: lib/core/network/interceptors/auth_interceptor.dart

Full rewrite to handle token refresh. The interceptor receives both AppSecureStorage and a Dio instance (a plain Dio, separate from the app Dio to avoid circular interception).

Logic:
1. onRequest: read accessToken from secure storage, attach Authorization: Bearer if present.
2. onError: if status is 401 and request has not already been retried (check a custom header flag):
   a. Read refreshToken from secure storage.
   b. If no refresh token → call _onSessionExpired() (clear tokens, signal logout) → reject.
   c. If refresh token exists → POST to ApiEndpoints.refreshToken with { refresh_token }.
   d. On success: save new accessToken + refreshToken → retry original request with new token.
   e. On refresh failure: clear all tokens → reject with the original error.
3. Use a Completer<void>? lock (_refreshLock) to queue concurrent 401 requests — only one refresh call runs; others wait on the same completer.

The DioFactory creates a plain _refreshDio (no interceptors) to call the refresh endpoint, preventing infinite retry loops.

 ---
Step 5 — API Client

File: lib/core/network/api_client.dart

Replace all stub endpoints with the real ones. Add:

@POST(ApiEndpoints.register)
Future<RegisterResponseData> register(@Body() RegisterRequestData request);

@POST(ApiEndpoints.googleLogin)
Future<LoginResponseData> googleLogin(@Body() GoogleLoginRequestData request);

@POST(ApiEndpoints.refreshToken)
Future<RefreshTokenResponseData> refreshToken(@Body() RefreshTokenRequestData request);

@POST(ApiEndpoints.logout)
Future<void> logout(@Body() LogoutRequestData request);

@POST(ApiEndpoints.forgotPasswordSendOtp)
Future<ForgotPasswordSendOtpResponseData> forgotPasswordSendOtp(
@Body() ForgotPasswordRequestData request,
);

@POST(ApiEndpoints.forgotPasswordVerifyOtp)
Future<OtpVerifyResponseData> forgotPasswordVerifyOtp(
@Body() OtpVerifyRequestData request,
);

@POST(ApiEndpoints.forgotPasswordReset)
Future<RegisterResponseData> forgotPasswordReset(
@Body() ResetPasswordRequestData request,
);

@POST(ApiEndpoints.changePassword)
Future<void> changePassword(@Body() ChangePasswordRequestData request);

Remove: healthCheck, orgLogin, verifyOtp, forgotPassword, sendOtp, resetPassword.

Regenerate: dart run build_runner build --delete-conflicting-outputs produces new api_client.g.dart.

 ---
Step 6 — Remote Data Source

File: lib/features/auth/data/datasources/remote/auth_remote_datasource.dart

Update the interface and implementation:

Interface methods:
register(RegisterRequestData) → Future<void>
login(LoginRequestData) → Future<LoginResponseData>
googleLogin(GoogleLoginRequestData) → Future<LoginResponseData>
forgotPasswordSendOtp(ForgotPasswordRequestData) → Future<ForgotPasswordSendOtpResponseData>
forgotPasswordVerifyOtp(OtpVerifyRequestData) → Future<OtpVerifyResponseData>
forgotPasswordReset(ResetPasswordRequestData) → Future<void>
changePassword(ChangePasswordRequestData) → Future<void>
logout(LogoutRequestData) → Future<void>

Remove: sendOtp, orgLogin, verifyOtp, forgotPassword, resetPassword (old stubs).

All Impl methods delegate directly to _apiClient.methodName(request) — no UnimplementedError.

 ---
Step 7 — Domain Repository

File: lib/features/auth/domain/repositories/auth_repository.dart

Replace current interface:

Future<ApiResult<void>> register(String fullName, String email, String password, bool verifyTerms);
Future<ApiResult<AuthToken>> login(String username, String password);
Future<ApiResult<AuthToken>> googleLogin(String idToken);
Future<ApiResult<String>> forgotPasswordSendOtp(String email); // returns sessionId
Future<ApiResult<String>> forgotPasswordVerifyOtp(String sessionId, String otp); // returns resetToken
Future<ApiResult<void>> forgotPasswordReset(String resetToken, String newPassword);
Future<ApiResult<void>> changePassword(String oldPassword, String newPassword);
Future<ApiResult<void>> logout(String accessToken);

Remove: sendOtp, orgLogin, verifyOtp, forgotPassword, resetPassword (old signatures).

File: lib/features/auth/data/repositories/auth_repository_impl.dart

Implement all 8 methods. Each method:
1. Calls the data source.
2. On success: maps response model to domain entity (or plain string) → ApiResult.success(...).
3. Catches DioException and Exception → maps to Failure → ApiResult.failure(...) via ErrorHandler.

The login and googleLogin methods also call _secureStorage.saveAccessToken(...) and _secureStorage.saveRefreshToken(...) after a successful response.

 ---
Step 8 — Use Cases (New + Remove Old)

Directory: lib/features/auth/domain/usecases/

New:
- register_usecase.dart — delegates to _repo.register(fullName, email, password, verifyTerms)
- google_login_usecase.dart — delegates to _repo.googleLogin(idToken)
- logout_usecase.dart — delegates to _repo.logout(accessToken)
- change_password_usecase.dart — delegates to _repo.changePassword(oldPassword, newPassword)

Update:
- login_usecase.dart — signature becomes call(String username, String password)
- forgot_password_usecase.dart → rename to forgot_password_send_otp_usecase.dart — returns ApiResult<String> (sessionId)
- send_otp_usecase.dart → rename to forgot_password_verify_otp_usecase.dart — returns ApiResult<String> (resetToken)
- verify_otp_usecase.dart → rename to forgot_password_reset_usecase.dart

Remove:
- org_login_usecase.dart

 ---
Step 9 — Presentation Cubits

9a. login_cubit.dart (update)

- Remove orgLogin method.
- After successful login: save tokens via AppSecureStorage (already done in repository, so cubit just navigates).
- Emit LoginState.success(token) → screen navigates to /.
- Add googleLogin(String idToken) method calling GoogleLoginUseCase.

9b. Register Cubit (new)

Files: lib/features/auth/presentation/cubit/register/register_cubit.dart + register_state.dart

States: initial | loading | success | error(String message)

Method: register(String fullName, String email, String password, bool verifyTerms) → on success emit success → screen navigates to / (home).

9c. forgot_password_cubit.dart (update)

- sendResetCode(String email) → on success emit ForgotPasswordState.sent(String sessionId) instead of sent().
- Screen reads sessionId from state and passes it in OtpArgs.

Update forgot_password_state.dart Freezed union: sent state carries sessionId: String.

9d. otp_cubit.dart (update)

- Method verify(String sessionId, String otp) for forgot password flow.
- Calls ForgotPasswordVerifyOtpUseCase.
- On success: OtpState.success(String resetToken) — carries reset token string, not AuthToken.

Update otp_state.dart Freezed union: success carries resetToken: String.

9e. reset_password_cubit.dart (update)

- Method reset(String resetToken, String newPassword).
- Calls ForgotPasswordResetUseCase.
- On success: ResetPasswordState.success() → screen navigates to /login.

9f. Change Password Cubit (new)

Files: lib/features/auth/presentation/cubit/change_password/change_password_cubit.dart + change_password_state.dart

States: initial | loading | success | error(String message)

Method: changePassword(String oldPassword, String newPassword) → reads accessToken from secure storage (for the Authorization header, handled by interceptor) → calls ChangePasswordUseCase.

 ---
Step 10 — New Screens

10a. register_screen.dart

File: lib/features/auth/presentation/screens/register_screen.dart

Fields:
- Full Name (TextFormField)
- Email (TextFormField, keyboard type email)
- Password (TextFormField, obscure, with show/hide toggle)
- "I agree to the Terms & Conditions" checkbox (maps to verifyTerms)

Actions:
- "Create account" button → RegisterCubit.register(...) (disabled if checkbox unchecked)
- "Already have an account? Log in" link → Navigator.pop() or push /login

On RegisterState.success: navigate to / (home) with pushNamedAndRemoveUntil.

10b. change_password_screen.dart

File: lib/features/auth/presentation/screens/change_password_screen.dart

Fields:
- Current Password
- New Password
- Confirm New Password (UI-only validation)

Action: "Update password" button → ChangePasswordCubit.changePassword(oldPassword, newPassword).

On success: show success snackbar + Navigator.pop().

 ---
Step 11 — Update Existing Screens

login_screen.dart

- Change parameter label/hint from "Email" to "Email or username" (username field).
- Add "Create account" link → Navigator.pushNamed(context, AppRouteNames.register).
- Add "Continue with Google" button below the primary button → calls LoginCubit.googleLogin(idToken).
    - Use google_sign_in package (add to pubspec.yaml) to get idToken, then pass to cubit.
    - Button uses Google icon SVG (add to assets/images/ and AppAssets).
- Remove "Sign in with phone instead" link (no phone login API).
- On LoginState.success: Navigator.pushNamedAndRemoveUntil(context, AppRouteNames.home, ...).

otp_args.dart

Add sessionId: String field:
class OtpArgs {
const OtpArgs({required this.identifier, required this.flow, this.sessionId = ''});
final String identifier;
final OtpFlowType flow;
final String sessionId;
}

otp_verification_screen.dart

- On submit: call OtpCubit.verify(args.sessionId, otpCode) instead of verify(args.identifier, otpCode).
- On OtpState.success(resetToken): navigate to /reset-password with ResetPasswordArgs(token: resetToken).

forgot_password_screen.dart

- On ForgotPasswordState.sent(sessionId): navigate to /otp-verification with OtpArgs(identifier: email, flow: forgotPassword, sessionId: sessionId).

reset_password_screen.dart

- Read ResetPasswordArgs(token) from route arguments (already done — token field matches resetToken).
- On submit: call ResetPasswordCubit.reset(args.token, newPassword).
- On success: navigate to /login with pushNamedAndRemoveUntil.

 ---
Step 12 — Splash Auto-Login

File: lib/features/splash/presentation/cubit/splash_cubit.dart

Replace the TODO with real logic:
1. Read refreshToken from AppSecureStorage.
2. If no refresh token → navigate to /login.
3. If refresh token exists → POST to refresh endpoint (via a dedicated use case or direct call through a lightweight auth service).
4. On refresh success: save new tokens → navigate to / (home).
5. On refresh failure: clear tokens → navigate to /login.

Add a refresh_token_usecase.dart or handle inline in SplashCubit via a RefreshTokenUseCase.

 ---
Step 13 — Routes

File: lib/core/constants/app_route_names.dart

Add:
static const String register = '/register';
static const String changePassword = '/change-password';

File: lib/app/app.dart

Add routes:
AppRouteNames.register: (_) => BlocProvider(
create: (_) => sl<RegisterCubit>(),
child: const RegisterScreen(),
),
AppRouteNames.changePassword: (_) => BlocProvider(
create: (_) => sl<ChangePasswordCubit>(),
child: const ChangePasswordScreen(),
),

Remove the orgEmailLogin route (no phone login in this API). Optionally keep it as a dead route until confirmed removed from designs.

 ---
Step 14 — Dependency Injection

File: lib/core/di/dependency_injection.dart

Add:
- RefreshTokenUseCase (lazy singleton)
- RegisterUseCase (lazy singleton)
- GoogleLoginUseCase (lazy singleton)
- LogoutUseCase (lazy singleton)
- ChangePasswordUseCase (lazy singleton)
- ForgotPasswordSendOtpUseCase (lazy singleton, replaces ForgotPasswordUseCase)
- ForgotPasswordVerifyOtpUseCase (lazy singleton, replaces VerifyOtpUseCase)
- ForgotPasswordResetUseCase (lazy singleton, replaces ResetPasswordUseCase)
- RegisterCubit (factory)
- ChangePasswordCubit (factory)

Update:
- LoginCubit factory: inject GoogleLoginUseCase instead of OrgLoginUseCase
- ForgotPasswordCubit factory: inject updated ForgotPasswordSendOtpUseCase
- OtpCubit factory: inject ForgotPasswordVerifyOtpUseCase
- ResetPasswordCubit factory: inject ForgotPasswordResetUseCase
- SplashCubit: inject AppSecureStorage and RefreshTokenUseCase

Add to AuthInterceptor registration:
Pass a second plain Dio (no interceptors) for token refresh requests.

pubspec.yaml: Add google_sign_in: ^7.1.0 (or latest stable) to dependencies.

 ---
Step 15 — Localization

Files: lib/l10n/app_en.arb + lib/l10n/app_ar.arb

New keys to add (English shown; Arabic translations required for each):

registerTitle, fullNameLabel, fullNameHint, agreeTermsLabel,
createAccountButton, alreadyHaveAccountLink,
continueWithGoogleButton,
changePasswordTitle, currentPasswordLabel, updatePasswordButton,
registerSuccessMessage, logoutButton,
forgotPasswordSessionExpiredError

Run flutter gen-l10n after updating ARB files.

 ---
Step 16 — Spec + Memory

- Create .agent/specs/auth-integration.md with task list matching these steps.
- Update .agent/project-memory.md: move "backend auth wiring" from Next Tasks to In-Progress, note new models/screens being added.

 ---
Packages to Add

┌────────────────┬─────────┬──────────────────────────────┐
│    Package     │ Version │           Purpose            │
├────────────────┼─────────┼──────────────────────────────┤
│ google_sign_in │ ^7.1.0  │ Get Google idToken on device │
└────────────────┴─────────┴──────────────────────────────┘

Run flutter pub get after updating pubspec.yaml.

 ---
Code Generation Order

After all model/state changes:
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
dart format .
flutter analyze

 ---
Verification

1. Register: Launch app → onboarding → login → tap "Create account" → fill form with checkbox → submit → lands on Home screen.
2. Login: Enter japotow969@synsky.com / Parent123! → success → Home screen. Tokens saved in secure storage.
3. Forgot password: Tap "Forgot password?" → enter email → OTP sent → enter 6-digit code → enter new password → success → Login screen.
4. Google login: Tap "Continue with Google" → Google picker → signed in → Home screen.
5. Token refresh: Use Charles/Proxyman to confirm that on a 401, the app auto-calls /api/method/lms.mobile.refresh and retries.
6. Auto-login: Kill app → reopen → Splash should skip login and go to Home (if refresh token valid).
7. Change password: From inside the app (once Home is wired), navigate to Change Password → update → success toast.
8. Logout: Call logout endpoint, clear tokens, navigate to Login, confirm re-open shows Login not Home.
9. flutter analyze passes with zero warnings.
- Update .agent/project-memory.md: move "backend auth wiring" from Next Tasks to In-Progress, note new models/screens being added.

 ---
Packages to Add

┌────────────────┬─────────┬──────────────────────────────┐
│    Package     │ Version │           Purpose            │
├────────────────┼─────────┼──────────────────────────────┤
│ google_sign_in │ ^7.1.0  │ Get Google idToken on device │
└────────────────┴─────────┴──────────────────────────────┘

Run flutter pub get after updating pubspec.yaml.

 ---
Code Generation Order

After all model/state changes:
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
dart format .
flutter analyze

 ---
Verification

1. Register: Launch app → onboarding → login → tap "Create account" → fill form with checkbox → submit → lands on Home screen.
2. Login: Enter japotow969@synsky.com / Parent123! → success → Home screen. Tokens saved in secure storage.
3. Forgot password: Tap "Forgot password?" → enter email → OTP sent → enter 6-digit code → enter new password → success → Login screen.
4. Google login: Tap "Continue with Google" → Google picker → signed in → Home screen.
5. Token refresh: Use Charles/Proxyman to confirm that on a 401, the app auto-calls /api/method/lms.mobile.refresh and retries.
6. Auto-login: Kill app → reopen → Splash should skip login and go to Home (if refresh token valid).
7. Change password: From inside the app (once Home is wired), navigate to Change Password → update → success toast.
8. Logout: Call logout endpoint, clear tokens, navigate to Login, confirm re-open shows Login not Home.
9. flutter analyze passes with zero warnings.
