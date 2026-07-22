Below is the complete copy-ready Markdown content for the **teacher-facing Flutter mobile application**, based on the supplied LMS Courses API collection. 

````markdown
# Teacher Mobile Courses Feature

## Flutter + Frappe LMS API Specification

> **Application:** Scolair Teacher Mobile Application  
> **Mobile framework:** Flutter and Dart  
> **Backend:** Frappe LMS  
> **Feature:** Courses, Chapters, Lessons, Students, Instructors, and Lesson Media  
> **Main hierarchy:** `Course → Chapter → Lesson`  
> **API coverage:** 27 unique routes represented by 51 Postman requests and test cases

---

# 1. Purpose

Implement the complete teacher-side Courses feature in the Flutter mobile application.

The feature must allow an authorized teacher to:

1. View courses they own.
2. View courses shared with them.
3. Create and update courses.
4. Publish or unpublish courses using supported course fields.
5. Delete courses safely.
6. Create, update, and delete chapters.
7. Create, update, preview, and delete lessons.
8. Build lessons using dynamic EditorJS content blocks.
9. Upload private videos, PDFs, images, and audio files.
10. Stream private lesson files through the authorized Frappe endpoint.
11. Add and remove students.
12. View enrolled students.
13. Add and remove other instructors.
14. Preview the course as a student.
15. Protect instructor-only content from the student preview.
16. Handle loading, empty, error, retry, validation, and permission states.

The mobile application must be implemented in Flutter even if older architecture documents mention React Native.

---

# 2. Required Skills

The implementation should use the following skills:

- Flutter
- Dart
- BLoC or Cubit
- Existing Scolair project architecture
- Feature-first clean architecture
- Dio or the existing network client
- Frappe REST and whitelisted-method APIs
- Multipart file uploads
- Authenticated media streaming
- Dynamic JSON parsing
- Form validation
- Mobile UI and UX
- Widget testing
- Unit testing
- Integration testing
- Accessibility
- Localization
- RTL support

---

# 3. Required MCPs and Repository Tools

The coding agent must use the available repository and development tools when needed.

Recommended tools:

- Repository file search
- GitHub MCP
- Terminal and build tools
- Flutter analyzer
- Flutter test runner
- Existing project documentation
- Existing API client and authentication implementation
- Existing design system and reusable widgets

Before creating new classes, search for existing implementations related to:

```text
Course
Chapter
Lesson
Quiz
Assignment
Media upload
Video player
PDF viewer
User avatar
Pagination
API envelope
Network errors
Authentication
Cubit states
Forms
Dialogs
Navigation
```

Do not introduce a second networking library, state-management library, navigation system, or design system unless the project already requires it.

---

# 4. Important Architecture Rules

```text
UI → Cubit/BLoC → Use Case/Repository → Remote Data Source → API
```

The following are not allowed:

```text
UI → Dio directly
Widget → API client directly
Widget → multipart upload directly
Widget → multiple mutation orchestration
```

The Cubit or use-case layer must manage workflows such as:

```text
Create lesson
→ Upload file
→ Insert returned file URL into lesson content
→ Update lesson
→ Reload lesson
```

Additional rules:

1. Do not modify Frappe core.
2. Do not read Frappe database tables directly.
3. Use only supported API routes.
4. Preserve unknown lesson block data.
5. Do not expose teacher-only content to students.
6. Require confirmation before destructive operations.
7. Preserve unsaved form values after API failures.
8. Use the backend as the final permission authority.
9. Do not assume hidden UI actions provide security.
10. Update documentation and spec-kit after implementation.

---

# 5. Base URL and Authentication

## 5.1 Base URL

```text
{{base_url}}
```

Example:

```text
https://lms.example.com
```

---

## 5.2 Authentication Header

All endpoints require a valid OAuth2 access token.

```http
Authorization: Bearer <access_token>
```

JSON requests should also use:

```http
Content-Type: application/json
```

File uploads use:

```http
Content-Type: multipart/form-data
```

Do not manually create the multipart boundary. Let Dio or the existing HTTP client create it.

---

# 6. Unified API Response Envelope

## 6.1 Success Response

```json
{
  "state": "success",
  "message": "Operation completed successfully",
  "data": {}
}
```

---

## 6.2 Error Response

```json
{
  "state": "error",
  "message": "Readable backend error"
}
```

---

## 6.3 HTTP Status Codes

| Status | Meaning | Teacher mobile behavior |
|---:|---|---|
| `200` | Successful operation | Parse and display the returned data |
| `401` | Missing or expired authentication | Run token refresh or logout flow |
| `403` | User lacks permission | Show permission error and disable unavailable action |
| `404` | Resource does not exist | Show not-found state and refresh the parent list |
| `417` | Validation or business-rule error | Show backend message near the related form or action |
| Other `4xx` | Client request error | Show normalized request error |
| `5xx` | Server failure | Preserve draft and offer retry |

Always prefer the backend `message` when it is safe and user-readable.

---

# 7. Teacher Permission Model

| Operation | Required access |
|---|---|
| Read/list courses | Authenticated user with access |
| Create course | Course Creator or Moderator |
| Update course | Course Instructor or Moderator |
| Delete course | Course Instructor or Moderator |
| Create chapter | Course Instructor or Moderator |
| Update chapter | Course Instructor or Moderator |
| Delete chapter | Course Instructor or Moderator |
| Create lesson | Course Instructor or Moderator |
| Update lesson | Course Instructor or Moderator |
| Delete lesson | Course Instructor or Moderator |
| Add student | Course Instructor or Moderator |
| Remove student | Course Instructor or Moderator |
| List students | Course Instructor or Moderator |
| Add instructor | Existing instructor or Moderator |
| Remove instructor | Existing instructor or Moderator |
| View instructor content | Course Instructor or Moderator |

A course must always retain at least one instructor.

---

# 8. Teacher Mobile Navigation

```text
Teacher Home
└── Courses
    ├── My Courses
    ├── Shared With Me
    ├── Create Course
    └── Course Details
        ├── Overview
        ├── Curriculum
        │   ├── Chapters
        │   ├── Lessons
        │   └── Student Preview
        ├── Students
        ├── Instructors
        └── Settings
```

---

# 9. Teacher Courses Screens

## 9.1 My Courses Screen

Displays courses owned or managed by the authenticated teacher.

Endpoint:

```http
GET /api/method/lms.courses.controllers.my_courses
```

The response changes according to the authenticated user:

```text
Teacher:
- Courses owned or instructed by the teacher

Student:
- Enrolled courses
- Progress
- Current lesson
```

The teacher application should use the teacher result.

Required UI states:

```text
Initial loading
Loaded
Empty
Refresh loading
Pagination loading if supported
Network error
Permission error
Retry
```

---

## 9.2 Shared Courses Screen

Displays courses where another teacher added the current user as an instructor.

```http
GET /api/method/lms.courses.controllers.shared_courses
```

Recommended screen design:

```text
AppBar: Shared With Me
Course cards:
- Course image
- Course title
- Owner/instructor
- Published status
- Student count when available
- Open course action
```

---

## 9.3 Course Details Screen

Recommended tabs:

```text
Overview
Curriculum
Students
Instructors
Settings
```

Load the course details first, then load the tab-specific data lazily.

---

# 10. Complete Endpoint Summary

| Method | Endpoint |
|---|---|
| `GET` | `/api/method/lms.courses.controllers.list_courses` |
| `GET` | `/api/method/lms.courses.controllers.get_course` |
| `POST` | `/api/method/lms.courses.controllers.create_course` |
| `PUT` | `/api/method/lms.courses.controllers.update_course` |
| `DELETE` | `/api/method/lms.courses.controllers.delete_course` |
| `GET` | `/api/method/lms.courses.controllers.get_chapters` |
| `GET` | `/api/method/lms.courses.controllers.get_chapter` |
| `POST` | `/api/method/lms.courses.controllers.create_chapter` |
| `PUT` | `/api/method/lms.courses.controllers.update_chapter` |
| `DELETE` | `/api/method/lms.courses.controllers.delete_chapter` |
| `GET` | `/api/method/lms.courses.controllers.get_lessons` |
| `GET` | `/api/method/lms.courses.controllers.get_lesson` |
| `POST` | `/api/method/lms.courses.controllers.create_lesson` |
| `PUT` | `/api/method/lms.courses.controllers.update_lesson` |
| `DELETE` | `/api/method/lms.courses.controllers.delete_lesson` |
| `POST` | `/api/method/upload_file` |
| `GET` | `/api/method/lms.lms.doctype.course_lesson.course_lesson.serve_resource` |
| `GET` | `/api/method/lms.courses.controllers.my_courses` |
| `GET` | `/api/method/lms.courses.controllers.shared_courses` |
| `POST` | `/api/method/lms.courses.controllers.enroll` |
| `DELETE` | `/api/method/lms.courses.controllers.unenroll` |
| `POST` | `/api/method/lms.courses.controllers.add_student` |
| `DELETE` | `/api/method/lms.courses.controllers.remove_student` |
| `GET` | `/api/method/lms.courses.controllers.get_students` |
| `POST` | `/api/method/lms.courses.controllers.add_instructor` |
| `DELETE` | `/api/method/lms.courses.controllers.remove_instructor` |
| `GET` | `/api/method/lms.courses.controllers.get_instructors` |

---

# 11. Courses API

## 11.1 List Courses

```http
GET /api/method/lms.courses.controllers.list_courses
```

### Optional Query Parameters

| Parameter | Type | Default | Description |
|---|---|---:|---|
| `filters` | JSON string | None | Frappe-style filters |
| `start` | Integer | `0` | Pagination offset |
| `page_size` | Integer | `30` | Number of results; maximum `100` |

Example:

```http
GET /api/method/lms.courses.controllers.list_courses
    ?filters={"published":1}
    &start=0
    &page_size=30
```

### Response

```json
{
  "state": "success",
  "message": "Courses listed",
  "data": {
    "items": [],
    "total": 0,
    "start": 0,
    "page_size": 30,
    "has_next_page": false
  }
}
```

### Teacher Mobile Usage

Use this endpoint when the teacher needs:

```text
Course catalog
Filtered course search
Published course list
Paginated course browsing
```

---

## 11.2 Get Course

```http
GET /api/method/lms.courses.controllers.get_course
    ?course=<course_name>
```

Example:

```http
GET /api/method/lms.courses.controllers.get_course
    ?course=python-basics
```

Returns complete course details including:

```text
name
title
description
short introduction
publication information
instructors
enrollment information
rating count
other backend course fields
```

### Error

```http
404
```

```json
{
  "state": "error",
  "message": "Course not found"
}
```

### Teacher Mobile Usage

Use as the main source for the Course Details screen.

---

## 11.3 Create Course

```http
POST /api/method/lms.courses.controllers.create_course
```

### Minimum Request

```json
{
  "title": "Python Basics",
  "description": "<p>A comprehensive introduction to Python programming.</p>",
  "short_introduction": "Learn Python from scratch"
}
```

### Request With Optional Fields

```json
{
  "title": "Advanced JavaScript",
  "description": "<p>Deep dive into modern JavaScript.</p>",
  "short_introduction": "Master JavaScript ES6+ features",
  "tags": "javascript,web,frontend",
  "published": true,
  "video_link": "https://www.youtube.com/watch?v=example",
  "enable_certification": true
}
```

### Required Fields

```text
title
description
short_introduction
```

### Backend Behavior

```text
Course name is generated automatically as a slug.
The authenticated creator is added as an instructor.
published_on is generated when the course is published.
Course status is set to Approved when published.
YouTube links may be parsed automatically.
```

### Validation Error

```http
417
```

Example invalid request:

```json
{
  "title": "Missing Fields Course",
  "description": "",
  "short_introduction": ""
}
```

### Teacher Mobile Form

Required fields:

```text
Course title
Description
Short introduction
```

Optional fields:

```text
Tags
Published
Course video URL
Certification enabled
```

On successful creation:

```text
Read the generated course name from response
Reload My Courses
Navigate to Course Details
```

---

## 11.4 Update Course

```http
PUT /api/method/lms.courses.controllers.update_course
```

Send only fields that should change.

```json
{
  "course": "python-basics",
  "title": "Updated Python Course",
  "tags": "python,programming,beginner"
}
```

