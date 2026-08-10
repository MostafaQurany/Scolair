# Quiz API — Quizzes, Timed Attempts, Grading & Submissions

Mobile CRUD endpoints for managing quizzes and student attempts, including server-side duration enforcement, a hard quiz-closing date, auto-grading of objective questions, and manual grading of Open Ended / File Upload questions.

All endpoints require a valid OAuth2 access token in the `Authorization: Bearer <token>` header. Obtain tokens via the [Authentication API](./auth-postman-collection.json) login endpoint.

Question-bank CRUD (creating/editing `LMS Question` records) lives in the separate [Question Module API](./question-postman-collection.json) (`lms.question.controllers.*`).

Base path: `{{base_url}}/api/method/lms.quiz.controllers.<endpoint>`

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
| Teacher endpoints (list/get/create/update/delete quiz, question ops, `grade_submission`, `get_student_submissions`) | Course Creator, Batch Evaluator, or Moderator |
| Student endpoints (`*_for_student`, `start_quiz`, `submit_quiz`) | Any authenticated user |
| `get_submissions` | Any authenticated user — scope depends on caller (see endpoint below) |

On top of the role check, **modify operations** (update, delete, add/remove question, grade) verify per-document permission via `validate_modify_quiz_permission`:

- Moderator — always allowed.
- Quiz linked to a **course** — must pass `can_modify_course` (course instructor).
- Quiz **not** linked to a course — must be the quiz owner.

Students can only see/attempt quizzes they're **enrolled** in the course for (`LMS Enrollment`) — quizzes with no course are open to any authenticated student.

## Business Rules

### Duration (timed attempts) — server-enforced, two-call flow

`duration` (minutes) is **not** just a client-side countdown — it's enforced on the server:

1. Call `start_quiz` when the student begins a timed quiz. This records `started_on` server-side (`LMS Quiz Attempt`). **Idempotent** — calling it again for the same quiz/user just returns the original `started_on`, it does not reset the clock (safe to call on every page load/resume).
2. Call `submit_quiz` with the answers. The server computes elapsed time since `started_on` and rejects with `"Time is up for this quiz"` once `duration * 60 + 5` seconds (a 5s grace buffer) have passed.

Quizzes with `duration` unset or `0` are **untimed** — `start_quiz` is not required and no time check happens.

Calling `submit_quiz` on a **timed** quiz without ever calling `start_quiz` first fails with `"Quiz was not started"`.

On a successful submit, the attempt record is cleared, so a fresh, correctly-timed attempt can start next time (still subject to `max_attempts`).

### `due_date` — hard close, no late submissions

Unlike Homework's `due_date` (which allows late submissions via `allow_late_submission`), a quiz's `due_date` is a **hard close**: once it passes, `get_quiz_for_student`, `start_quiz`, and `submit_quiz` all reject with `"This quiz is closed"` — there is no way for a student to submit late. `due_date` is optional; a quiz with no `due_date` stays open indefinitely. Teachers can still view/edit a closed quiz at any time (including pushing `due_date` later to reopen it) — the close only applies to student-facing endpoints.

### `max_attempts`

`0` means unlimited attempts. Otherwise, once a student has `max_attempts` submissions for a quiz, further `submit_quiz` calls fail with `"You have reached the maximum number of attempts ({N}) for this quiz."`.

### Manual grading (Open Ended / File Upload)

A quiz's questions can freely mix auto-graded types (`Choices`, `User Input`) with manually-graded types (`Open Ended`, `File Upload`). Auto-graded questions are scored immediately on submit as usual, question by question, regardless of what else is in the quiz.

If a quiz has **any** manually-graded question — mixed with auto-graded ones or not — `submit_quiz` returns `"pass": null` and `"requires_manual_grading": true` instead of an immediate pass/fail, because the overall result legitimately isn't known yet. A teacher must call `grade_submission` with marks for **every** manually-graded question in that submission (never the auto-graded ones, which are already scored); only then do `score`, `percentage`, and `pass` reflect the final result, combining the auto-graded questions' scores (already recorded at submit time) with the newly-graded manual ones. Until graded, each ungraded question's `LMS Quiz Result` row has `is_graded = 0` and `marks = 0`; auto-graded rows already have `is_graded = 1` from submit time.

### Negative marking

