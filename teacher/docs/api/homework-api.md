# Homework API — Homeworks, Questions & Submissions

Mobile CRUD endpoints for managing homeworks, their questions, and student submissions (including auto-grading of objective questions and manual grading by teachers).

All endpoints require a valid OAuth2 access token in the `Authorization: Bearer <token>` header. Obtain tokens via the [Authentication API](./auth-postman-collection.json) login endpoint.

Base path: `{{base_url}}/api/method/lms.homework.controllers.<endpoint>`

## Response Format

All endpoints return a unified envelope:

**Success:**

```json
{
  "state": "success",
  "message": "...",
  "data": { ... }
}
```

**Error:**

```json
{
  "state": "error",
  "message": "..."
}
```

HTTP status codes: 200 (success), 400 (validation), 401 (auth required), 403 (permission), 404 (not found).

Paginated list endpoints wrap results as:

```json
{ "items": [...], "total": N, "start": N, "page_size": N, "has_next_page": true }
```

`page_size` defaults to 30, max 100.

## Permissions

| Operation | Required Role |
| --- | --- |
| Teacher endpoints (list/get/create/update/delete homework, question ops, submissions, grading) | Course Creator, Batch Evaluator, or Moderator |
| Student endpoints (`*_for_student`, `submit_homework`, `get_my_submission`) | Any authenticated user |

On top of the role check, **modify operations** (update, delete, add/remove question, grade) verify per-document permission:

- Moderator — always allowed.
- Homework linked to a **course** — must pass `can_modify_course` (course instructor).
- Homework linked to a **batch only** — must be the homework owner or a batch evaluator.

Students can only see/submit homeworks that are **published** and belong to a course they are enrolled in (`LMS Enrollment`) or a batch they are a member of (`LMS Batch Enrollment`).

## Business Rules

