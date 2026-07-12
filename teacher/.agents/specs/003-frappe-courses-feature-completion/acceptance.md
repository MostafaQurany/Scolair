# Acceptance: Frappe Courses Feature Completion

All of the following criteria have been successfully implemented and verified:

## 1. Course CRUD
- [x] Listing courses shows list and search tab.
- [x] FAB button navigates to `CourseFormScreen` for creation.
- [x] PopupMenu action on Course details screen allows Editing or Deleting the course.
- [x] Confirmation dialog triggers on deletion.
- [x] State is refreshed automatically on pop back to list.

## 2. Chapter CRUD
- [x] Adding a chapter from Course Details outline header.
- [x] PopupMenu action on Chapter expansion tile allows editing the title or deleting the chapter.
- [x] Confirmation dialog on deletion.
- [x] Refresh outline after completion.

## 3. Lesson CRUD
- [x] Creating a lesson from the chapter expansion tile.
- [x] Content type dropdown allows switching inputs dynamically.
- [x] Media uploads (Video, PDF) use `file_picker` and call multipart upload.
- [x] Details screen PopupMenu supports Editing or Deleting lessons.
- [x] Auto-refresh on updates.

## 4. Decoupled Block Renderer
- [x] Monolithic `editorjs_renderer.dart` refactored into a thin router (< 100 lines).
- [x] 16 block types supported (header, paragraph, list, image, youtube, video upload, pdf upload, quiz, code, table, quote, raw, checklist, delimiter, linkTool, fallback).
- [x] Inline HTML parser handles bold, italic, underline, mark, and inline code formatting.
