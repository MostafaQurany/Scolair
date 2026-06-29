# Courses Search, Filter, And Refresh Tasks

Status: `in_progress`

## Checklist

- [x] Read `.agent/project-rules.md`.
- [x] Read `.agent/project-memory.md`.
- [x] Inspect Courses screen, Cubit, repository, datasource, API client, theme, and localization.
- [x] Extend `listCourses` through the existing API flow.
- [x] Add server-side search and published filter state.
- [x] Add pull-to-refresh that preserves active filters.
- [x] Add localized loading, empty, error, and success states.
- [x] Update spec-kit files.
- [x] Update README and project docs.
- [x] Run code generation.
- [x] Run formatting.
- [x] Run scoped analyzer for changed implementation files.
- [ ] Run full analyzer without pre-existing warnings.

## Completion Notes

- Status: implemented with project-level analyzer blocked by unrelated existing issues.
- Completed work: server-side search/filter, pull-to-refresh, UI states, specs, and docs.
- Validation run: `dart run build_runner build --delete-conflicting-outputs`, `flutter gen-l10n`, `dart format .`, scoped `dart analyze` for changed implementation files, and full `flutter analyze`.
- Skipped validation: no unit or Flutter tests were added because the task explicitly excluded tests.
- Analyzer note: scoped analyzer passed for the changed API/data/Cubit/screen/widget files. Full `flutter analyze` still fails on existing auth/home warnings and deprecated API infos outside this change.
