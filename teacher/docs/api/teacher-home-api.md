# Teacher Home & Wall Feed API Contract

> [!NOTE]
> This contract is currently a **Proposed Contract** and is not yet implemented on the Frappe server. 
> The client utilizes a mock local data source (`TeacherHomeLocalDataSourceImpl`) to emulate this API.

## Endpoints

### 1. Fetch Dashboard & Feed Metadata
Retrieves cached teacher profile information, time-based next-activity context, organization notices count, and scrollable filters list.

- **URL**: `/api/method/scolair.teacher.home.get_dashboard`
- **Method**: `GET`
- **Headers**:
  - `Authorization: Bearer <token>`
- **Response Shape (Success)**:
```json
{
  "message": {
    "teacher": {
      "id": "teacher_001",
      "display_name": "Alex Johnson",
      "image_url": null
    },
    "greeting_context": {
      "next_activity_title": null
    },
    "organization_notices_count": 2,
    "filters": [
      {
        "id": "all",
        "label": "All Classes",
        "type": "all"
      },
      {
        "id": "grade_10_a",
        "label": "Grade 10-A",
        "type": "classroom"
      }
    ]
  }
}
```

---

### 2. Fetch Wall Feed Posts
Retrieves a paginated list of social wall feed posts, filtered by audience or subject.

- **URL**: `/api/method/scolair.teacher.home.get_feed`
- **Method**: `GET`
- **Headers**:
  - `Authorization: Bearer <token>`
- **Query Parameters**:
  - `filter_id` (String, optional): Target filter category
  - `page` (int, required): Current page number (1-based)
  - `page_size` (int, required): Maximum posts per page
- **Response Shape (Success)**:
```json
{
  "message": {
    "posts": [
      {
        "id": "post_001",
        "author": {
          "id": "teacher_001",
          "display_name": "Alex Johnson",
          "role_label": "Calculus Teacher",
          "image_url": null
        },
        "type": "announcement",
        "body": "Calculus mid-term next Tuesday. Please review the derivatives section.",
        "hashtags": ["Calculus", "ExamPrep"],
        "created_at": "2026-07-19T08:00:00Z",
        "audience": {
          "id": "grade_10_a",
          "label": "Grade 10-A"
        },
        "privacy": "class_room",
        "attachment": null,
        "like_count": 24,
        "comment_count": 5,
        "is_liked_by_current_user": false,
        "is_owned_by_current_user": true,
        "is_pinned": true,
        "is_answered": false,
        "permissions": {
          "can_edit": true,
          "can_delete": true,
          "can_pin": true,
          "can_report": false,
          "can_moderate": true
        }
      }
    ],
    "has_more": true,
    "next_page": 2
  }
}
```

---

### 3. Toggle Post Like Reaction
Allows a user to react (like/unlike) to a post.

- **URL**: `/api/method/scolair.teacher.home.toggle_like`
- **Method**: `POST`
- **Headers**:
  - `Authorization: Bearer <token>`
- **Request Body**:
```json
{
  "post_id": "post_001",
  "should_like": true
}
```
- **Response Shape (Success)**: Returns the updated post object.
```json
{
  "message": {
    "id": "post_001",
    "like_count": 25,
    "is_liked_by_current_user": true
  }
}
```