### Important Rule

The request must include at least one supported mutable field.

Invalid example:

```json
{
  "course": "python-basics",
  "invalid_field": "test"
}
```

Expected result:

```http
417
```

```json
{
  "state": "error",
  "message": "No valid fields"
}
```

### Teacher Mobile Behavior

```text
Keep the original server model.
Create a normalized update payload.
Send only changed fields.
Disable Save when nothing changed.
Preserve form values after failure.
```

---

## 11.5 Delete Course

```http
DELETE /api/method/lms.courses.controllers.delete_course
```

```json
{
  "course": "python-basics"
}
```

### Warning

Deleting a course may remove:

```text
Chapters
Lessons
Lesson references
Enrollments
Progress records
Certificates
Reviews
Discussions
Other related LMS data
```

The operation is permanent.

### Teacher Mobile Confirmation

Example:

```text
Delete “Python Basics”?

This permanently deletes the course, chapters, lessons,
enrollments, progress, and related course information.

This action cannot be undone.
```

Only remove the course from local state after backend success.

---

# 12. Chapters API

## 12.1 List Chapters

```http
GET /api/method/lms.courses.controllers.get_chapters
    ?course=<course_name>
```

Example:

```http
GET /api/method/lms.courses.controllers.get_chapters
    ?course=python-basics
```

Use this endpoint for the Curriculum tab.

Recommended chapter card fields:

```text
Chapter name
Chapter title
Index/order
SCORM indicator
Lesson count when available
Expand/collapse state
```

---

## 12.2 Get Chapter

```http
GET /api/method/lms.courses.controllers.get_chapter
    ?chapter=<chapter_name>
```

Returns the chapter and its lesson information.

### Errors

No token:

```http
401
```

Chapter not found:

```http
404
```

---

## 12.3 Create Chapter

```http
POST /api/method/lms.courses.controllers.create_chapter
```

```json
{
  "title": "Getting Started",
  "course": "python-basics",
  "is_scorm_package": false
}
```

### Required Fields

```text
title
course
```

### SCORM Chapter Example

When supported by the backend configuration:

```json
{
  "title": "SCORM Module",
  "course": "python-basics",
  "is_scorm_package": true,
  "scorm_package": {
    "name": "scorm-file-document-name"
  }
}
```

### Backend Behavior

```text
Creates the chapter.
Creates the course chapter reference.
Adds the chapter at the end of the course outline.
```

### Validation Errors

Missing title:

```json
{
  "title": "",
  "course": "python-basics",
  "is_scorm_package": false
}
```

Invalid course:

```json
{
  "title": "Test Chapter",
  "course": "nonexistent-course",
  "is_scorm_package": false
}
```

Expected status:

```http
417
```

---

## 12.4 Update Chapter

```http
PUT /api/method/lms.courses.controllers.update_chapter
```

```json
{
  "chapter": "getting-started",
  "title": "Updated Chapter Title"
}
```

Send only changed supported fields.

Invalid request:

```json
{
  "chapter": "getting-started",
  "invalid_field": "test"
}
```

Expected:

```http
417
```

---

## 12.5 Delete Chapter

```http
DELETE /api/method/lms.courses.controllers.delete_chapter
```

```json
{
  "chapter": "getting-started"
}
```

### Backend Behavior

Deleting a chapter may delete:

```text
The chapter
Chapter references
Lessons inside the chapter
Lesson references
Related progress records
```

Remaining chapter indexes may be recalculated.

The mobile application must reload the curriculum after success.

---

# 13. Lessons API

## 13.1 List Lessons

```http
GET /api/method/lms.courses.controllers.get_lessons
    ?chapter=<chapter_name>
    &start=0
    &page_size=30
```

### Query Parameters

| Parameter | Required | Default |
|---|---:|---:|
| `chapter` | Yes | — |
| `start` | No | `0` |
| `page_size` | No | `30` |

Maximum page size:

```text
100
```

### Response

```json
{
  "state": "success",
  "message": "Lessons listed",
  "data": {
    "items": [
      {
        "idx": 1,
        "name": "introduction",
        "title": "Introduction",
        "include_in_preview": true,
        "body": null,
        "content": null,
        "instructor_content": null,
        "instructor_notes": null,
        "icon": "icon-list"
      }
    ],
    "total": 1,
    "start": 0,
    "page_size": 30,
    "has_next_page": false
  }
}
```

Possible icon values include:

```text
icon-list
icon-youtube
icon-quiz
icon-assignment
icon-code
```

---

## 13.2 Get Lesson

```http
GET /api/method/lms.courses.controllers.get_lesson
    ?lesson=<lesson_name>
```

Returns:

```text
Lesson title
Body
Dynamic content
Instructor content
Instructor notes
YouTube information
Quiz information
Question information
File type
Preview status
Icon
Chapter index
```

Teacher mode may receive:

```text
instructor_content
instructor_notes
```

Student preview must never render those fields.

---

## 13.3 Create Basic Lesson

```http
POST /api/method/lms.courses.controllers.create_lesson
```

```json
{
  "title": "Introduction to the Course",
  "chapter": "getting-started",
  "include_in_preview": true
}
```

### Required Fields

```text
title
chapter
```

### Optional Fields

```text
body
content
instructor_content
instructor_notes
youtube
quiz_id
question
file_type
include_in_preview
```

### Backend Behavior

```text
Creates the lesson.
Creates a lesson reference inside the chapter.
Appends the lesson to the end of the chapter.
```

---

## 13.4 Create Lesson With YouTube Embed

```http
POST /api/method/lms.courses.controllers.create_lesson
```

```json
{
  "title": "Lesson with YouTube Video",
  "chapter": "getting-started",
  "content": {
    "time": 1782045031503,
    "blocks": [
      {
        "type": "embed",
        "data": {
          "service": "youtube",
          "source": "https://www.youtube.com/watch?v=QhA4h6qD4wY",
          "embed": "QhA4h6qD4wY",
          "caption": ""
        }
      }
    ],
    "version": "2.29.0"
  }
}
```

Supported embed services:

```text
youtube
vimeo
cloudflareStream
bunnyStream
codepen
aparat
github
slides
drive
docsPublic
sheetsPublic
slidesPublic
codesandbox
```

