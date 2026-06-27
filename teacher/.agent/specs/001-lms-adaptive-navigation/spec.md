# LMS Adaptive Navigation
Status: `implemented`

## Goal
Create the first reusable adaptive LMS navigation UI foundation for the teacher Flutter app.

## Summary
- Adds parent-controlled navigation components for five LMS destinations: Home, Classes, Students, Messages, and Schedule.
- Uses width-based layout behavior: compact bottom navigation, medium compact rail, and expanded sidebar-style rail.
- Keeps routing outside the components. Parents receive `onTap(index)` and decide whether to call `Navigator.pushNamed`.
- Adds a `HomeLayout` authenticated app shell route at `/home-layout` that hosts the adaptive navigation and tab bodies.
- Fixes the initial-route double-home stack by generating only the splash route on startup.

## Architecture
- Shared UI lives in `lib/core/widgets/navigation/` because the navigation shell is app-level reusable chrome.
- Adaptive breakpoint helpers live in `lib/core/extensions/adaptive_layout_extension.dart`.
- Navigation labels are localized through ARB files and generated `AppLocalizations`.
- Widgets use `Theme.of(context)` and `flutter_screenutil_plus` sizing.
- Authenticated success flows navigate to `AppRouteNames.homeLayout` and clear previous splash/auth routes.

## Out Of Scope
- No GoRouter or routing package.
- No backend, Frappe, API, or global state management.
- Real Classes, Students, Messages, and Schedule feature screens are not implemented yet.
- No navigation-specific unit or widget tests by request.
