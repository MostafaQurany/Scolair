# Courses Search, Filter, And Refresh

Status: `in_progress`

## Goal

Add server-side course search, published filtering, and pull-to-refresh to the teacher Courses screen while preserving the existing Cubit, repository, remote datasource, Retrofit, Dio, theme, localization, and native Navigator architecture.

## Success Criteria

- Browse All courses can be searched by course `name` using the server.
- Browse All courses can be filtered by published state using the server.
- Search and published filter are combined in one encoded `filters` query parameter.
- Pull-to-refresh reloads server data and preserves active Browse All filters.
- My Courses remains loaded through the existing `myCourses` endpoint.
- Loading, empty, error, and success states are visible and localized.
- `dart format .` and `flutter analyze` are run after implementation.

## Scope

In scope:

- Extend the existing `listCourses` API flow to accept optional filters.
- Update the Courses Cubit state and screen UI.
- Add local spec and documentation updates.

Out of scope:

- Backend/Frappe changes.
- New routing packages or state management packages.
- Unit tests or Flutter tests.
- Server-side filters for `myCourses`, because no endpoint contract was provided.

## Architecture And Rules Impact

- Uses `ApiClient`, `CoursesRemoteDataSource`, `CoursesRepository`, use cases, and `CoursesCubit`.
- Keeps Dio/auth/logging behavior centralized in `core/network`.
- Uses `jsonEncode` for Frappe `filters` instead of URL string concatenation.
- Uses localized strings, app theme colors, ScreenUtil sizing, and native Navigator routing.

## Validation Plan

- `dart run build_runner build --delete-conflicting-outputs`
- `flutter gen-l10n`
- `dart format .`
- `flutter analyze`