The `content` value may be:

```text
A JSON object — recommended
A string containing serialized JSON
```

The Flutter parser must support both.

---

## 13.5 Create Lesson With Uploaded Video

```json
{
  "title": "Video Lesson",
  "chapter": "getting-started",
  "content": {
    "time": 1782045031503,
    "blocks": [
      {
        "type": "paragraph",
        "data": {
          "text": "Watch the video below:"
        }
      },
      {
        "type": "upload",
        "data": {
          "file_url": "/private/files/lesson-video.mp4",
          "file_type": "mp4",
          "quizzes": []
        }
      }
    ],
    "version": "2.29.0"
  }
}
```

The `file_url` must come from the file-upload response.

---

## 13.6 Create Lesson With PDF

```json
{
  "title": "Reading Material",
  "chapter": "getting-started",
  "content": {
    "time": 1782045031503,
    "blocks": [
      {
        "type": "header",
        "data": {
          "text": "Course Slides",
          "level": 2
        }
      },
      {
        "type": "upload",
        "data": {
          "file_url": "/private/files/slides.pdf",
          "file_type": "pdf",
          "quizzes": []
        }
      }
    ],
    "version": "2.29.0"
  }
}
```

---

## 13.7 Create Lesson With Quiz

```json
{
  "title": "Quiz Lesson",
  "chapter": "getting-started",
  "content": {
    "time": 1782045031503,
    "blocks": [
      {
        "type": "paragraph",
        "data": {
          "text": "Test your knowledge:"
        }
      },
      {
        "type": "quiz",
        "data": {
          "quiz": "quiz-name"
        }
      }
    ],
    "version": "2.29.0"
  }
}
```

Related block formats:

Assignment:

```json
{
  "type": "assignment",
  "data": {
    "assignment": "assignment-name"
  }
}
```

Program/exercise:

```json
{
  "type": "program",
  "data": {
    "exercise": "exercise-name"
  }
}
```

---

## 13.8 Complete Mixed Lesson Example

```json
{
  "title": "Complete Python Lesson",
  "chapter": "getting-started",
  "content": {
    "time": 1782045031503,
    "blocks": [
      {
        "type": "header",
        "data": {
          "text": "Welcome to Python",
          "level": 2
        }
      },
      {
        "type": "paragraph",
        "data": {
          "text": "In this lesson you will learn the basics."
        }
      },
      {
        "type": "embed",
        "data": {
          "service": "youtube",
          "source": "https://www.youtube.com/watch?v=QhA4h6qD4wY",
          "embed": "QhA4h6qD4wY",
          "caption": ""
        }
      },
      {
        "type": "codeBox",
        "data": {
          "code": "print('Hello, World!')",
          "language": "python",
          "theme": ""
        }
      },
      {
        "type": "paragraph",
        "data": {
          "text": "Now test your knowledge:"
        }
      },
      {
        "type": "quiz",
        "data": {
          "quiz": "python-basics-quiz"
        }
      }
    ],
    "version": "2.29.0"
  }
}
```

---

## 13.9 Update Lesson

```http
PUT /api/method/lms.courses.controllers.update_lesson
```

```json
{
  "lesson": "introduction",
  "title": "Updated Lesson Title",
  "include_in_preview": true
}
```

Mutable fields:

```text
title
body
content
instructor_content
instructor_notes
youtube
quiz_id
question
file_type
include_in_preview
```

Invalid request:

```json
{
  "lesson": "introduction",
  "invalid_field": "test"
}
```

Expected:

```http
417
```

---

## 13.10 Delete Lesson

```http
DELETE /api/method/lms.courses.controllers.delete_lesson
```

```json
{
  "lesson": "introduction",
  "chapter": "getting-started"
}
```

Deleting a lesson removes:

```text
Lesson document
Chapter lesson reference
Related progress records
```

Remaining lessons may be reindexed.

The curriculum must be refreshed after success.

---

# 14. Dynamic Lesson Content

## 14.1 EditorJS Structure

```json
{
  "time": 1782045031503,
  "blocks": [],
  "version": "2.29.0"
}
```

---

## 14.2 Supported Blocks

| Type | Mobile renderer | Teacher editor |
|---|---|---|
| `header` | Heading widget | Text and level editor |
| `paragraph` | Rich text widget | Paragraph editor |
| `embed` | Video/web embed | Service and URL editor |
| `upload` | Video, PDF, image, or audio | File picker and upload |
| `codeBox` | Code viewer | Code and language editor |
| `quiz` | Quiz card | Quiz selector |
| `assignment` | Assignment card | Assignment selector |
| `program` | Exercise card | Exercise selector |

---

## 14.3 Unknown Blocks

Unknown blocks must not crash the application.

Render:

```text
Unsupported content block
Type: <block_type>
Update the application to view or edit this block.
```

Preserve the original JSON data when the lesson is edited and saved.

Do not silently remove unsupported blocks.

---

## 14.4 Recommended Dart Models

```dart
class LessonContent {
  const LessonContent({
    this.time,
    required this.blocks,
    this.version,
  });

  final int? time;
  final List<LessonBlock> blocks;
  final String? version;

  factory LessonContent.fromJson(Map<String, dynamic> json) {
    final rawBlocks = json['blocks'];

    return LessonContent(
      time: json['time'] as int?,
      version: json['version'] as String?,
      blocks: rawBlocks is List
          ? rawBlocks
              .whereType<Map<String, dynamic>>()
              .map(LessonBlockFactory.fromJson)
              .toList()
          : const [],
    );
  }
}
```

```dart
sealed class LessonBlock {
  const LessonBlock({
    required this.type,
    required this.rawData,
  });

  final String type;
  final Map<String, dynamic> rawData;
}
```

```dart
final class HeaderLessonBlock extends LessonBlock {
  const HeaderLessonBlock({
    required this.text,
    required this.level,
    required super.rawData,
  }) : super(type: 'header');

  final String text;
  final int level;
}
```

```dart
final class UnknownLessonBlock extends LessonBlock {
  const UnknownLessonBlock({
    required super.type,
    required super.rawData,
  });
}
```

---

