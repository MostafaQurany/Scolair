# Scolair Project Memory

This file helps future agents understand the current work state without relying on chat history.

## Current Status

- Branch: `parent`
- Project stage: Flutter starter app with shared agent workflow
- Main rule source: `.agent/project-rules.md`
- Spec workflow: lightweight specs in `.agent/specs/`

## Completed Work

- Created `.agent/project-rules.md` as the shared Flutter rules file.
- Added Flutter architecture rules for `app/`, `core/`, and `features/`.
- Added Cubit, Freezed, Dio, Retrofit, `get_it`, and `flutter_screenutil_plus` rules.
- Added data model naming rules for `name_request_data.dart` and `name_response_data.dart`.
- Added package selection rules requiring current, supported packages.
- Added this project memory file and the spec template workflow.
- Updated `.agent/project-rules.md` with the required agent workflow for reading and updating memory/spec files.
- Added official Flutter localization rules with `flutter_localizations`, `intl`, ARB files, generated `AppLocalizations`, and `MaterialApp` setup.
- Created `.agent/specs/flutter-localization-setup.md` to record the localization rule update.
- Simplified localization usage rules to prefer `context.l10n.keyName` through a project extension.
- Added localization best practices for modals, placeholders, plurals, RTL layouts, text expansion, and translation QA.
- Initialized the `student` branch as a Flutter Android+iOS app with starter architecture, packages, localization, DI, networking, storage, theme, and a Home feature.
- Initialized the `parent` branch as a Flutter Android+iOS app with starter architecture, packages, localization, DI, networking, storage, theme, and a Home feature.
- Applied the Stitch Scolair theme system to the `parent` branch with light/dark Material 3 themes, Hanken Grotesk typography, and parent role-tone defaults.

## In-Progress Tasks

- None currently.

## Next Tasks

- Add Cursor and root agent instruction files if stronger rule loading is needed.
- Create a feature spec in `.agent/specs/` before starting any major Flutter feature.
- Continue building real features inside `lib/features/` using small widgets, Cubit, Freezed states, DI, Retrofit/Dio networking, and normal Flutter Navigator routing.
- Use the Stitch theme tokens for future UI work instead of hardcoded colors.

## Open Questions

- None currently.

## Validation History

- 2026-06-14: Documentation-only setup. Flutter validation was not run because no Flutter code exists yet.
- 2026-06-14: Studied `flutter_localization` package docs and added localization rules. Flutter validation was not run because no Flutter code exists yet.
- 2026-06-14: Simplified localization usage guidance to use a context extension. Flutter validation was not run because no Flutter code exists yet.
- 2026-06-14: Reworked localization rules to match the provided official Flutter localization guide: `flutter_localizations`, `intl`, ARB files, generated `AppLocalizations`, RTL, placeholders, plurals, modals, and QA. Flutter validation was not run because no Flutter code exists yet.
- 2026-06-14: Initialized the `student` Flutter app. `flutter pub get`, code generation, `dart format --set-exit-if-changed .`, `flutter analyze`, and `flutter test` passed.
- 2026-06-14: Updated localization import guidance to use local generated files under `lib/l10n/` for Flutter 3.44.
- 2026-06-14: Initialized the `parent` Flutter app. `flutter pub get`, code generation, `dart format --set-exit-if-changed .`, `flutter analyze`, and `flutter test` passed.
- 2026-06-15: Applied the Stitch Scolair theme system on `parent`. `flutter pub get`, `dart format --set-exit-if-changed .`, `flutter analyze`, and `flutter test` passed.

## Notes For Future Agents

- Read `.agent/project-rules.md` before making changes.
- Read this file before starting work to understand project progress.
- If a task has a related spec in `.agent/specs/`, read and update that spec.
- Do not mark tasks as `done` unless the work and required validation are actually complete.
