# Spec: Frappe Courses Feature Completion

This specification details the completion of the full CRUD flows and robust Editor.js rendering for the Frappe LMS Courses feature in the teacher Flutter application.

## 1. Objectives

- Complete Course CRUD (Create, Read, Update, Delete) forms and logic.
- Complete Chapter CRUD (Create, Update, Delete) forms and logic.
- Complete Lesson CRUD (Create, Update, Delete) forms and logic, including media uploads (Videos, PDFs).
- Deliver a robust, decoupled, and highly responsive Editor.js content parser and renderer capable of rendering 16 different block types.
- Ensure all screens conform strictly to the clean architecture guidelines and are under the 250-line limit.

## 2. Architecture & Design

### Data Layer
- Models updated to support `UploadFileResponseData` and `UploadFileMessage` to capture URL responses from Frappe.
- Remote datasource, repository, and use cases updated with expanded CRUD parameters (e.g. `description`, `shortIntroduction`, `videoLink`, `published`, etc.).

### State Management
- Implemented `CourseFormCubit` and `LessonFormCubit` to isolate form validation and submission.
- Updated `CoursesCubit`, `CourseDetailsCubit`, and `LessonDetailsCubit` to expose CRUD methods and handle mutation states.

### Content Rendering
- Decoupled parser (`EditorJsContentParser`) translates JSON content to structured Dart objects.
- `editorjs_renderer.dart` acts as a dispatcher to 16 specialized widgets located under `lib/features/courses/presentation/widgets/lesson_content/`.
- Embedded `youtube_player_iframe` for inline video playback.
- Handled private video and PDF files via download/open fallbacks utilizing `url_launcher`.

## 3. Localization

- Added full English (`app_en.arb`) and Arabic (`app_ar.arb`) translation keys covering Course, Chapter, and Lesson forms, validation errors, and block renderer placeholders.