## 14.5 Object-or-String Parser

```dart
LessonContent? parseLessonContent(Object? value) {
  if (value == null) {
    return null;
  }

  final Object decodedValue;

  if (value is String) {
    final normalized = value.trim();

    if (normalized.isEmpty) {
      return null;
    }

    decodedValue = jsonDecode(normalized);
  } else {
    decodedValue = value;
  }

  if (decodedValue is! Map<String, dynamic>) {
    throw const FormatException(
      'Lesson content must be a JSON object.',
    );
  }

  return LessonContent.fromJson(decodedValue);
}
```

The parser must catch malformed JSON and return a typed parsing failure.

---

# 15. Lesson Editor Implementation Options

## Option A — Fully Native Flutter Block Editor

### Advantages

```text
Best mobile experience
Strong typing
Native keyboard behavior
Better accessibility
Better automated testing
Offline draft support
```

### Disadvantages

```text
Largest development cost
Every block requires edit and reorder support
More implementation time
```

---

## Option B — EditorJS in WebView

### Advantages

```text
Fast parity with the Frappe web editor
Can reuse existing EditorJS plugins
Less initial editor development
```

### Disadvantages

```text
JavaScript bridge complexity
Keyboard and focus problems
Harder accessibility
Harder file upload integration
Harder testing
More fragile mobile behavior
```

---

## Option C — Simplified Native Flutter Block Editor

Initial supported blocks:

```text
header
paragraph
embed
upload
codeBox
quiz
assignment
program
```

### Advantages

```text
Good mobile UX
Lower risk than a full editor
Supports the documented API
Can be expanded incrementally
```

### Recommended Decision

Use **Option C** for the first teacher-mobile release.

Requirements:

```text
Preserve unsupported block JSON
Allow adding supported blocks
Allow editing supported blocks
Allow deleting supported blocks
Allow reordering blocks locally
Serialize back to EditorJS format
```

Do not implement chapter or lesson drag-and-drop persistence unless the backend provides a reorder endpoint.

---

# 16. File Upload API

## 16.1 Upload Lesson File

The lesson must exist before uploading a file.

```http
POST /api/method/upload_file
```

Use multipart form data.

| Field | Value |
|---|---|
| `file` | Selected file |
| `is_private` | `1` |
| `doctype` | `Course Lesson` |
| `docname` | Lesson document name |
| `fieldname` | `content` |

Example:

```text
file: selected_file.mp4
is_private: 1
doctype: Course Lesson
docname: introduction
fieldname: content
```

### Critical Rule

```text
fieldname must be content
```

Do not use:

```text
instructor_content
instructor_notes
```

unless the file is intentionally restricted to instructors.

A missing or incorrect `fieldname` can cause enrolled students to receive `403` when viewing the file.

---

## 16.2 Supported File Types

Video:

```text
mp4
mov
avi
mkv
webm
```

Audio:

```text
mp3
wav
ogg
```

Documents:

```text
pdf
```

Images:

```text
jpg
jpeg
png
```

---

## 16.3 Upload Response

The response should provide a private file URL.

Example:

```json
{
  "message": {
    "name": "file-document-name",
    "file_name": "lesson-video.mp4",
    "file_url": "/private/files/lesson-video.mp4",
    "is_private": 1
  }
}
```

Store the returned `file_url` inside the lesson `upload` block.

---

# 17. Private Media Streaming

## 17.1 Stream Endpoint

```http
GET /api/method/lms.lms.doctype.course_lesson.course_lesson.serve_resource
    ?file_url=<encoded_file_url>
```

Example source file:

```text
/private/files/lesson video.mp4
```

Correct encoded request:

```text
/api/method/lms.lms.doctype.course_lesson.course_lesson.serve_resource
?file_url=%2Fprivate%2Ffiles%2Flesson%20video.mp4
```

Include:

```http
Authorization: Bearer <access_token>
```

The response is raw binary data, not the normal JSON envelope.

---

## 17.2 Access Rules

The file is available when the caller is:

```text
Course instructor
Course author
Moderator
Enrolled course member
Batch member
Guest/user with valid preview access when the lesson and course permit it
```

---

## 17.3 Common `403` Causes

```text
File uploaded without fieldname=content
File attached to instructor-only content
file_url was never inserted into the lesson content
file_url was not URL-encoded
User is not enrolled
Course is not accessible
Preview rules are not satisfied
```

---

## 17.4 Flutter URL Builder

```dart
Uri buildLessonResourceUri({
  required String baseUrl,
  required String fileUrl,
}) {
  return Uri.parse(
    '$baseUrl/api/method/'
    'lms.lms.doctype.course_lesson.course_lesson.serve_resource',
  ).replace(
    queryParameters: {
      'file_url': fileUrl,
    },
  );
}
```

Always use `Uri.queryParameters` instead of manually concatenating the URL.

---

# 18. Correct Media Creation Flow

```text
Teacher enters lesson title
        ↓
Create basic lesson
        ↓
Receive lesson name
        ↓
Upload selected file using docname=lesson name
        ↓
Receive private file_url
        ↓
Insert file_url into upload block
        ↓
Update lesson content
        ↓
Reload lesson
        ↓
Render through serve_resource
```

The Cubit or use case must orchestrate this flow.

---

# 19. My Courses API

## 19.1 My Courses

```http
GET /api/method/lms.courses.controllers.my_courses
```

Teacher result:

```text
Courses owned or instructed by the authenticated teacher
```

Student result:

```text
Enrolled courses
Progress
Current lesson
```

The teacher application must map the teacher response safely and ignore unsupported student-only fields.

---

## 19.2 Shared Courses

```http
GET /api/method/lms.courses.controllers.shared_courses
```

Returns courses where the current teacher was added as an instructor by another teacher or course owner.

---

# 20. Enrollment API

Self-enrollment endpoints are documented for completeness, but they are not primary teacher-screen actions.

---

## 20.1 Self-Enroll

```http
POST /api/method/lms.courses.controllers.enroll
```

```json
{
  "course": "python-basics"
}
```

Self-enrollment may require:

```text
Published course
Self-learning enabled
Free course or completed payment
Valid authenticated student
```

Already-enrolled requests may return a validation error.

---

