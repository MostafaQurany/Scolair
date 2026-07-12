# Question Center And Bank Filters

Status: `in_progress`

## Goal

Create a reusable Question Center feature for question CRUD, paginated bank listing, dropdown filters, and quiz import selection.

## Success Criteria

- Question CRUD calls use `lms.question.controllers.*`.
- Question bank supports `type`, `quiz`, `homework`, `lesson`, `chapter`, `course`, `start`, and `page_size`.
- Filter changes reset pagination and preserve full selected question objects keyed by question `name`.
- Quiz import blocks invalid mixes between auto-graded and manual question types.
- New question UI is reusable outside quiz screens and includes widget previews for main states.

## Scope

In scope:

- New `features/question/` feature.
- Question API, repository, use cases, Cubits, screens, widgets, and previews.
- Quiz screen import updates to consume the reusable question bank.
- Localization and generated code updates.

Out of scope:

- Server-side question text search until the backend exposes a supported query.
- Real homework API integration; v1 uses the existing local mock homework data.

## Task Checklist

- [x] Read `.agent/project-rules.md`.
- [x] Read `.agent/project-memory.md`.
- [x] Confirm affected files and folders.
- [ ] Implement the planned change.
- [ ] Run required validation.
- [ ] Update this spec with completion notes.
- [ ] Update `.agent/project-memory.md` if the project state changed.

## Files Expected To Change

- `lib/core/network/api_client.dart`
- `lib/core/network/api_endpoints.dart`
- `lib/core/di/dependency_injection.dart`
- `lib/features/question/`
- `lib/features/quiz/`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_ar.arb`

## Architecture And Rules Impact

- The new feature follows the project data/domain/presentation layering.
- Question widgets remain feature-specific under `features/question/presentation/widgets/`.
- Existing quiz models remain the shared API model source for this pass to avoid a broad generated-model migration.
- All user-visible strings are localized.

## Validation Plan

- `dart run build_runner build --delete-conflicting-outputs`
- `flutter gen-l10n`
- `dart format .`
- Scoped `dart analyze` for changed question/quiz/network/localization files.
- `flutter analyze` if existing unrelated warnings are manageable to report.

## Completion Notes

- Status:
- Completed work:
- Validation run:
- Skipped validation:
- Follow-up tasks:
