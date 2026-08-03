# design.md — Teacher Mobile Notification Screen

## 1. Purpose

This document describes the UI/UX specification for the **Teacher Mobile Notification Screen** in the LMS mobile application (Flutter). It is intended to be handed directly to a UI designer or an AI coding agent for implementation.

The screen is the teacher's single inbox for everything that requires their awareness or action across all courses they teach: student submissions, grading queues, grade publication events, collaboration activity, enrollments, student-risk alerts, and system events.

---

## 2. Architectural Context

The LMS follows an **event-driven** model:
- **Business services** (Assessment, Gradebook, Collaboration, etc.) are **producers**. They publish domain events to the LMS Event Bus.
- The **Notification Service** is a **consumer**. It subscribes to those events, builds notification records, stores them in its own database, and delivers them to the correct recipients.
- The **Mobile App** does **not** connect directly to the internal LMS Event Bus. It receives data exclusively via the Notification REST API, WebSocket/SSE stream, and FCM/APNs push delivery.
- This screen is a **read + interact** surface. It does not mutate business data directly. It deep-links into the owning feature screen, which handles the mutation.

**Action Completion Flow:**  
Opening a notification or tapping an action button (e.g., "Open grading queue") **does not** mark the action as completed locally. The notification is marked as `read`, and the user is navigated to the owning feature. Only when the owning feature completes the task (e.g., the teacher submits grades) does that feature emit a domain event. The Notification Service consumes that event and updates the notification's state to `actionCompleted`. The UI then reflects this change via real-time update or refresh.

---

## 3. Information Architecture

```text
Notifications Screen
├── App Bar
│   ├── Back / Drawer toggle
│   ├── Title: "Notifications" + unread count badge
│   ├── Search icon
│   ├── Filter icon (opens advanced bottom sheet)
│   └── Overflow menu (Mark all read, Settings, View archived)
├── Filter Chip Row (horizontal scroll - MVP subset)
│   ├── All
│   ├── Unread
│   ├── Action Required
│   └── Submissions
├── Pinned Section (optional, collapsed rows)
├── Today Section
├── Yesterday Section
└── Earlier Section (this week / this month / older)
```

---

## 4. Screen Structure & Visual Hierarchy

### 4.1 Layout
- **Top app bar** (56 dp): title left-aligned (RTL: right-aligned), unread count as a small pill, action icons right-aligned.
- **Sticky filter chip row** (48 dp) directly under the app bar. Remains visible during scroll.
- **Inline search bar** that expands below the chip row when the search icon is tapped (not persistent, to save vertical space).
- **Scrollable feed** of grouped notification cards. Groups are introduced by a sticky group header.
- **Bottom navigation** is the global app tab bar.
- No Floating Action Button (FAB) is used on this screen. "Mark all read" is accessible via the overflow menu.

### 4.2 Visual Hierarchy
1. **Group headers** — small, muted, all-caps (e.g., "TODAY"). Includes a count of items in the group if space permits.
2. **Action-required / Urgent cards** — strongest visual weight: colored left border, bold title, inline action button(s).
3. **Unread cards** — medium weight: bold title, unread dot, subtle tinted background.
4. **Read cards** — lowest weight: regular weight text, neutral background.
5. **Pinned cards** — pinned indicator icon, never auto-dismissed.

---

## 5. Notification Card Design

### 5.1 Anatomy
```text
┌────────────────────────────────────────────────────────┐
│ ▌ [icon]  Category label · Course name          • 3m   │
│ │                                                        │
│ │  Title (bold if unread)                                │
│ │  Body preview (1–2 lines, ellipsized)                  │
│ │  [matched search text highlighted]                     │
│ │                                                        │
│ │  [Action Button 1]  [Action Button 2]   [chevron >]   │
└────────────────────────────────────────────────────────┘
```
- **Left accent strip** (4 dp wide): color depends on category and state (urgent = red, action-required = amber, unread = primary blue at 30% opacity, read = none).
- **Category icon** (40×40 dp circular tile): tinted with category color.
- **Title** (16 sp, medium if unread, regular if read).
- **Body** (14 sp, 2-line max, secondary color).
- **Meta row** (12 sp): category label · course name · relative timestamp. 
  - *Interaction:* Tapping the timestamp toggles between relative time ("3m") and absolute exact date/time ("Oct 12, 2:45 PM").
- **Action buttons**: Maximum of two quick action buttons per card. Rendered as text buttons.
- **Chevron** (only on tappable cards with deep-link target).
- **Unread dot** (8 dp) in the top-right corner (top-left in RTL).

