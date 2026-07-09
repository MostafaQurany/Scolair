# Flutter Localization Setup

Status: `done`

## Goal

Add project rules for using Flutter official localization consistently across the Scolair Flutter branches.

## Success Criteria

- `.agent/project-rules.md` explains where localization files belong.
- The rules explain how to use `flutter_localizations`, `intl`, ARB files, and generated `AppLocalizations`.
- The rules prefer `context.l10n.keyName` for simple widget usage.
- The rules include placeholders, plurals, RTL, modals, and localization QA.
- Project memory records the new localization rule update.

## Scope

In scope:

- Documentation and agent rules for Flutter official localization.
- Project memory update.
- Spec record for future agents.

Out of scope:

- Editing `pubspec.yaml`.
- Creating real Flutter localization Dart files.
- Creating real ARB translation files.

## Task Checklist

- [x] Read `.agent/project-rules.md`.
- [x] Read `.agent/project-memory.md`.
- [x] Study current localization guidance and the provided reference text.
- [x] Update `.agent/project-rules.md`.
- [x] Update `.agent/project-memory.md`.
- [x] Record completion notes.

## Files Expected To Change

- `.agent/project-rules.md`
- `.agent/project-memory.md`
- `.agent/specs/flutter-localization-setup.md`

## Architecture And Rules Impact

- Adds `core/localization/localization_extension.dart` as the simple usage layer over generated `AppLocalizations`.
- Adds `lib/l10n/` for ARB translation files.
- Requires `flutter_localizations`, `intl`, `flutter.generate`, and `l10n.yaml` setup.
- Requires widgets to use `context.l10n.keyName` instead of hardcoded user-facing strings.
- Adds rules for placeholders, plurals, RTL layouts, modals, text expansion, and localization QA.

## Validation Plan

- Manual Markdown review.
- No Flutter validation because no Flutter source files or `pubspec.yaml` exist yet.

## Completion Notes

- Status: `done`
- Completed work: Reworked localization rules to match the provided Flutter localization guide, including official packages, ARB files, generated localizations, and simple `context.l10n` usage.
- Validation run: Manual Markdown review.
- Skipped validation: `dart format .`, `flutter analyze`, and `flutter test` were skipped because this is documentation-only and the Flutter project files do not exist yet.
- Follow-up tasks: When the Flutter app is created, enable Flutter official localization in `pubspec.yaml`, add `l10n.yaml`, create ARB files, and create the real localization extension.
