# LMS Adaptive Navigation Tasks

- [x] Read `.agent/project-rules.md`.
- [x] Read `.agent/project-memory.md`.
- [x] Inspect existing theme, routes, responsive helpers, shared widgets, and tests.
- [x] Create adaptive layout extension.
- [x] Create navigation item/default model.
- [x] Create custom mobile bottom navigation bar.
- [x] Create custom tablet navigation rail/sidebar.
- [x] Create adaptive navigation shell.
- [x] Add localized navigation labels.
- [x] Update generated localization files.
- [x] Document the reusable extension in `.agent/project-rules.md`.
- [x] Update `.agent/project-memory.md`.
- [x] Add authenticated `HomeLayout` app shell route.
- [x] Route splash/auth success flows to `HomeLayout`.
- [x] Fix startup route stack so `/` Home is not built underneath splash.
- [x] Run `dart format .`.
- [x] Run `flutter analyze`.
- [x] Run `flutter test`.

## Notes
- No `test/core/widgets/navigation/lms_adaptive_navigation_test.dart` file is created because navigation-specific tests were explicitly excluded.
- `flutter analyze` fails on existing unrelated warnings in auth/home files; scoped `dart analyze lib/core/extensions lib/core/widgets/navigation lib/l10n` passes.
- `flutter test` fails in existing `test/widget_test.dart` because it expects `Scolair Home` while the app starts at the splash route.
- After adding `HomeLayout`, scoped `dart analyze lib/app lib/core/constants lib/features/home/presentation lib/features/splash lib/features/auth/presentation/screens/login_screen.dart lib/features/auth/presentation/screens/biometric_unlock_screen.dart lib/features/auth/presentation/screens/register_screen.dart lib/l10n` passes.