### 5.2 Sizing & Spacing
- Card padding: 12 dp vertical, 16 dp horizontal.
- Card-to-card spacing: 6 dp.
- Card corner radius: 12 dp.
- Card elevation: 0 dp (use border 1 dp `outlineVariant`); elevation 1 dp only when long-pressed.

---

## 6. Notification Categories, Icons & Event Mapping

All event names strictly match the LMS Event Bus catalog. Undocumented events have been removed.

| Category | Icon (Material Symbols) | Color | Default Priority | Source Events |
|---|---|---|---|---|
| Assignment Submission | `assignment_turned_in` | Teal | Normal | `AssignmentSubmitted` |
| Quiz Submission | `quiz` | Indigo | Normal | `QuizSubmitted` |
| Manual Grading Required | `fact_check` | Amber | High | `ManualGradingRequired` |
| Grades Published | `published_with_changes` | Green | Normal | `GradeCreated`, `GradeUpdated`, `GradePublished`, `AssessmentGraded` |
| Collaboration — Post | `forum` | Cyan | Normal | `PostCreated` |
| Collaboration — Comment/Reaction | `chat_bubble` | Cyan | Normal | `CommentCreated`, `ReactionAdded` |
| Study Group Activity | `groups` | Deep Purple | Normal | `StudyGroupCreated`, `GroupMemberAdded` |
| Moderation | `report` | Red | Urgent | `ModerationReportCreated` |
| Smart Notes | `sticky_note_2` | Light Blue | Normal | `NoteShared`, `NoteCommentCreated` |
| Enrollment | `person_add` | Brown | Normal | `StudentEnrolled`, `StudentUnenrolled` |
| Student Risk | `warning` | Red | Urgent | `StudentAtRiskDetected`, `EngagementDropped` |
| Workload / Capacity | `speed` | Orange | High | `WorkloadRiskDetected`, `CapacityRiskDetected` |
| Integration / Sync | `sync` | Grey | Low | `IntegrationConnected`, `SyncJobCompleted`, `SyncJobFailed` |
| Security | `security` | Deep Red | Urgent | `SecurityAlertRaised` |

---

## 7. Notification States

| State | Visual | Behavior |
|---|---|---|
| **Unread** | Bold title, unread dot, background `primaryContainer` at 8% opacity. | Counted in unread badge. |
| **Read** | Regular weight, no dot, neutral background. | Excluded from unread count. |
| **Urgent** | Red 4 dp left accent strip, red category icon tint, "Urgent" chip in meta row. | Behavior is server-configurable (see Section 13). |
| **Action required** | Amber left strip, inline action button(s). Stays at the top of its group until action completed or dismissed. | Tapping action navigates; does NOT complete the action locally. |
| **Action completed** | Title gets a strikethrough accent, action button replaced by "Done ✓" disabled chip. | State is updated remotely via owning service event, not local tap. |
| **Pinned** | Pin glyph next to timestamp. Stays in Pinned section. | User-controlled. |
| **Muted** | Bell-off glyph in meta row. Still appears in feed; push behavior depends on server config. | |
| **Archived** | Hidden from default feed; visible under filter = "Archived". | |

---

## 8. Filtering & Search

### 8.1 Filter Chips (MVP)
Horizontal scrollable row. Single-select. Default = "All".

| Chip | Behavior |
|---|---|
| All | Everything except archived/expired. |
| Unread | `isRead = false`. Count badge on chip. |
| Action Required | `actionRequired = true AND actionCompleted = false`. Count badge. |
| Submissions | Categories: Assignment Submission, Quiz Submission. |

Tapping an active chip again deselects it and returns to "All".

### 8.2 Advanced Filter Bottom Sheet
Accessed via the Filter icon in the App Bar. Allows multi-select filtering across:
- Categories (Grading, Discussions, Students, System, etc.)
- Courses
- Priority (Urgent, High, Normal, Low)

### 8.3 Search
- Search icon in app bar toggles a search field.
- Searches across: title, body, course name, category label, student name.
- Debounced 300 ms.
- **Matched text is highlighted** in the search results with a primary color background at 30% opacity.
- Empty search query restores the previous filter view.
- Search results are grouped under a single "Results" header.

### 8.4 Time Formatting Rules
- < 60 seconds: "Just now"
- < 60 minutes: "Xm ago"
- < 24 hours: "Xh ago"
- < 7 days: Weekday name (e.g., "Monday")
- > 7 days / current year: "MMM d" (e.g., "Oct 12")
- Previous year: "MMM d, yyyy" (e.g., "Oct 12, 2023")
- Tapping any timestamp temporarily toggles to exact absolute time ("Oct 12, 2023, 2:45 PM") for 3 seconds.