- A homework must be linked to **either a lesson or a batch** (or both). `course` is derived automatically from the lesson.
- After **any submission exists**:
  - `lesson`, `batch` can no longer be changed.
  - Questions cannot be added or removed (and `max_marks` is computed from questions, so it's transitively immutable).
  - The homework cannot be deleted — unpublish it instead.
- After the **due date**: submission is rejected unless `allow_late_submission` is set; late submissions are flagged `is_late`.
- **Resubmission is blocked.** Once a submission exists with status `Submitted` or `Graded`, the student cannot submit again — the attempt is rejected outright (it never silently overwrites the previous submission). A graded submission is final.
- Objective question answers are **auto-scored** on submit (`auto_marks`); manual grading (Open Ended / File Upload questions) is done via `grade_submission` with per-question marks. Final `marks` = `auto_marks + sum(manual marks)`.
- Notifications are sent automatically: to enrolled students when a homework is published, to the teacher (owner + course instructors + batch evaluators) on submission, and to the student on grading.

### Submission status lifecycle

`Submitted` → `Graded` (via grade_submission)

### Student `my_status` values

| Status | Meaning |
| --- | --- |
| `Pending` | No submission yet, due date not passed |
| `Overdue` | No submission, due date passed |
| `Submitted` | Submitted on time |
| `Late` | Submitted after the due date |
| `Graded` | Teacher has graded it (final — cannot be resubmitted) |
| `Redo` | Reserved status, currently unreachable — no endpoint sets it |

---

## Teacher Endpoints

### GET `lms.homework.controllers.list_homeworks`

List homeworks with optional filtering, paginated.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `lesson` | string | No | Filter to a single Course Lesson |
| `course` | string | No | Filter to a single LMS Course |
| `chapter` | string | No | Filter to all lessons under a Course Chapter (resolved internally) |
| `start` | int | No | Pagination offset (default `0`) |
| `page_size` | int | No | Page size (default `30`, max `100`) |

**Response `data`:** paginated list of homeworks:

```json
{
  "items": [
    {
      "name": "hw-0001",
      "title": "Week 1 Homework",
      "instructions": "<p>Solve all questions</p>",
      "attachment": "/files/worksheet.pdf",
      "course": "python-basics",
      "lesson": null,
      "batch": null,
      "due_date": "2026-07-15 23:59:59",
      "max_marks": 100,
      "allow_late_submission": 0,
      "published": 1,
      "owner": "teacher@example.com",
      "creation": "...",
      "modified": "..."
    }
  ],
  "total": 5, "start": 0, "page_size": 30, "has_next_page": false
}
```

---

### GET `lms.homework.controllers.get_homework`

Get a single homework with its full question list (teacher view — includes correct answers and possibilities).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `homework` | string | Yes | LMS Homework name |

**Response `data`:** homework doc plus:

```json
{
  "name": "hw-0001",
  "title": "Week 1 Homework",
  "...": "...",
  "questions": [
    {
      "name": "q-0001",
      "question": "What is 2 + 2?",
      "type": "Choices",
      "multiple": 0,
      "option_1": "3", "option_2": "4", "option_3": "5", "option_4": null,
      "is_correct_1": 0, "is_correct_2": 1, "is_correct_3": 0, "is_correct_4": 0,
      "explanation_1": null, "explanation_2": "...",
      "possibility_1": null,
      "marks": 5
    }
  ]
}
```

---

### POST `lms.homework.controllers.create_homework`

Create a homework, optionally with questions (existing or inline-created).

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `title` | string | Yes | Homework title |
| `due_date` | datetime | Yes | Due date (`YYYY-MM-DD HH:MM:SS`) |
| `lesson` | string | Conditional | Course Lesson name — either `lesson` or `batch` is required |
| `batch` | string | Conditional | LMS Batch name — either `lesson` or `batch` is required |
| `instructions` | string | No | HTML instructions |
| `attachment` | string | No | File URL |
| `allow_late_submission` | bool | No | Accept submissions after the due date (flagged `is_late`) |
| `published` | bool | No | Publish immediately (notifies enrolled students) |
| `questions` | array/JSON string | No | Question list, see below |

`course` and `max_marks` are derived automatically (`course` from the lesson, `max_marks` as the sum of question marks) and cannot be set directly.

**`questions` format** — each item is either a reference to an existing `LMS Question` or an inline definition that creates a new question:

```json
[
  {"question": "existing-question-name", "marks": 5},
  {
    "inline": {
      "question": "What is 2 + 2?",
      "type": "Choices",
      "option_1": "3", "option_2": "4",
      "is_correct_1": 0, "is_correct_2": 1
    },
    "marks": 5
  }
]
```

**Response `data`:** the created homework doc.

---

### PUT `lms.homework.controllers.update_homework`

Update mutable homework fields. Publishing (`published: 1` for the first time) notifies all enrolled students.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `homework` | string | Yes | LMS Homework name |
| any of: `title`, `instructions`, `attachment`, `lesson`, `batch`, `due_date`, `allow_late_submission`, `published` | — | At least one | Fields to update. `course` and `max_marks` are derived automatically and cannot be set directly. |

**Restrictions once submissions exist:** `lesson` / `batch` are locked, and questions (hence `max_marks`) can no longer be added or removed.

**Response `data`:** the updated homework doc.

---

### DELETE `lms.homework.controllers.delete_homework`

Delete a homework. Fails with 400 if any submission exists (unpublish instead).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `homework` | string | Yes | LMS Homework name |

---

### POST `lms.homework.controllers.add_question`

Attach an existing `LMS Question` to a homework. Blocked once submissions exist.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `homework` | string | Yes | LMS Homework name |
| `question` | string | Yes | LMS Question name |
| `marks` | int | No | Positive integer (default `1`) |

**Response `data`:** the updated homework doc.

---

### DELETE `lms.homework.controllers.remove_question`

Remove a question from a homework. Blocked once submissions exist.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `homework` | string | Yes | LMS Homework name |
| `question` | string | Yes | LMS Question name (must belong to this homework) |

**Response `data`:** the updated homework doc.

---

### GET `lms.homework.controllers.get_submissions`

List all submissions for a homework, paginated.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `homework` | string | Yes | LMS Homework name |
| `start` | int | No | Pagination offset |
| `page_size` | int | No | Page size (default `30`, max `100`) |

**Response `data`:**

```json
{
  "items": [
    {
      "name": "hws-0001",
      "member": "student@example.com",
      "member_name": "Student Name",
      "status": "Submitted",
      "is_late": 0,
      "auto_marks": 10,
      "marks": null,
      "feedback": null,
      "submitted_on": "2026-07-10 14:30:00"
    }
  ],
  "total": 1, "start": 0, "page_size": 30, "has_next_page": false
}
```

---

### GET `lms.homework.controllers.get_submission`

Get full submission detail for a teacher. Returns the submission doc enriched with a `questions` array containing each question's answer, grading status, and notes.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `submission` | string | Yes | LMS Homework Submission name |

**Response `data`:** submission doc plus:

```json
{
  "name": "hws-0001",
  "homework": "hw-0001",
  "member": "student@example.com",
  "status": "Submitted",
  "auto_marks": 10,
  "marks": null,
  "questions": [
    {
      "question": "q-0001",
      "question_text": "What is 2 + 2?",
      "type": "Choices",
      "max_marks": 5,
      "answer": "4",
      "is_correct": true,
      "marks_awarded": 5,
      "note": null
    },
    {
      "question": "q-0002",
      "question_text": "Explain your reasoning",
      "type": "Open Ended",
      "max_marks": 10,
      "answer": "Because 2+2=4...",
      "is_correct": null,
      "marks_awarded": null,
      "note": null
    }
  ]
}
```

---

### GET `lms.homework.controllers.download_answer_file`

Stream the raw bytes of a File Upload question's answer (e.g. a PDF a student uploaded via
`lms.question.controllers.upload_answer_file`). Returns the file itself, not a JSON envelope — do not expect
a `state`/`message`/`data` wrapper, and errors come back as Frappe's standard error page rather than
`{"state": "error", ...}`.

