# Stitch Theme System

## Status

done

## Goal

Apply the Stitch Scolair visual system to the Flutter app theme on this branch.

## Source

- Theme source folder: `C:\Users\qmost\OneDrive\Desktop\New folder`
- Palette source: Stitch theme panel and generated UI prompts.
- Typography source: Stitch theme panel, Hanken Grotesk.

## Branch Tone

- Branch: `parent`
- Tone: calm and dashboard-focused.
- Usage: softer neutral highlights support parent-facing overview screens while primary blue remains the main action color.

## Success Criteria

- `AppColors` contains the Stitch brand colors, light tokens, dark tokens, semantic tokens, and component aliases.
- `AppTextStyles` uses Hanken Grotesk through `google_fonts` and keeps ScreenUtil sizing.
- `AppTheme` exposes `lightTheme` and `darkTheme`.
- `App` uses `theme`, `darkTheme`, and `ThemeMode.system`.
- Starter Home UI reads colors and text styles from the active theme.

## Scope

- Shared theme files.
- App theme wiring.
- Starter Home styling cleanup where needed for dark mode.
- `google_fonts` dependency.

## Task Checklist

- [x] Add `google_fonts`.
- [x] Replace temporary colors with Stitch tokens.
- [x] Add light and dark Material 3 color schemes.
- [x] Add component themes for app bar, cards, buttons, inputs, chips, navigation, dialogs, sheets, snack bars, dividers, icons, list tiles, and FAB.
- [x] Wire `ThemeMode.system`.
- [x] Update starter Home screen to use themed styles.
- [x] Run validation.

## Files Expected To Change

- `pubspec.yaml`
- `pubspec.lock`
- `lib/app/app.dart`
- `lib/core/theme/app_colors.dart`
- `lib/core/theme/app_text_styles.dart`
- `lib/core/theme/app_theme.dart`
- `lib/features/home/presentation/widgets/home_view.dart`
- `.agent/project-memory.md`
- `.agent/specs/stitch-theme-system.md`

## Architecture And Rules Impact

- Keeps theme code inside `lib/core/theme/`.
- Keeps starter feature UI inside `features/home/`.
- Uses normal Flutter theming and Navigator routing.
- Does not introduce `go_router`.

## Validation Plan

- `flutter pub get`
- `dart format --set-exit-if-changed .`
- `flutter analyze`
- `flutter test`

## Completion Notes

- Applied the Stitch palette with parent role defaults.
- Added dark navy-tinted surfaces and accessible text/component colors.
- `flutter pub get`, `dart format --set-exit-if-changed .`, `flutter analyze`, and `flutter test` passed.
