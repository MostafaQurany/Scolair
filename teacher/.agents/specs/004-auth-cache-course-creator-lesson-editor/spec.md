# Auth Cache, Course Creator Permissions, And Lesson Editor

Status: `implemented`

## Goal

Persist login user data locally, redirect signup success to login, gate course mutation UI by Course Creator ownership, improve course/chapter/lesson creation flows, and fix lesson rendering for Markdown and YouTube blocks.

## Success Criteria

- Login stores user profile fields and a cached `isCourseCreator` bool in shared preferences.
- Signup success returns to login instead of entering the authenticated shell.
- Course, chapter, and lesson create/edit/delete controls are only shown to Course Creator users whose cached user name or email matches `CourseModel.owner`.
- Course creation supports required title, description, short introduction, plus image upload or manual image path.
- Chapter create/edit is a compact name-only dialog and sends `is_scorm_package: false`.
- Lesson create/edit supports ordered Markdown, YouTube, video upload, and PDF upload parts with drag reorder.
- Lesson details render `markdown` blocks and YouTube blocks offer an external-open fallback.

## Scope

In scope:

- Auth response parsing, shared preference helpers, DI updates, course permission helper, forms, renderer widgets, localization, package addition.

Out of scope:

- Backend permission enforcement, full analyzer cleanup, unit tests, and generated Freezed/Retrofit regeneration.

## Task Checklist

- [x] Read `.agent/project-rules.md`.
- [x] Read `.agent/project-memory.md`.
- [x] Confirm affected files and folders.
- [x] Implement the planned change.
- [x] Run allowed validation.
- [x] Update this spec with completion notes.
- [x] Update `.agent/project-memory.md` if the project state changed.

## Files Expected To Change

- `lib/core/storage/app_shared_preferences.dart`
- `lib/features/auth/`
- `lib/features/courses/`
- `lib/l10n/`
- `pubspec.yaml`, `pubspec.lock`

## Architecture And Rules Impact

- Auth caching stays in `core/storage` and the auth repository.
- Course permission logic stays in the courses presentation layer as a UI gate.
- API calls remain behind repositories/use cases and Cubits.
- New visible text is localized in ARB files and generated localization output.
- `build_runner`, `flutter analyze`, `flutter test`, and unit tests were intentionally not run per user request.

## Validation Plan

- `flutter pub add flutter_markdown_plus`
- `flutter gen-l10n`
- `dart format` on changed files
- Focused manual source inspection

## Completion Notes

- Status: implemented pending manual app flow verification on device/simulator.
- Completed work: auth user cache, signup redirect, Course Creator ownership UI gating, course image upload/manual path, chapter dialog, multi-part lesson editor, Markdown block rendering, YouTube fallback.
- Validation run: package resolution, localization generation, formatting.
- Skipped validation: `build_runner`, `flutter analyze`, `flutter test`, and unit tests per user request.
- Follow-up tasks: manually verify login, signup, owner/non-owner course controls, lesson reorder/save, Markdown display, and YouTube playback on target devices.