## 20.2 Self-Unenroll

```http
DELETE /api/method/lms.courses.controllers.unenroll
```

```json
{
  "course": "python-basics"
}
```

Unenrollment may remove related progress records.

---

## 20.3 Add Student

```http
POST /api/method/lms.courses.controllers.add_student
```

```json
{
  "course": "python-basics",
  "student": "student@example.com"
}
```

### Teacher UI

Use an add-student dialog:

```text
Student email
Cancel
Add student
```

Validate:

```text
Non-empty
Trimmed
Valid email syntax
```

The backend must validate that the user exists and is eligible.

---

## 20.4 Remove Student

```http
DELETE /api/method/lms.courses.controllers.remove_student
```

```json
{
  "course": "python-basics",
  "student": "student@example.com"
}
```

### Warning

Removing a student may delete:

```text
Enrollment
Course progress
Lesson progress
Related access
```

Show a confirmation dialog.

---

## 20.5 List Students

```http
GET /api/method/lms.courses.controllers.get_students
    ?course=<course_name>
```

Recommended mobile list item:

```text
Avatar
Student name
Student email
Progress when available
Enrollment date when available
Remove action
```

Use pagination if the backend response includes pagination data.

---

# 21. Instructors API

## 21.1 Add Instructor

```http
POST /api/method/lms.courses.controllers.add_instructor
```

```json
{
  "course": "python-basics",
  "instructor": "teacher2@example.com"
}
```

The backend must validate:

```text
User exists
User can be an instructor
Current user has permission
Instructor is not already added
```

---

## 21.2 Remove Instructor

```http
DELETE /api/method/lms.courses.controllers.remove_instructor
```

```json
{
  "course": "python-basics",
  "instructor": "teacher2@example.com"
}
```

### Last Instructor Rule

The course must always retain at least one instructor.

Attempting to remove the final instructor should return:

```http
417
```

The UI may disable the action when only one instructor is present, but it must still handle the backend error.

---

## 21.3 List Instructors

```http
GET /api/method/lms.courses.controllers.get_instructors
    ?course=<course_name>
```

Recommended UI fields:

```text
Avatar
Display name
Full name
Email when returned
Course owner badge when available
Remove action
```

When the image is missing:

```text
Use profile initials
Use a deterministic placeholder background
Do not generate a different color on every rebuild
```

---

# 22. Student Preview Rules

The teacher application should provide a student-preview mode.

Student preview may show:

```text
Course title
Course description
Chapter titles
Lesson titles
Lesson body
Lesson content blocks
Student-visible uploaded media
Quiz reference without correct-answer exposure
Assignment reference
Program/exercise reference
```

Student preview must not show:

```text
instructor_content
instructor_notes
Teacher edit buttons
Delete actions
Correct quiz answers
Teacher grading controls
Internal IDs
Instructor-only uploaded files
```

Use a separate preview mapper instead of sending the complete teacher lesson model directly to the preview widgets.

Example:

```dart
class StudentLessonPreview {
  const StudentLessonPreview({
    required this.title,
    required this.body,
    required this.content,
    required this.includeInPreview,
  });

  final String title;
  final String? body;
  final LessonContent? content;
  final bool includeInPreview;
}
```

---

# 23. Recommended Flutter Feature Structure

Adapt this structure to the existing project.

```text
lib/features/courses/
├── data/
│   ├── datasources/
│   │   ├── courses_remote_data_source.dart
│   │   └── lesson_media_remote_data_source.dart
│   ├── dto/
│   │   ├── api_envelope_dto.dart
│   │   ├── course_dto.dart
│   │   ├── chapter_dto.dart
│   │   ├── lesson_dto.dart
│   │   ├── lesson_content_dto.dart
│   │   ├── lesson_block_dto.dart
│   │   ├── course_student_dto.dart
│   │   └── course_instructor_dto.dart
│   └── repositories/
│       └── courses_repository_impl.dart
├── domain/
│   ├── entities/
│   ├── repositories/
│   │   └── courses_repository.dart
│   └── usecases/
└── presentation/
    ├── cubit/
    │   ├── teacher_courses_cubit.dart
    │   ├── course_details_cubit.dart
    │   ├── course_form_cubit.dart
    │   ├── curriculum_builder_cubit.dart
    │   ├── lesson_editor_cubit.dart
    │   ├── course_students_cubit.dart
    │   └── course_instructors_cubit.dart
    ├── screens/
    └── widgets/
```

---

# 24. Repository Contract

```dart
abstract interface class CoursesRepository {
  Future<PageResult<Course>> listCourses({
    Map<String, dynamic>? filters,
    int start = 0,
    int pageSize = 30,
  });

  Future<List<Course>> getMyCourses();

  Future<List<Course>> getSharedCourses();

  Future<Course> getCourse(String courseName);

  Future<Course> createCourse(
    CreateCourseInput input,
  );

  Future<Course> updateCourse(
    UpdateCourseInput input,
  );

  Future<void> deleteCourse(
    String courseName,
  );

  Future<PageResult<Chapter>> getChapters(
    String courseName,
  );

  Future<Chapter> getChapter(
    String chapterName,
  );

  Future<Chapter> createChapter(
    CreateChapterInput input,
  );

  Future<Chapter> updateChapter(
    UpdateChapterInput input,
  );

  Future<void> deleteChapter(
    String chapterName,
  );

  Future<PageResult<Lesson>> getLessons({
    required String chapterName,
    int start = 0,
    int pageSize = 30,
  });

  Future<Lesson> getLesson(
    String lessonName,
  );

  Future<Lesson> createLesson(
    CreateLessonInput input,
  );

  Future<Lesson> updateLesson(
    UpdateLessonInput input,
  );

  Future<void> deleteLesson({
    required String lessonName,
    required String chapterName,
  });

  Future<UploadedFile> uploadLessonFile(
    UploadLessonFileInput input,
  );

  Future<List<CourseStudent>> getStudents(
    String courseName,
  );

  Future<void> addStudent({
    required String courseName,
    required String studentEmail,
  });

  Future<void> removeStudent({
    required String courseName,
    required String studentEmail,
  });

  Future<List<CourseInstructor>> getInstructors(
    String courseName,
  );

  Future<void> addInstructor({
    required String courseName,
    required String instructorEmail,
  });

  Future<void> removeInstructor({
    required String courseName,
    required String instructorEmail,
  });
}
```

