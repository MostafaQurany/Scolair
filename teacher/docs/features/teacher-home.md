# Teacher Home & Learning Wall Feature

## Overview
The Teacher Home feature serves as the primary dashboard for teachers in Scolair. It combines a greet-context header with a scrollable activities feed ("Learning Wall") to let teachers view announcements, discussions, student questions, assignments, and quizzes.

## Folder Structure
```text
lib/features/home/
  data/
    datasources/
      local/
        teacher_home_local_datasource.dart    # Mock feed & filters source
    mappers/
      teacher_home_mapper.dart                # Model to Entity mappings
    models/
      teacher_home_response_data.dart
      teacher_wall_post_response_data.dart
      teacher_feed_query_data.dart
    repositories/
      teacher_home_repository_impl.dart       # Integrates cache & mock source
  domain/
    entities/
      teacher_home.dart
      teacher_feed_filter.dart
      teacher_wall_post.dart
      teacher_profile.dart
    repositories/
      teacher_home_repository.dart
    usecases/
      get_teacher_home_usecase.dart
      get_wall_posts_usecase.dart
      toggle_wall_post_like_usecase.dart
  presentation/
    cubit/
      home_cubit.dart                         # TeacherHomeCubit
      home_state.dart                         # TeacherHomeState (Freezed Union)
    screens/
      home_screen.dart                        # Entry HomeScreen provider
    widgets/
      home_view.dart                          # Scaffold, Scroll listener, Refresher
      teacher_home_app_bar.dart               # SliverAppBar, Notifications, Avatar action
      teacher_greeting_section.dart           # Time-adapted greeting
      organization_notice_card.dart           # Campaign noticed count card
      teacher_feed_filter_list.dart           # Horizontal chip filters
      teacher_wall_post_card.dart             # Unified Post Card container
      wall_post_header.dart                   # Avatar, post type badges, menu
      wall_post_body.dart                     # Content with read-more collapse
      wall_post_attachment_view.dart          # Attachment image rendering
      wall_post_engagement_bar.dart           # Likes count, comment nav stub
      teacher_home_skeleton.dart              # Shimmer loader
      teacher_home_empty_view.dart            # No posts fallback
      teacher_home_error_view.dart            # Error retry card
```

## Architecture
This feature strictly adheres to feature-first Clean Architecture:
- **Presentation Layer**: Widgets observe the `TeacherHomeCubit` states. User actions trigger cubit methods which invoke domain use cases.
- **Domain Layer**: Contains pure business entities, repository contracts, and isolated use cases. No framework dependencies.
- **Data Layer**: Coordinates data fetch using local mock sources (until remote API endpoints are published) and caches profiles inside `AppSharedPreferences`.

## Detailed Specifications
### AppUserAvatar fallback behavior
If a profile image URL is present, it uses `AppCachedNetworkImage`. Otherwise, it splits the teacher's display name into words and extracts initials (e.g. "Alex Johnson" -> "AJ", "Ahmed" -> "A") supporting Unicode/Arabic characters. A stable color is deterministically selected from a M3 palette based on a hash of the user ID, ensuring consistent aesthetics across rebuilds.

### Time-adapted greetings
The salutation adapts dynamically to the device time:
- Morning: `00:00 - 11:59`
- Afternoon: `12:00 - 16:59`
- Evening: `17:00 - 23:59`

### Pagination & Optimistic Likes
- **Pagination**: Uses standard page-based query (`page` and `page_size` params). Infinite scrolling is triggered when the user scrolls past 80% of the feed height.
- **Optimistic Likes**: Instantly toggles the like icon and increments/decrements like count. In the case of API failures, the state is rolled back and an `AppSnackBar` displays the error message.
