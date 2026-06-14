# Spec Title

Status: `planned`

## Goal

Describe the exact goal of this work.

## Success Criteria

- The expected behavior is clear.
- The user-facing or developer-facing result is complete.
- Required validation passes or skipped validation is explained.

## Scope

In scope:

- Add the intended work here.

Out of scope:

- Add anything that should not be changed here.

## Task Checklist

- [ ] Read `.agent/project-rules.md`.
- [ ] Read `.agent/project-memory.md`.
- [ ] Confirm affected files and folders.
- [ ] Implement the planned change.
- [ ] Run required validation.
- [ ] Update this spec with completion notes.
- [ ] Update `.agent/project-memory.md` if the project state changed.

## Files Expected To Change

- Add expected files or folders here.

## Architecture And Rules Impact

- Note how this work follows project structure, Cubit, Freezed, networking, DI, storage, theme, navigation, package, and responsive UI rules.
- Record any approved exception to `.agent/project-rules.md`.

## Validation Plan

- `dart format .`
- `flutter analyze`
- `flutter test`
- `dart run build_runner build --delete-conflicting-outputs` if Freezed, Retrofit, or generated models changed.

If validation is skipped, record the reason.

## Completion Notes

- Status:
- Completed work:
- Validation run:
- Skipped validation:
- Follow-up tasks:
