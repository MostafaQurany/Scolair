# Scolair Project Memory

This file helps future agents understand the current work state without relying on chat history.

## Current Status

- Branch: `teacher`
- Project stage: agent rules and project workflow setup
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
# Scolair Project Memory

This file helps future agents understand the current work state without relying on chat history.

## Current Status

- Branch: `teacher`
- Project stage: agent rules and project workflow setup
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
- Initialized the `teacher` branch as a Flutter Android+iOS app with starter architecture, packages, localization, DI, networking, storage, theme, and a Home feature.
- Applied the Stitch Scolair theme system to the `teacher` branch with light/dark Material 3 themes, Hanken Grotesk typography, and teacher role-tone defaults.
- Added the LMS adaptive navigation UI foundation on `teacher` with parent-controlled bottom nav, compact rail, expanded rail/sidebar, localized labels, and reusable width breakpoint extensions.
- Added `HomeLayout` as the authenticated app shell route and routed auth/splash success flows to `/home-layout` to avoid duplicate Home route stacking.
- Implemented Courses Browse All server-side search by `name`, published filtering with Frappe encoded `filters`, pull-to-refresh, localized UI states, and `.agent/specs/002-courses-search-filter-refresh/`.
- Completed the full Courses feature on `teacher`, including CRUD (Create, Edit, Delete) for Courses, Chapters, and Lessons, media file upload handling, and a modular Editor.js parser + 16 custom block widgets.
- Implemented auth user caching and Course Creator ownership UI gating on `teacher`, including signup redirect to login, course image upload/manual path, name-only chapter dialog, ordered multi-part lesson creation, Markdown lesson rendering, and YouTube external fallback.
- Implemented biometric login opt-in flow (`BiometricRequestScreen` + `BiometricRequestCubit`), courses shimmer loading (`CoursesListShimmer` via `skeletonizer: ^2.1.3`), and cached network images (`AppCachedNetworkImage`) replacing bare `NetworkImage` in `CourseCard` and `CourseHeaderCard`.
- Implemented the teacher homework viewing flow against `list_homeworks`: handwritten defensive API models, published/draft filters, pagination, refresh/retry behavior, responsive sliver list/grid, skeleton loading, localized empty/error states, and API-accurate cards without fabricated submission progress.
- Added `AppDateTimeFormatter` as the shared locale-aware date parsing/formatting utility, documented its usage in project rules, and aligned the homework status filter with the Question Bank expandable filter pattern.
- Added the real homework delete flow with a card overflow action, confirmation dialog, DELETE query request, per-item mutation protection, and localized success/error feedback. Homework editing remains deferred.
- Hardened homework card constraints for sliver lists and grids by removing vertical flex, accommodating optional metadata on tablets, and matching the skeleton structure to the real card.
- Implemented the complete Teacher Home & Learning Wall feature: deleted stub folder content, created domain/data/presentation layers, built AppUserAvatar core initials fallback, implemented time-adapted greetings, organization notice plural cards, horizontal filter lists, optimistic likes with rollback, and comprehensive EN/AR RTL translation keys.

## In-Progress Tasks

- Apply the Stitch Scolair theme system to the `student` and `parent` branches.

## Next Tasks

- Add Cursor and root agent instruction files if stronger rule loading is needed.
- After approval, copy or merge `.agent/project-rules.md` and `.agent/project-memory.md` into `parent` and `teacher`.
- Create a feature spec in `.agent/specs/` before starting any major Flutter feature.
- When the Flutter app files exist, enable `flutter_localizations`, `intl`, `flutter.generate`, `l10n.yaml`, `core/localization/localization_extension.dart`, and `lib/l10n/` ARB files.
- Repeat the Flutter initialization setup on the `parent` branch.
- Apply the same Stitch theme system to `student` and `parent` with branch-specific role-tone defaults.
- Replace `HomeLayout` placeholder tab bodies with real Classes, Students, Messages, and Schedule features.
- Clear existing full-project analyzer warnings in auth/home/course detail/editor files so full `flutter analyze` can pass.

## Open Questions

- None currently.

## Validation History

- 2026-06-14: Documentation-only setup. Flutter validation was not run because no Flutter code exists yet.
- 2026-06-14: Studied `flutter_localization` package docs and added localization rules. Flutter validation was not run because no Flutter code exists yet.
- 2026-06-14: Simplified localization usage guidance to use a context extension. Flutter validation was not run because no Flutter code exists yet.
- 2026-06-14: Reworked localization rules to match the provided official Flutter localization guide: `flutter_localizations`, `intl`, ARB files, generated `AppLocalizations`, RTL, placeholders, plurals, modals, and QA. Flutter validation was not run because no Flutter code exists yet.
- 2026-06-14: Initialized the `student` Flutter app. `flutter pub get`, code generation, `dart format --set-exit-if-changed .`, `flutter analyze`, and `flutter test` passed.
- 2026-06-14: Updated localization import guidance to use local generated files under `lib/l10n/` for Flutter 3.44.
- 2026-06-14: Initialized the `teacher` Flutter app. `flutter pub get`, code generation, `dart format --set-exit-if-changed .`, `flutter analyze`, and `flutter test` passed.
- 2026-06-15: Applied the Stitch Scolair theme system on `teacher`. `flutter pub get`, `dart format --set-exit-if-changed .`, `flutter analyze`, and `flutter test` passed.
- 2026-06-27: Implemented LMS adaptive navigation UI foundation on `teacher`. `dart format .` ran, scoped analyzer for new navigation/localization files passed, full `flutter analyze` and `flutter test` still fail on existing unrelated issues.
- 2026-06-27: Added `HomeLayout` route wiring and startup stack fix. Validation results are recorded in `.agent/specs/001-lms-adaptive-navigation/tasks.md`.
- 2026-06-28: Implemented Courses search/filter/refresh. `dart run build_runner build --delete-conflicting-outputs`, `flutter gen-l10n`, `dart format .`, and scoped `dart analyze` for changed implementation files passed. Full `flutter analyze` still fails on unrelated existing warnings and deprecated API infos.
- 2026-06-28: Completed Frappe LMS Courses feature implementation on `teacher`. Added packages, generated code (`build_runner` and `gen-l10n`), refactored monolithic renderer to 16 clean widgets (<250 lines/file limit), built Course/Chapter/Lesson CRUD flows, and updated English/Arabic localization. `dart format .` and local code generation verified successfully.
- 2026-06-28: Scanned all files in `features/courses/` for 100% compliance with `.agent/project-rules.md`. Fixed unscaled font family configurations (changed to `GoogleFonts.dmSans`), hardcoded directional properties (replaced with `BorderDirectional`, `EdgeInsetsDirectional`, `TextAlign.start` for RTL support), and replaced direct `ScaffoldMessenger` calls with the project's compliant `AppSnackBar` helper. Static analysis completed clean.
- 2026-06-29: Implemented `.agent/specs/004-auth-cache-course-creator-lesson-editor/`. Ran `flutter pub add flutter_markdown_plus`, `flutter gen-l10n`, and scoped `dart format` on changed Dart/localization files. Skipped `build_runner`, `flutter analyze`, `flutter test`, and unit tests per user request.
- 2026-07-12: Implemented `.agents/specs/006-homework-list-api/spec.md`. Ran `flutter gen-l10n` and scoped `dart analyze` successfully. Skipped `build_runner`, `dart format`, and `flutter test` per user request.
- 2026-07-12: Fixed the homework loading skeleton's unbounded-height RenderFlex crash by removing its `Spacer`. Runtime logs also confirmed the server returns `403 Not permitted` for the current account; that permission response is external to the Flutter layout fix.
- 2026-07-12: Corrected `list_homeworks` from POST body usage to GET query parameters after the working Postman collection showed the endpoint's actual HTTP method. The method mismatch was the source of the Flutter client's 403.
- 2026-07-12: Added the shared date/time formatter and project rule section, migrated homework date parsing/display, and restyled the homework filter to match Question Bank. Validation remained scoped with no formatting, build generation, or Flutter tests per user constraints.
- 2026-07-12: Connected the homework card Delete action to `lms.homework.controllers.delete_homework`, using `homework=<name>` as a DELETE query parameter. Edit remains out of scope.
- 2026-07-12: Scanned the homework runtime error log. One unbounded-height `Expanded` in `HomeworkCard` caused all subsequent render failures; removed it and updated the feature shimmer. Scoped analysis passed without running tests, formatting, or code generation.
- 2026-07-19: Implemented Teacher Home & Learning Wall feature. Ran `dart run build_runner build --delete-conflicting-outputs`, `flutter gen-l10n`, `dart format .` and verified that static analysis completed successfully with zero compiler errors in the new home feature.

## Notes For Future Agents

- Read `.agent/project-rules.md` before making changes.
- Read this file before starting work to understand project progress.
- If a task has a related spec in `.agent/specs/`, read and update that spec.
- Do not mark tasks as `done` unless the work and required validation are actually complete.
