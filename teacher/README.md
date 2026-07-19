# scolair_teacher

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Courses Screen

- Browse All courses use server-side Frappe filters through the existing `list_courses` endpoint.
- Published filters map to `0` for unpublished and `1` for published.
- Course name search maps to `["like", "%query%"]`.
- Pull-to-refresh preserves the active search text and published filter.

## Teacher Home & Learning Wall
- Combines a Greeting header (adapting to morning/afternoon/evening) with a scrollable Learning Wall feed.
- High-fidelity shimmer loads using `skeletonizer`.
- Horizonally-scrollable class/subject filters reset the feed and pagination on tap.
- Uses `AppUserAvatar` which displays initials and a stable color based on a deterministic hash of user details if profile image is absent.
- Full optimistic likes toggle reaction count immediately and roll back on API connection errors.
- Mocked via `TeacherHomeLocalDataSourceImpl` using Clean Architecture repository use cases.