### 8.5 Loading Indicators
- Skeletons (shimmer) are only displayed if the API response exceeds 150–200ms. Fast responses should render immediately without artificial delays.

---

## 9. Grouping
- **Pinned** — top of the list, ordered by pin time descending. Collapsible.
- **Today** — `createdAt >= 00:00 today`.
- **Yesterday** — `createdAt >= 00:00 yesterday`.
- **Earlier — This Week** — earlier than yesterday but within current week.
- **Earlier — This Month** — within current month.
- **Older** — everything else.

Group headers are sticky. If the group count does not crowd the header, a small count badge is displayed (e.g., "TODAY · 5").

---

## 10. Interactions

### 10.1 Tap
- Tapping a card:
  1. Marks the notification as read (optimistic UI update).
  2. Navigates to the deep-link target.
- Tapping an inline action button:
  1. Marks the notification as read.
  2. Navigates to the deep-link target with action context.
  3. **Does not** mark `actionCompleted` locally. The owning feature must handle the action, and the Notification Service will later update the state.

### 10.2 Swipe Gestures (Simplified)
- **Swipe start-edge (left→right in LTR)**: "Mark as read / Unread" toggle.
- **Swipe end-edge (right→left in LTR)**: "Archive".
*No multi-stage percentage-based swipe actions are used to ensure predictable control.*

### 10.3 Long-Press
Opens a bottom sheet with:
- Mark as read / Unread
- Pin / Unpin
- Mute this category
- Mute this course
- View notification settings
- Delete (only for non-urgent, non-action-required)

### 10.4 Pull-to-Refresh
Triggers a fresh fetch from the Notification Service. Shows `RefreshIndicator`.

### 10.5 App Bar Buttons
| Button | Behavior |
|---|---|
| Back | Returns to previous screen. |
| Search | Expands inline search field. |
| Filter | Opens advanced filter bottom sheet. |
| Overflow → Mark all read | Marks every visible notification `isRead = true`. Confirmation dialog. |
| Overflow → Notification settings | Opens Preferences screen. |
| Overflow → View archived | Opens archived list. |

---

## 11. Navigation on Open (Deep-Link Targets)

Deep-link targets per notification category:

| Source Event(s) | Target Screen | Passes |
|---|---|---|
| `AssignmentSubmitted`, `QuizSubmitted` | Submission Detail / Attempt Review | `submissionId`, `attemptId`, `courseId`, `assessmentId` |
| `ManualGradingRequired` | Grading Queue | `courseId`, `assessmentId` |
| `GradeCreated`, `GradeUpdated`, `GradePublished`, `AssessmentGraded` | Gradebook | `courseId`, `assessmentId` |
| `PostCreated`, `CommentCreated`, `ReactionAdded` | Wall Post Detail | `postId`, `commentId` (if applicable) |
| `StudyGroupCreated`, `GroupMemberAdded` | Study Group | `studyGroupId` |
| `ModerationReportCreated` | Moderation Queue | `reportId`, `postId` |
| `NoteShared`, `NoteCommentCreated` | Shared Note Detail | `noteId`, `commentId` (if applicable) |
| `StudentEnrolled`, `StudentUnenrolled` | Course Roster | `courseId`, `studentId` |
| `StudentAtRiskDetected`, `EngagementDropped` | Student Risk Profile | `studentId`, `courseId`, `riskEventId` |
| `WorkloadRiskDetected`, `CapacityRiskDetected` | Teacher Workload Dashboard | `courseId` (optional) |
| `IntegrationConnected`, `SyncJobCompleted`, `SyncJobFailed` | Settings → Integrations | `integrationId` |
| `SecurityAlertRaised` | Security Center | `securityEventId` |

If the target context no longer exists, the target screen shows an inline "content no longer available" state.

---

## 12. Screen States

- **Loading (initial)**: Skeleton placeholders (if >150ms load time).
- **Loading (pagination)**: Small circular progress indicator at the bottom of the list.
- **Empty (no notifications)**: Centered illustration. Headline: "You're all caught up". Action: "Browse courses".
- **Empty (filtered)**: Headline: "Nothing here". Action: "Clear filters".
- **Empty (search)**: Headline: "No matches for '<query>'". Action: "Clear search".
- **Offline**: Persistent banner: "You're offline. Showing cached notifications." Cached notifications remain visible.
- **Error**: Inline error card replacing the feed: icon, message, "Retry" button.
- **Real-time updates**: WebSocket pushes update the feed live. New items animate in at the top of "Today". If scrolled > 200 dp from top, show a floating "New notifications" pill.

---

## 13. Notification Preferences & Server-Driven Policies