With `enable_negative_marking` on, a wrong answer subtracts `marks_to_cut` for that question (visible as a negative `marks` value on that result row, for review). The submission's total `score` is floored at `0` — negative marking can cancel out correct answers but never push the overall score below zero.

### Answer completeness

`submit_quiz` requires an answer for **every** question in the quiz — `answers` must cover the full question set, not a subset. Submitting with one or more questions missing fails with `"Please answer all questions before submitting. Missing answer(s) for: {question names}"` before any scoring happens (no submission is created). This matters especially for mixed quizzes: omitting the one manually-graded question wouldn't just leave it unanswered, it would silently prevent `is_open_ended`/`requires_manual_grading` from ever being set — the check exists specifically to make that impossible.

### Finding submissions pending review

`get_submissions` and `get_student_submissions` both accept an optional `pending_grading` (bool) query param: `true` returns only submissions with at least one ungraded manual question, `false` excludes them, omitted returns everything. This is computed live from `LMS Quiz Result.is_graded` — there is no stored "status" field on the submission itself. Every submission row in these responses also carries a `requires_manual_grading` boolean.

---

## Teacher Endpoints

### GET `lms.quiz.controllers.list_quizzes`

List quizzes with optional filtering, paginated.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `lesson` | string | No | Filter to a single Course Lesson |
| `course` | string | No | Filter to a single LMS Course |
| `chapter` | string | No | Filter to all lessons under a Course Chapter (resolved internally) |
| `start` | int | No | Pagination offset (default `0`) |
| `page_size` | int | No | Page size (default `30`, max `100`) |

Returns the **caller's own** quizzes (Moderators see all).

**Response `data`:** paginated list of quizzes:

```json
{
  "items": [
    {
      "name": "geography-quiz",
      "title": "Geography Quiz",
      "max_attempts": 3,
      "show_answers": 1,
      "show_submission_history": 0,
      "total_marks": 3,
      "passing_percentage": 60,
      "duration": "30",
      "due_date": "2026-08-30 23:59:59",
      "shuffle_questions": 0,
      "limit_questions_to": 0,
      "enable_negative_marking": 0,
      "marks_to_cut": 1,
      "lesson": null,
      "course": null,
      "owner": "teacher@example.com",
      "creation": "...",
      "modified": "..."
    }
  ],
  "total": 1, "start": 0, "page_size": 30, "has_next_page": false
}
```

---

### GET `lms.quiz.controllers.get_quiz`

Get a single quiz with its full question list (teacher view — includes correct answers/possibilities).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `quiz` | string | Yes | LMS Quiz name |

---

### POST `lms.quiz.controllers.create_quiz`