---

# 25. Cubit State Design

Do not use one generic `isLoading` value for every operation.

Recommended states:

```text
initial
loading
loaded
empty
refreshing
paginating
submitting
uploading
deleting
success
failure
```

Example state:

```dart
class CourseDetailsState {
  const CourseDetailsState({
    this.course,
    this.status = CourseDetailsStatus.initial,
    this.activeMutation,
    this.errorMessage,
  });

  final Course? course;
  final CourseDetailsStatus status;
  final CourseMutation? activeMutation;
  final String? errorMessage;
}
```

---

# 26. Course Creation Flow

```text
Teacher opens Create Course
→ Enter required information
→ Validate locally
→ Emit submitting state
→ Call create_course
→ Receive generated course name
→ Reload teacher courses
→ Navigate to Course Details
→ Show success message
```

On failure:

```text
Keep form values
Display backend error
Allow retry
```

---

# 27. Lesson With Media Save Flow

```text
Validate lesson draft
→ Check whether lesson exists
→ Create basic lesson when needed
→ Receive lesson name
→ Upload pending files
→ Replace local temporary media references
→ Insert returned private file URLs
→ Serialize EditorJS content
→ Update lesson
→ Reload lesson
→ Emit success
```

Do not place this sequence inside the screen widget.

---

# 28. Pagination

Paginated endpoints use:

```text
start
page_size
```

Recommended page state:

```dart
class PageResult<T> {
  const PageResult({
    required this.items,
    required this.total,
    required this.start,
    required this.pageSize,
    required this.hasNextPage,
  });

  final List<T> items;
  final int total;
  final int start;
  final int pageSize;
  final bool hasNextPage;
}
```

Pagination rules:

```text
Do not load when hasNextPage is false
Prevent duplicate pagination requests
Deduplicate entities using name
Keep existing items after pagination failure
Allow pagination retry
Refresh must replace all items
```

---

# 29. Validation Rules

## Course

```text
title: required and trimmed
description: required and non-empty
short_introduction: required and non-empty
video_link: valid URL when provided
tags: preserve backend comma-separated format
```

## Chapter

```text
title: required and trimmed
course: required
is_scorm_package: boolean
SCORM package required when SCORM mode is enabled
```

## Lesson

```text
title: required and trimmed
chapter: required on create
content: valid object or serialized JSON
upload block: requires file_url and file_type
embed block: requires supported service
header level: valid heading range
quiz: requires quiz document name
assignment: requires assignment document name
program: requires exercise document name
```

## Student and Instructor

```text
Email required
Trim whitespace
Validate basic email syntax
Backend validates existence and role
```

---

# 30. Typed Failure Mapping

```dart
sealed class CoursesFailure implements Exception {
  const CoursesFailure(this.message);

  final String message;
}

final class UnauthorizedFailure extends CoursesFailure {
  const UnauthorizedFailure(super.message);
}

final class ForbiddenFailure extends CoursesFailure {
  const ForbiddenFailure(super.message);
}

final class NotFoundFailure extends CoursesFailure {
  const NotFoundFailure(super.message);
}

final class ValidationFailure extends CoursesFailure {
  const ValidationFailure(super.message);
}

final class NetworkFailure extends CoursesFailure {
  const NetworkFailure(super.message);
}

final class ServerFailure extends CoursesFailure {
  const ServerFailure(super.message);
}

final class ParsingFailure extends CoursesFailure {
  const ParsingFailure(super.message);
}
```

---

# 31. Error UX

| Error | Mobile handling |
|---|---|
| Course not found | Show not-found page and refresh My Courses |
| Chapter not found | Remove stale chapter and reload curriculum |
| Lesson not found | Return to curriculum and reload |
| Missing course fields | Show field validation |
| No valid update fields | Keep Save disabled or show validation |
| Permission denied | Show permission dialog or snackbar |
| Duplicate enrollment | Show informational message |
| Student does not exist | Show backend message in add-student dialog |
| Final instructor removal | Show blocking business-rule message |
| Private media `403` | Explain access/attachment problem and offer retry |
| Upload failure | Preserve local lesson draft |
| Lesson update after upload fails | Preserve uploaded URL and allow retry |
| Server error | Preserve screen state and offer retry |

---

# 32. Draft and Cache Safety

1. Preserve unsaved course forms.
2. Preserve unsaved lesson blocks.
3. Preserve uploaded file URLs until lesson save succeeds.
4. Do not cache bearer tokens inside the feature.
5. Do not permanently cache private files unless security rules allow it.
6. Compare normalized lesson content before updating.
7. Avoid unnecessary update requests.
8. Warn before leaving a dirty form.
9. Do not silently overwrite a newer server lesson.
10. Keep unknown blocks intact.

---

# 33. Accessibility and Localization

The feature must:

```text
Use localized strings
Support English and Arabic
Support RTL layouts
Provide semantic labels for icons
Use minimum touch-target sizes
Use accessible heading hierarchy
Show upload progress as text and progress indicator
Support screen readers
Avoid color-only status indicators
Use the project design system
```

User avatars should use:

```text
Remote image when available
Initials placeholder when unavailable
Deterministic placeholder background
Accessible display name
```

---

# 34. Security Requirements

1. Never log access tokens.
2. Never log private media URLs with authorization information.
3. Never place the token inside URL query parameters.
4. Use HTTPS outside local development.
5. Do not expose instructor notes in student preview.
6. Do not treat UI permission checks as backend security.
7. Sanitize or safely render HTML content.
8. Restrict WebView navigation if WebView content is used.
9. Validate uploaded file types and sizes.
10. Follow backend file-size limits.
11. Do not open arbitrary untrusted URLs without validation.
12. Do not expose correct quiz answers in previews.

---

# 35. Unit Tests

Required unit tests:

```text
API success-envelope parsing
API error-envelope parsing
Course DTO parsing
Chapter DTO parsing
Lesson DTO parsing
Object lesson-content parsing
String lesson-content parsing
Malformed lesson-content handling
Known block parsing
Unknown block fallback
Upload block parsing
Embed block parsing
Quiz block parsing
Assignment block parsing
Program block parsing
serve_resource URL encoding
HTTP error mapping
Pagination merge
Pagination deduplication
Normalized content comparison
Student preview mapping
Instructor-only content exclusion
```

---

# 36. Repository Tests

Mock the API client and verify:

```text
Correct HTTP method
Correct endpoint
Correct query parameters
Authorization interceptor is used
Correct JSON request body
Multipart uses fieldname=content
Multipart contains Course Lesson doctype
Multipart contains lesson docname
Binary media does not use JSON-envelope parser
Backend messages map to typed failures
```

---

# 37. Cubit Tests

Required flows:

```text
Load My Courses
Load Shared Courses
Refresh courses
Load course details
Create course
Update course
Delete course
Load chapters
Create chapter
Update chapter
Delete chapter
Load lessons
Create lesson
Update lesson
Delete lesson
Create lesson then upload then update
Upload failure
Update failure after upload
Load students
Add student
Remove student
Load instructors
Add instructor
Remove instructor
Final instructor removal error
Permission denied
Not found
Unsaved draft
```

---

# 38. Widget Tests

Required UI tests:

```text
Loading state
Empty state
Error state
Retry
Course card
Create-course validation
Edit-course validation
Delete-course confirmation
Curriculum chapter expansion
Lesson block rendering
Unknown lesson block
Student preview
Instructor content hidden in preview
Upload progress
Upload retry
Add-student dialog
Remove-student confirmation
Add-instructor dialog
Remove-instructor confirmation
Final instructor protection
RTL layout
```

---

# 39. Integration Tests

Minimum integration scenarios:

1. Teacher loads My Courses.
2. Teacher opens Shared Courses.
3. Teacher creates a course.
4. Teacher updates the course.
5. Teacher creates a chapter.
6. Teacher creates a basic lesson.
7. Teacher uploads a private video.
8. Teacher saves the upload block.
9. Teacher streams the private video.
10. Teacher creates a PDF lesson.
11. Teacher creates a quiz lesson.
12. Teacher previews the lesson as a student.
13. Instructor-only content remains hidden.
14. Teacher adds a student.
15. Teacher removes a student.
16. Teacher adds another instructor.
17. Teacher removes an instructor.
18. Removing the last instructor fails.
19. Teacher deletes a lesson.
20. Teacher deletes a chapter.
21. Teacher deletes a course.

---

# 40. Documentation Requirements

The coding agent must update:

```text
README.md
docs/features/teacher_courses.md
docs/api/lms_courses_api.md
docs/architecture/lesson_content_blocks.md
docs/architecture/private_lesson_media.md
```

If a required file does not exist, create it.

Documentation must include:

```text
Feature overview
Screen navigation
API routes
Request and response rules
Authentication
Permission model
Dynamic content blocks
Upload workflow
Streaming workflow
Error handling
Known limitations
Testing instructions
```

---

# 41. Spec-Kit Updates

Update the project spec-kit with:

```text
Feature specification
Implementation plan
Task checklist
API contracts
Data model
Screen flows
State-management flow
Acceptance criteria
Known limitations
Testing plan
```

Do not mark the feature complete until the spec-kit matches the final implementation.

---

# 42. Known Limitations

1. The supplied API does not document a chapter-reorder endpoint.
2. The supplied API does not document a lesson-reorder endpoint.
3. Do not persist drag-and-drop ordering until the backend provides an official contract.
4. Unknown EditorJS blocks may be view-only.
5. Some embed services may require WebView or provider-specific handling.
6. Private media seeking depends on backend range-request support.
7. File-size limits must be confirmed from the deployed Frappe configuration.
8. Student progress data may not be available in every teacher endpoint.
9. Course publication rules remain backend-controlled.
10. Advanced SCORM authoring is outside the initial native lesson editor.

---

# 43. Definition of Done

The Teacher Courses feature is complete when:

```text
[ ] My Courses loads successfully.
[ ] Shared Courses loads successfully.
[ ] Teacher can create a course.
[ ] Teacher can update a course.
[ ] Teacher can delete a course safely.
[ ] Teacher can list chapters.
[ ] Teacher can create a chapter.
[ ] Teacher can update a chapter.
[ ] Teacher can delete a chapter safely.
[ ] Teacher can list lessons.
[ ] Teacher can create a lesson.
[ ] Teacher can update a lesson.
[ ] Teacher can delete a lesson safely.
[ ] Dynamic lesson content supports object and string formats.
[ ] Known lesson blocks render correctly.
[ ] Unknown blocks do not crash.
[ ] Unknown blocks are not lost when saving.
[ ] Private files upload using fieldname=content.
[ ] Private media streams through serve_resource.
[ ] file_url is URL-encoded.
[ ] Student preview hides instructor content.
[ ] Teacher can list students.
[ ] Teacher can add a student.
[ ] Teacher can remove a student.
[ ] Teacher can list instructors.
[ ] Teacher can add an instructor.
[ ] Teacher can remove an instructor.
[ ] Final instructor cannot be removed.
[ ] Permission errors are handled.
[ ] Validation errors are handled.
[ ] Pagination works without duplicates.
[ ] Unsaved drafts are protected.
[ ] Unit tests pass.
[ ] Widget tests pass.
[ ] Integration tests pass.
[ ] flutter analyze passes.
[ ] README is updated.
[ ] Feature documentation is updated.
[ ] API documentation is updated.
[ ] Spec-kit is updated.
[ ] No Frappe core code was modified.
```

---

# 44. Final Implementation Decision

```text
Mobile framework:
Flutter

Architecture:
Existing Scolair feature-first architecture

State management:
Existing BLoC/Cubit implementation

Networking:
Existing authenticated Dio/API client

Lesson editor:
Simplified native Flutter block editor

Lesson content:
EditorJS-compatible JSON

Media upload:
Frappe upload_file multipart endpoint

Private media playback:
serve_resource endpoint

Course structure:
Course → Chapter → Lesson

Student access management:
Enrollment endpoints

Teacher collaboration:
Instructor endpoints

Student preview:
Dedicated safe preview mapping

Backend customization:
No Frappe core modification
```
````