The UI does not hardcode rules about which notifications can be muted or bypass quiet hours. The Notification Service provides policy flags per category/notification, and the UI renders controls accordingly.

Example server payload:
```json
{
  "can_mute": false,
  "bypass_quiet_hours": true,
  "is_mandatory": true
}
```

### 13.1 Preferences Screen
- **Global**: Master push toggle, Quiet hours configuration, Email digest toggle.
- **Per-Category Toggles**: Push and In-app switches. If `can_mute == false` for a category (e.g., Security), the switch is visibly locked/disabled with a tooltip: "Required notifications cannot be disabled."
- **Per-Course Mute**: List of teacher's courses with mute switches and "Customize" options.

---

## 14. Accessibility, i18n, RTL & Responsive

Accessibility and RTL are built into the component architecture from Phase 1.

### 14.1 Accessibility
- 48×48 dp minimum touch targets.
- Semantic labels for icons.
- Color is never the sole signal — every state has an icon or text label.
- Supports dynamic font scaling up to 200%.
- Respects `MediaQuery.accessibleNavigation`.

### 14.2 Internationalization
- Full English and Arabic translations via `.arb` files.
- Pluralization support for all strings (including Arabic's 6 plural forms).
- Time formatting uses `intl` package.

### 14.3 RTL
- Entire layout mirrors: app bar actions, swipe directions, chevrons, accent strip (right side in RTL), unread dot (top-left in RTL).
- Filter chips scroll starting from the right edge.
- Swipe-to-read: from the right edge in RTL.
- Directional icons auto-mirrored via `Directionality`.

### 14.4 Responsive
- Phone portrait: single column.
- Phone landscape / small tablet: list max-width 720 dp, centered.
- Tablet / foldable: two-pane master–detail layout (list 40%, detail pane 60%).

---

## 15. Recommended Flutter Components

| Concern | Widget |
|---|---|
| Screen scaffold | `Scaffold` with `SliverAppBar` |
| Sticky filter chips | `SliverPersistentHeader` containing `ListView` of `ChoiceChip` |
| Grouped feed | `CustomScrollView` with `SliverList` per group + `SliverPersistentHeader` |
| Notification card | Custom `StatelessWidget` |
| Swipe actions | `Dismissible` with `confirmDismiss` guard |
| Long-press menu | `showModalBottomSheet` |
| Pull-to-refresh | `RefreshIndicator` |
| Real-time updates | `StreamBuilder<NotificationFeedEvent>` over a BLoC/Cubit |
| Avatars | `CachedNetworkImage` inside `CircleAvatar` |
| Unread badge | `Badge` widget (Material 3) |
| Search highlight | `RichText` with `TextSpan` styling matched substrings |

### 15.1 State Management
- **Dependencies**: `flutter_bloc`, `equatable`. (Do not mix with `provider`).
- **`NotificationFeedCubit`** exposes state for feed list, filters, search query, UI status (idle/loading/error/offline), and unread count.
- **Events**: `loadInitial`, `loadMore`, `refresh`, `applyFilter`, `applySearch`, `markRead(id)`, `togglePin(id)`, `archive(id)`, `onPush(event)`. 
- *Note:* `completeAction(id)` is NOT a local Cubit event. The feed state updates `actionCompleted` only when receiving a server push via `onPush(event)` indicating the business service completed the task.

---

## 16. Future Enhancements (Phase 2)

- **Multi-select mode**: Long-press to enter selection mode for batch archive/read actions.
- **Snooze**: Temporary snooze for 1 hour, 4 hours, or 1 day via long-press bottom sheet.

---

## 17. Acceptance Criteria

1. All source event categories render with the correct icon, color, and priority using the exact documented Event Bus names.
2. Unread count updates optimistically and reconciles with the server within 2 seconds.
3. Tapping an action button navigates to the deep-link target but **does not** mark the action as completed locally; the UI waits for server confirmation to show "Done ✓".
4. Swipe behaviors strictly follow the simplified model (start-edge = read/unread, end-edge = archive).
5. Search results highlight matched text substrings.
6. Full RTL Arabic layout is pixel-correct and functional at 200% text scaling.
7. No Floating Action Button (FAB) is present on the screen.
8. Filter chip row defaults to: All, Unread, Action Required, Submissions.
9. Notification muting and quiet-hours bypass behavior respects server-driven policy flags (`can_mute`, `bypass_quiet_hours`).
10. Offline actions are queued and replayed on reconnect without duplicates.
11. The app relies exclusively on `flutter_bloc` for state management and connects only to the Notification Service APIs (REST/WebSocket), never directly to the internal LMS Event Bus.
