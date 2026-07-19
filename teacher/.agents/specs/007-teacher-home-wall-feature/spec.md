# Feature Spec — Teacher Home & Learning Wall

## Goal
Build the complete teacher-facing Home Dashboard and Learning Wall feed screen.

## Scope
- time-adapted greetings (Good Morning, Afternoon, Evening) with localized placeholders.
- Organization notices card showing notice count dynamically using plurals.
- Scrollable class/subject filters loaded from data sources.
- Infinite scroll feed of wall posts with support for all 9 types (Announcement, Discussion, Question, etc.).
- Robust optimistic like toggle UI with rollbacks on failure.
- AppUserAvatar core widget supporting deterministic stable color background hash and Unicode initials (safe for Arabic).
- Skeletonizer shimmer on first load.
- Local mock data source to simulate paginated REST results.
- 100% compliant English and Arabic RTL localizations.

## Non-Goals
- Real API networking (deferred until endpoint `/api/method/scolair.teacher.home` is available).
- Floating Action Button action screen (FAB itself is deferred as a follow-up task).
- Real comments screen (taps on comment button route to stub name `/wall-post-comments`).

## Architecture Decisions
- Feature-first clean architecture located in `lib/features/home/`.
- Concrete state machine implemented via sealed Freezed `TeacherHomeState` union in `HomeCubit`.
- Local mock data source `TeacherHomeLocalDataSourceImpl` registered under dependency injection `getIt` locator.
- User profile cache read directly from `AppSharedPreferences` inside `TeacherHomeRepositoryImpl`.

## API Contract (Proposed)
- `GET /api/method/scolair.teacher.home`
- Query parameters: `filter_id` (String?), `page` (int), `page_size` (int)
- Response structure wraps details of current teacher, greeting, organization notices, filters, list of posts, and page metadata in a `message` wrapper.

## Tasks & Status
- [x] Delete old summary stub files
- [x] Define domain entities and repositories
- [x] Write mock request and response data models
- [x] Write domain/data layer mapper
- [x] Implement local mock data source with realistic mock posts
- [x] Integrate repository with cached user data from SharedPreferences
- [x] Build AppUserAvatar with stable color selection & initials logic
- [x] Implement TeacherHomeCubit & Freezed TeacherHomeState
- [x] Setup English & Arabic ARB localization files
- [x] Build presentation widgets (AppBar, Greeting, Notice Card, Filter list, Post cards, Engagement bar, Empty/Error/Skeleton views)
- [x] Wire HomeScreen and HomeView
- [x] Configure dependency injection setup
- [x] Run code generation, format, and static analysis

## Validation & Verification
- `dart run build_runner build` completed clean.
- `flutter gen-l10n` generated translation classes.
- `dart format .` formatted all source code files.
- `flutter analyze` verified static correctness.
