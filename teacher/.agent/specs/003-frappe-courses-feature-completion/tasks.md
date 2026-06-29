# Tasks: Completed Course Feature Implementation

- [x] Add packages to `pubspec.yaml` (`youtube_player_iframe`, `url_launcher`, `file_picker`, `cached_network_image`).
- [x] Add `UploadFileResponseData` and `UploadFileMessage` json models to `courses_models.dart`.
- [x] Update `ApiClient` and remote datasource to return upload file URL.
- [x] Expand `CoursesRepository` and implementation methods for Course/Lesson update flows.
- [x] Update existing states (`CoursesState`, `CourseDetailsState`, `LessonDetailsState`) with mutation flags.
- [x] Create `CourseFormCubit` and `LessonFormCubit` for CRUD operations.
- [x] Run code generation (`build_runner` and `gen-l10n`).
- [x] Build decoupled `EditorJsContentParser` and helpers (HTML tags `<b>`, `<i>`, `<u>`, `<mark>`, `<code>`).
- [x] Implement 16 separate block renderer widgets.
- [x] Create form screens (`CourseFormScreen`, `ChapterFormScreen`, `LessonFormScreen`) and deletion confirmation dialog.
- [x] Refactor `CourseDetailsScreen` and `LessonDetailsScreen` to fit under 250 lines.
- [x] Register new Cubits in DI setup.
- [x] Add English and Arabic localization keys.
