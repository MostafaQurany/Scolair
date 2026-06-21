# Auth Integration

Status: `done`

## Goal

Wire all auth screens to the real Frappe/LMS backend at `dev.scolair.site`. Add Register and Change Password screens. Fix the 3-step forgot-password data flow. Add token refresh in the auth interceptor. Add splash auto-login. Add Google login (UI + backend).

## Success Criteria

- Register, Login, Forgot Password (3-step), Google Login, Change Password, and Logout all call real endpoints.
- Tokens are persisted in secure storage after login/register/google-login.
- Auth interceptor attaches the access token and auto-refreshes on 401.
- Splash auto-login navigates to Home if a valid refresh token is saved, otherwise Login.
- `dart format .`, `flutter analyze`, and `dart run build_runner build` pass with no errors.

## Scope

In scope:

- Update `api_endpoints.dart` to Frappe/LMS paths.
- Update and add models in `features/auth/data/models/`.
- Add `readRefreshToken`, `saveRefreshToken`, `clearRefreshToken`, `clearAll` to `AppSecureStorage`.
- Rewrite `AuthInterceptor` with queued token-refresh on 401.
- Update `DioFactory` to pass a plain refresh Dio to `AuthInterceptor`.
- Update `api_client.dart` with new Retrofit endpoints.
- Update `auth_remote_datasource.dart` — remove stubs, wire to real API.
- Update `auth_repository.dart` interface + `auth_repository_impl.dart`.
- Add use cases: register, google login, logout, change password, refresh token, forgot-password-send-otp, forgot-password-verify-otp, forgot-password-reset.
- Update login/forgot_password/otp/reset_password cubits and states.
- Add register and change_password cubits + Freezed states.
- Add `register_screen.dart` and `change_password_screen.dart`.
- Update `login_screen.dart` (register link, Google button, fix submit call).
- Update `forgot_password_screen.dart` (pass session_id to OTP args).
- Update `otp_verification_screen.dart` (use session_id, pass reset_token onward).
- Update `reset_password_screen.dart` (remove confirm-password param from cubit call).
- Update `otp_args.dart` (add sessionId field).
- Update `splash_cubit.dart` with auto-login logic.
- Add routes `/register`, `/change-password` to `app_route_names.dart` and `app.dart`.
- Update `dependency_injection.dart` for all new/changed registrations.
- Add new ARB keys to `app_en.arb` and `app_ar.arb`.
- Add `google_sign_in` to `pubspec.yaml`.
- Update `.agent/project-memory.md`.

Out of scope:

- Home screen implementation.
- Biometric unlock wiring (remains as-is).
- Phone login flow (no API endpoint provided).

## Task Checklist

- [x] Read `.agent/project-rules.md`.
- [x] Read `.agent/project-memory.md`.
- [x] Confirm affected files and folders.
- [ ] Step 1: Update `api_endpoints.dart`.
- [ ] Step 2: Update/add models.
- [ ] Step 3: Update `app_secure_storage.dart`.
- [ ] Step 4: Rewrite `auth_interceptor.dart`.
- [ ] Step 5: Update `dio_factory.dart`.
- [ ] Step 6: Update `api_client.dart`.
- [ ] Step 7: Update `auth_remote_datasource.dart`.
- [ ] Step 8: Update `auth_repository.dart` + `auth_repository_impl.dart`.
- [ ] Step 9: Update/add use cases.
- [ ] Step 10: Update/add cubits + states.
- [ ] Step 11: Add `register_screen.dart` + `change_password_screen.dart`.
- [ ] Step 12: Update existing screens.
- [ ] Step 13: Update `splash_cubit.dart`.
- [ ] Step 14: Update routes + `app.dart`.
- [ ] Step 15: Update `dependency_injection.dart`.
- [ ] Step 16: Update ARB files + `pubspec.yaml`.
- [ ] Run `dart run build_runner build --delete-conflicting-outputs`.
- [ ] Run `flutter gen-l10n`.
- [ ] Run `dart format .` and `flutter analyze`.
- [ ] Update `.agent/project-memory.md`.

## Files Expected To Change

- `lib/core/network/api_endpoints.dart`
- `lib/core/network/api_client.dart` + `api_client.g.dart`
- `lib/core/network/dio_factory.dart`
- `lib/core/network/interceptors/auth_interceptor.dart`
- `lib/core/storage/app_secure_storage.dart`
- `lib/core/constants/app_route_names.dart`
- `lib/core/di/dependency_injection.dart`
- `lib/app/app.dart`
- `lib/features/auth/data/models/` (all existing updated, 7 new files)
- `lib/features/auth/data/datasources/remote/auth_remote_datasource.dart`
- `lib/features/auth/data/repositories/auth_repository_impl.dart`
- `lib/features/auth/domain/repositories/auth_repository.dart`
- `lib/features/auth/domain/usecases/` (3 renamed, 5 new, 2 deleted)
- `lib/features/auth/presentation/cubit/login/`
- `lib/features/auth/presentation/cubit/forgot_password/`
- `lib/features/auth/presentation/cubit/otp/`
- `lib/features/auth/presentation/cubit/reset_password/`
- `lib/features/auth/presentation/cubit/register/` (new)
- `lib/features/auth/presentation/cubit/change_password/` (new)
- `lib/features/auth/presentation/screens/` (2 new, 4 updated, 1 updated args)
- `lib/features/splash/presentation/cubit/splash_cubit.dart`
- `lib/l10n/app_en.arb` + `lib/l10n/app_ar.arb`
- `pubspec.yaml`

## Architecture And Rules Impact

- New screens follow the 250-line rule.
- New use cases follow the one-liner delegator pattern.
- `AuthInterceptor` uses a separate plain Dio for refresh calls to prevent circular interception.
- Token storage stays in `AppSecureStorage`, not Cubit state.
- Navigation uses `Navigator` (no go_router).
- All user-facing strings go through ARB + `context.l10n`.

## Validation Plan

- `dart run build_runner build --delete-conflicting-outputs`
- `flutter gen-l10n`
- `dart format .`
- `flutter analyze`

## Completion Notes

- Status: done
- Completed work: All 16 steps implemented. New models, endpoints, interceptor, data/domain/presentation layers fully wired. Register + change password screens added. Splash auto-login implemented. Google login integrated (UI + backend).
- Validation run: `dart run build_runner build`, `flutter gen-l10n`, `dart format .`, `flutter analyze` (0 issues), `flutter test` (all passed).
- Skipped validation: Manual device test (requires backend connectivity).
- Follow-up tasks: Google Sign-In client ID configuration in `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist` required before Google login works on device.