There was previously no way to retrieve these bytes at all: the core `/private/files/` route and the
lesson-specific `serve_resource` endpoint both reject files that aren't attached to a Course Lesson, and
answer files are intentionally never attached to anything (see the File Upload PermissionError note above).
This endpoint exists specifically to close that gap.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `submission` | string | Yes | LMS Homework Submission name |
| `question` | string | Yes | The File Upload question within that submission |

**Access:** the submission's own author (the student who submitted it), or anyone who can modify the
homework (course instructor / batch evaluator / owner / Moderator) — same rule as `grade_submission`.

**Errors:** 404 if the submission/question has no file answer, 400 if the named question's answer isn't a
file, 403 if the caller is neither the submission's author nor able to modify the homework.

---

### POST `lms.homework.controllers.grade_submission`

Grade a submission by providing per-question marks for all manually-graded questions (Open Ended / File Upload only). Choices/User Input questions are auto-graded at submit time and must not be included. Sets status to `Graded` and notifies the student.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `submission` | string | Yes | LMS Homework Submission name |
| `question_marks` | object/JSON string | Yes | Per-question marks: `{"question-name": {"marks": N, "note": "optional string"}, ...}`. Must cover exactly the homework's manually-graded (Open Ended / File Upload) questions. Each `marks` value must be between 0 and that question's max marks. |
| `feedback` | string | No | Overall feedback text for the student |

**Validation rules:**

- `question_marks` must be a non-empty object.
- Must include all Open Ended / File Upload questions of this homework.
- Must not include any Choices / User Input questions.
- Each entry must have a `marks` field (number, 0 to question's max marks) and an optional `note` field (string).

**Response `data`:** the graded submission doc. `marks` = `auto_marks + sum(manual marks)`.

---

## Student Endpoints

### GET `lms.homework.controllers.list_homeworks_for_student`

List published homeworks from the student's enrolled courses and batches, paginated. Each item includes `my_status` (see [status table](#student-my_status-values)) and `submission_name` (or `null`).

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `course` | string | No | Narrow to one enrolled course |
| `lesson` | string | No | Narrow to one lesson |
| `chapter` | string | No | Narrow to all lessons under a chapter |
| `start` | int | No | Pagination offset |
| `page_size` | int | No | Page size (default `30`, max `100`) |

---

### GET `lms.homework.controllers.get_homework_for_student`

Get a homework with its questions in **student view** — correct answers (`is_correct_*`) and open-ended answer possibilities (`possibility_*`) are stripped. Requires the homework to be published and the student to be enrolled; otherwise 404/403.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `homework` | string | Yes | LMS Homework name |

---

### POST `lms.homework.controllers.submit_homework`

Submit (or resubmit) homework. At least one of `answer_text`, `attachment`, or `answers` is required. Objective answers are auto-scored into `auto_marks`. If the homework has one or more questions, **every** question must be present in `answers` — partial submissions are rejected. Resubmission is blocked once a submission exists with status `Submitted` or `Graded`. The teacher is notified.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `homework` | string | Yes | LMS Homework name |
| `answer_text` | string | No | Free-text answer |
| `attachment` | string | No | Uploaded file URL |
| `answers` | object/JSON string | No | Per-question answers: `{"question-name": "answer", ...}`. Every key must be a question of this homework. |

**Errors:** 400 `Deadline has passed` (unless `allow_late_submission`), 400 `You have already submitted this homework.` / `Your submission has already been graded and cannot be resubmitted.` (resubmission never overwrites), 400 `Please answer all questions before submitting. Missing answer(s) for: ...` (if the homework has questions and one is missing from `answers`).

**Response `data`:** the submission doc, e.g.:

```json
{
  "name": "hws-0001",
  "homework": "hw-0001",
  "member": "student@example.com",
  "answer_text": "My essay...",
  "attachment": null,
  "question_answers": [{"question": "q-0001", "answer": "4", "is_correct": true, "marks": 5}],
  "auto_marks": 5,
  "is_late": 0,
  "status": "Submitted",
  "submitted_on": "2026-07-10 14:30:00"
}
```

---

### GET `lms.homework.controllers.get_my_submission`

Get the current user's submission for a homework, or `null` data if not submitted yet.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `homework` | string | Yes | LMS Homework name |

**Response `data`:**

```json
{
  "name": "hws-0001",
  "answer_text": "...",
  "attachment": null,
  "question_answers": [...],
  "status": "Graded",
  "is_late": 0,
  "auto_marks": 5,
  "marks": 85,
  "feedback": "Good work",
  "graded_by": "teacher@example.com",
  "graded_on": "2026-07-12 09:00:00",
  "submitted_on": "2026-07-10 14:30:00"
}
```