Create a quiz, optionally with questions (existing or inline-created).

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `title` | string | Yes | Quiz title |
| `passing_percentage` | int | Yes | 0–100 |
| `max_attempts` | int | No | `0` = unlimited (default) |
| `show_answers` | bool | No | Show correct answers to students after submission |
| `show_submission_history` | bool | No | |
| `duration` | string/int | No | Minutes. Unset/`0` = untimed — see [Duration](#duration-timed-attempts--server-enforced-two-call-flow) |
| `due_date` | datetime | No | Quiz closes hard after this instant (`YYYY-MM-DD HH:MM:SS`) — see [due_date](#due_date--hard-close-no-late-submissions). Unset = never closes |
| `shuffle_questions` | bool | No | |
| `limit_questions_to` | int | No | Only valid with `shuffle_questions`; must be less than the question count, and all questions must share the same `marks` |
| `enable_negative_marking` | bool | No | |
| `marks_to_cut` | int | No | Only used when negative marking is enabled |
| `questions` | array/JSON string | No | Question list, see below |

`course` and `total_marks` are derived automatically and cannot be set directly.

**`questions` format** — each item is either a reference to an existing `LMS Question` or an inline definition that creates a new question:

```json
[
  {"question": "QTS-2024-00001", "marks": 2},
  {
    "inline": {
      "question": "What is the capital of France?",
      "type": "Choices",
      "option_1": "Paris", "option_2": "London",
      "is_correct_1": 1, "is_correct_2": 0
    },
    "marks": 1
  }
]
```

**Response `data`:** the created quiz doc.

---

### PUT `lms.quiz.controllers.update_quiz`

Update mutable quiz fields.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `quiz` | string | Yes | LMS Quiz name |
| any of: `title`, `max_attempts`, `show_answers`, `show_submission_history`, `passing_percentage`, `duration`, `due_date`, `shuffle_questions`, `limit_questions_to`, `enable_negative_marking`, `marks_to_cut` | — | At least one | Fields to update |
| `questions` | array/JSON string | No | Replaces/upserts questions (same format as `create_quiz`) |

Setting `due_date` to a future value reopens a closed quiz for students; clearing it removes the close entirely.

**Response `data`:** the updated quiz doc.

---

### DELETE `lms.quiz.controllers.delete_quiz`

Delete a quiz (and its submissions).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `quiz` | string | Yes | LMS Quiz name |

---

### POST `lms.quiz.controllers.add_question`

Attach an existing `LMS Question` to a quiz.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `quiz` | string | Yes | LMS Quiz name |
| `question` | string | Yes | LMS Question name |
| `marks` | int | No | Positive integer (default `1`) |

---

### DELETE `lms.quiz.controllers.remove_question`

Remove a question from a quiz.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `quiz` | string | Yes | LMS Quiz name |
| `question` | string | Yes | LMS Question name (must belong to this quiz) |

---

### POST `lms.quiz.controllers.grade_submission`

Grade a submission by providing per-question marks for all manually-graded questions (Open Ended / File Upload only). Choices/User Input questions are auto-graded at submit time and must not be included. Recomputes `score`/`percentage`/`pass` on the submission.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `submission` | string | Yes | LMS Quiz Submission name |
| `question_marks` | object/JSON string | Yes | Per-question marks: `{"question-name": {"marks": N}, ...}`. Must cover exactly the submission's manually-graded (Open Ended / File Upload) result rows. Each `marks` value must be between 0 and that row's `marks_out_of`. |

**Validation rules:**

- `question_marks` must be a non-empty object.
- Must include every manually-graded question in this submission.
- Must not include any auto-graded (Choices / User Input) question.
- `400` `"This quiz has no manually-graded (Open Ended / File Upload) questions"` if the quiz has none to grade.
- `400` listing the offending names if `question_marks` covers the wrong set.
- `400` if a mark is out of `[0, marks_out_of]` range for its question.
- `403` if the caller isn't a teacher role, or can't modify the submission's quiz (`validate_modify_quiz_permission`).

**Response `data`:**

```json
{
  "submission": "quiz-sub-0001",
  "score": 8,
  "score_out_of": 10,
  "percentage": 80.0,
  "pass": true
}
```

---

### GET `lms.quiz.controllers.get_student_submissions`

Quiz submissions with performance summaries for level tracking (teacher endpoint).

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `member` | string | No | Student email. Omit to fetch ALL students' submissions across the teacher's quizzes. 404 if the user doesn't exist. |
| `quiz` | string | No | Narrow to one quiz. 404 if it doesn't exist; 403 if the caller can't modify it. |
| `pending_grading` | bool | No | `true`/`false` — filter to submissions with/without at least one ungraded manual question. Omit for no filtering. |
| `start` | int | No | Pagination offset |
| `page_size` | int | No | Page size (default `30`, max `100`) |

Scope without `quiz`: a regular teacher sees attempts on quizzes **they own** only; a Moderator sees all. A teacher who owns no quizzes gets an empty result.

**Response `data`:**

```json
{
  "items": [
    {
      "name": "quiz-sub-0001", "quiz": "geography-quiz", "quiz_title": "Geography Quiz",
      "member": "student@example.com", "member_name": "Student Name",
      "score": 8, "score_out_of": 10, "percentage": 80.0, "passing_percentage": 60,
      "creation": "...", "requires_manual_grading": false
    }
  ],
  "total": 1, "start": 0, "page_size": 30, "has_next_page": false,
  "summary": { "attempts": 1, "average_percentage": 80.0, "best_percentage": 80.0, "passed": 1, "failed": 0, "quizzes_attempted": 1 },
  "students": [ { "member": "...", "member_name": "...", "attempts": 1, "average_percentage": 80.0, "best_percentage": 80.0, "passed": 1, "failed": 0, "quizzes_attempted": 1 } ]
}
```

`summary` covers ALL matching submissions (not just the current page). `students` — per-student summaries sorted by `average_percentage` descending; only present when `member` is omitted.

---

## Student Endpoints

### GET `lms.quiz.controllers.list_quizzes_for_student`

List quizzes from the student's enrolled courses, paginated.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `course` | string | No | Narrow to one enrolled course |
| `lesson` | string | No | Narrow to one lesson |
| `chapter` | string | No | Narrow to all lessons under a chapter |
| `start` | int | No | Pagination offset |
| `page_size` | int | No | Page size (default `30`, max `100`) |

---

### GET `lms.quiz.controllers.get_quiz_for_student`

Get a quiz with its questions in **student view** — correct answers stripped. Requires enrollment (if the quiz is course-linked) and the quiz to not be closed.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `quiz` | string | Yes | LMS Quiz name |

**Errors:** `403` `"You are not enrolled in the course for this quiz."`, `400` `"This quiz is closed"` (past `due_date`).

---

### POST `lms.quiz.controllers.start_quiz`

Registers the start of a timed attempt. **Call this once when the student begins a quiz that has `duration` set**, before showing/collecting answers — required for `submit_quiz` to succeed on that quiz. Safe to call again (idempotent — returns the original `started_on`, does not reset the clock), so it's safe to call on resume/page reload too. Not required for untimed quizzes, but harmless to call anyway.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `quiz` | string | Yes | LMS Quiz name |

**Response `data`:**

```json
{ "started_on": "2026-08-20 10:00:00", "duration": 30 }
```

**Errors:** `403` `"You are not enrolled in the course for this quiz."`, `400` `"This quiz is closed"`.

---

### POST `lms.quiz.controllers.submit_quiz`

Submit answers for a quiz attempt.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `quiz` | string | Yes | LMS Quiz name |
| `answers` | object/JSON string | Yes | Per-question answers: `{"question-name": <answer>, ...}`. `<answer>` is a string (single choice / user input / file URL) or array of strings (multiple choice). |

**Errors:**

- `400` `"You have reached the maximum number of attempts ({N}) for this quiz."`
- `400` `"This quiz is closed"` (past `due_date`)
- `400` `"Quiz was not started"` (timed quiz, `submit_quiz` called without a prior `start_quiz`)
- `400` `"Time is up for this quiz"` (timed quiz, submitted after `duration` + grace elapsed)
- `404` if a submitted question doesn't belong to the quiz
- `400` `"Please answer all questions before submitting. Missing answer(s) for: ..."` if `answers` doesn't cover every question in the quiz

**Response `data`:**

```json
{
  "submission": "quiz-sub-0001",
  "score": 2,
  "score_out_of": 3,
  "percentage": 66.67,
  "pass": true,
  "is_open_ended": false,
  "requires_manual_grading": false
}
```

For a quiz with manually-graded questions, `pass` is `null` and `requires_manual_grading` is `true` until a teacher calls `grade_submission` — see [Manual grading](#manual-grading-open-ended--file-upload). If `show_answers` is enabled on the quiz, the response also includes a `result` array with per-question correctness detail.

Example — File Upload answer (value is the `file_url` returned by `lms.question.controllers.upload_answer_file`, must be uploaded by the same user):

```json
{ "quiz": "quiz-name", "answers": { "QTS-2026-00001": "/private/files/my-worksheet.pdf" } }
```

---

### GET `lms.quiz.controllers.get_submissions`

Paginated quiz submissions. `quiz` is an **optional** filter.

**Parameters:**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `quiz` | string | No | Narrow to one quiz. 404 if it doesn't exist. |
| `pending_grading` | bool | No | `true`/`false` — filter to submissions with/without at least one ungraded manual question. Omit for no filtering. |
| `start` | int | No | Pagination offset |
| `page_size` | int | No | Page size (default `30`, max `100`) |

- With `quiz`: the quiz owner (or course staff/Moderator) sees ALL submissions of that quiz; a regular caller sees only their own attempts.
- Without `quiz`: a Moderator sees everything; otherwise you get your own attempts plus all attempts on quizzes you own.

**Response `data`:**

```json
{
  "items": [
    {
      "name": "quiz-sub-0001", "quiz": "geography-quiz", "quiz_title": "Geography Quiz",
      "member": "student@example.com", "member_name": "Student Name",
      "score": 2, "score_out_of": 3, "percentage": 66.67, "passing_percentage": 60,
      "creation": "...", "requires_manual_grading": false
    }
  ],
  "total": 1, "start": 0, "page_size": 30, "has_next_page": false
}
```
