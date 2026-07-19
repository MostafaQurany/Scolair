# Homework List API And Responsive UI

Status: `done`

## Goal

Replace the mock-backed homework viewing flow with the paginated
`list_homeworks` GET endpoint and a resilient, responsive sliver UI.

## Success Criteria

- Homework is loaded from the real endpoint with status filters and pagination.
- Initial, empty, success, refresh-error, pagination-error, and terminal states work.
- The screen adapts between a mobile list and tablet grid without overflow.
- API fields are represented faithfully; unavailable submission progress is not invented.

## Scope

In scope:

- Homework list networking, models, repository, use case, Cubit, DI, localization, and UI.
- Published/draft filtering, refresh, infinite scrolling, and retry handling.

Out of scope:

- Real create, edit, duplicate, submission, or homework-details endpoints.
- Changes to the existing homework form flow beyond dependency compatibility.

## Task Checklist

- [x] Read `.agents/project-rules.md`.
- [x] Read `.agents/project-memory.md`.
- [x] Confirm affected files and folders.
- [x] Implement handwritten API models and remote data source.
- [x] Implement paginated repository/use-case/Cubit flow.
- [x] Implement localized responsive sliver UI states.
- [x] Run scoped static analysis only.
- [x] Update this spec and `.agents/project-memory.md`.

## Architecture And Rules Impact

- Uses the shared configured Dio instance and `ErrorHandler` conversion point.
- Uses handwritten immutable models/state because code generation is explicitly forbidden.
- Keeps the legacy mock datasource only for the existing form mutations.
- All visible copy is localized and layouts use directional properties.

## Validation Plan

- Run scoped `dart analyze` for affected files.
- Do not run `build_runner`, `dart format`, or `flutter test`, per user instruction.

## Completion Notes

- Status: Complete.
- Completed work: Real GET list and DELETE endpoints, defensive parsing, filters, pagination, refresh, responsive slivers, shimmer, localized states, and details preview.
- Validation run: Scoped `dart analyze` passed with no issues.
- Skipped validation: `build_runner`, `dart format`, and `flutter test` were explicitly excluded by the user.
- Follow-up fix: Removed a flex child from the mobile sliver skeleton after a runtime unbounded-height assertion.
- HTTP correction: Runtime comparison with the working Postman collection confirmed this endpoint is GET, not POST. Pagination and filters are now sent as query parameters; the previous POST method caused the 403 response.
- UI consistency: Reworked the status filter to use the Question Bank expandable filter-trigger pattern.
- Shared utility: Added locale-aware `AppDateTimeFormatter`, migrated homework API parsing/display to it, and documented its required usage in project rules.
- Delete action: Added the real DELETE request using the homework name query parameter, confirmation UI, per-item progress protection, optimistic list removal after success, and localized feedback.
- Layout hardening: Removed the remaining vertical `Expanded` from `HomeworkCard`, which caused the mobile sliver's unbounded-height failure and every cascading render assertion in the captured log. Increased tablet grid height for optional metadata and rebuilt the shimmer to mirror the production card structure without flex children.
