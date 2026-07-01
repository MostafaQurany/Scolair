# Scolair Project Rules

These rules apply to all Flutter branches: `student`, `parent`, and `teacher`.

## Agent Workflow

- Read `.agent/project-rules.md` before every coding task, review request, refactor, terminal command, file creation, or file update.
- Read `.agent/project-memory.md` before starting work to understand completed tasks, active work, next tasks, open questions, and validation history.
- If a related spec exists in `.agent/specs/`, read it before changing files.
- Create a spec from `.agent/specs/spec-template.md` for meaningful features, major screens, cross-cutting refactors, architecture setup, or multi-step work.
- Update the related spec task status as work progresses.
- Update `.agent/project-memory.md` when project status, completed work, next tasks, open questions, or validation history changes.
- Do not mark a spec task as `done` unless the work and required validation are complete.
- If validation is skipped, record the reason in the related spec or `.agent/project-memory.md`.
- If the rule file conflicts with a user request, explain the conflict before changing files.
- If `.agent/project-rules.md` or `.agent/project-memory.md` is missing or unreadable, stop and ask for it.

## Project Structure

- Use this structure for all new Flutter code.
- Keep `app/` for app startup and root app configuration.
- Keep `core/` for shared code used by more than one feature.
- Keep feature-specific code inside `features/feature_name/`.
- Do not put feature-specific widgets, models, or Cubits inside `core/`.
- Do not create extra folders unless they solve a real organization problem.

Required structure:

```text
lib/
  main.dart
  app/
    app.dart 
  core/
    widgets/
    errors/
      exceptions.dart
      failures.dart
      error_handler.dart
    network/
      api_client.dart
      api_result.dart
      api_endpoints.dart
      dio_factory.dart
      interceptors/
        auth_interceptor.dart
        logging_interceptor.dart
    theme/
      app_colors.dart
      app_theme.dart
      app_text_styles.dart
    di/
      dependency_injection.dart
    storage/
      app_shared_preferences.dart
      app_secure_storage.dart
    constants/
      app_route_names.dart
    extensions/
      adaptive_layout_extension.dart
    localization/
      localization_extension.dart
    utils/
      extensions/
  features/
    feature_name/
      data/
        datasources/
          remote/
          local/
        models/
          name_request_data.dart
          name_response_data.dart
        mappers/
          name_mapper.dart
        repositories/
          name_repository_impl.dart
      domain/
        usecases/
        entities/
        repositories/
          name_repository.dart
      presentation/
        widgets/
        screens/
        cubit/
          name_cubit.dart
          name_state.dart
          name_state.freezed.dart
  l10n/
    app_en.arb
    app_ar.arb
```

## Feature Layers

- `data/` contains API/local data sources, models, and repository implementations.
- `domain/` contains entities, use cases, and repository contracts.
- `presentation/` contains screens, widgets, and Cubits.
- Screens should compose widgets and connect Cubits.
- Widgets should only handle UI and simple UI callbacks.
- Cubits should call use cases or repositories, then emit states.
- Models should not replace domain entities unless the feature is very small.

## Model Rules

- Keep API request and response models inside `features/feature_name/data/models/`.
- Use `name_request_data.dart` for request body/query data sent to the API.
- Use `name_response_data.dart` for response data received from the API.
- Use clear names based on the API action, such as `login_request_data.dart` and `login_response_data.dart`.
- Request models should only contain fields needed by the API request.
- Response models should match the API response shape.
- Add `fromJson` and `toJson` where needed for Retrofit and Dio.
- Keep parsing and mapping logic in the data layer.
- Convert response models to domain entities before presentation when the feature needs domain separation.
- Do not pass request or response models directly into widgets unless the feature is very small and has no domain entity.

## Core Rules

- `core/network/` owns API setup, endpoints, results, and interceptors.
- `api_client.dart` should define Retrofit API services.
- `api_result.dart` should represent success and failure clearly.
- `api_endpoints.dart` should contain endpoint constants only.
- `dio_factory.dart` should create and configure the shared Dio instance.
- `auth_interceptor.dart` handles auth headers and token behavior.
- `logging_interceptor.dart` handles request and response logging only.
- `core/theme/` owns colors, text styles, and app theme.
- `core/storage/` owns shared preferences and secure storage wrappers.
- `core/constants/app_route_names.dart` owns route name constants.
- `core/extensions/` owns reusable BuildContext and app-wide Dart extensions.
- `core/localization/` owns simple localization helpers.
- `core/widgets/` is only for widgets reused across multiple features.
- `core/errors/` is for shared failure and exception handling.

## Network File Details

- `api_client.dart`
  - Define Retrofit API abstract classes here.
  - Use `@RestApi` and HTTP method annotations such as `@GET`, `@POST`, `@PUT`, and `@DELETE`.
  - Return typed models or response wrappers, not raw maps.
  - Do not add business logic inside API client methods.
  - Keep generated Retrofit files next to the API client when required.
- `api_result.dart`
  - Define a shared result type for API success and failure.
  - Success should contain the expected data.
  - Failure should contain a clear error message and optional error details.
  - Use this result type in repositories so Cubits can handle responses safely.
- `api_endpoints.dart`
  - Store base paths and endpoint constants here.
  - Use clear names such as `login`, `studentProfile`, or `teacherClasses`.
  - Do not build request bodies or parse responses in this file.
  - Avoid hardcoded endpoint strings inside features.
- `dio_factory.dart`
  - Create the shared Dio instance here.
  - Configure base URL, timeouts, headers, and interceptors.
  - Add `AuthInterceptor` and `LoggingInterceptor` here.
  - Do not create Dio directly inside repositories, Cubits, or widgets.
- `interceptors/auth_interceptor.dart`
  - Attach auth tokens to requests when required.
  - Read tokens from secure storage or the approved auth source.
  - Handle unauthorized responses only if the project has a clear refresh or logout flow.
  - Do not show UI directly from this interceptor.
- `interceptors/logging_interceptor.dart`
  - Log request method, URL, status code, and useful error details.
  - Keep logs safe and avoid printing tokens, passwords, or private user data.
  - Disable or reduce noisy logs for production builds.

## Error Handling

### Rule: Single conversion point
- All exceptions must be converted to `Failure` via `ErrorHandler.handle(error)` in `core/errors/error_handler.dart`.
- Do not call `e.toString()`, `e.message`, or build `Failure` objects manually outside of `ErrorHandler`.
- Repositories must catch `on Object` and return `ApiFailure(ErrorHandler.handle(e))`.
- Never let raw exceptions propagate to Cubits or widgets.

### Rule: Failure types
- `NetworkFailure` — no internet, timeout, connection refused.
- `ServerFailure` — server responded with 4xx/5xx; message extracted from response body.
- `CacheFailure` — local storage read/write errors.
- `UnknownFailure` — anything else.
- `ErrorHandler` reads Frappe response body in this order: `data['message']` → `data['exception']` → first message in `data['_server_messages']` → fallback to `'Server error (statusCode)'`.

### Rule: Cubit error states
- Every Cubit that emits `loading()` MUST always emit a terminal state (`success`, `error`, etc.) in every code path — no early returns after `loading()` without a terminal emit.
- Cubit error states carry the full `failure.message` string — never discard it with `_`.
- Cubit states must NOT carry `Failure` objects or Dio types — only `String message`.

### Rule: Error display — SnackBar is the standard
- All user-visible errors are shown via `AppSnackBar.showError(context, message)` from `core/widgets/app_snack_bar.dart`.
- All user-visible success confirmations are shown via `AppSnackBar.showSuccess(context, message)`.
- Never call `ScaffoldMessenger.of(context).showSnackBar(...)` directly in screens — always use `AppSnackBar`.
- `AppSnackBar.showError` falls back to `context.l10n.authErrorGeneric` if the message is empty.
- Always check `context.mounted` before calling `AppSnackBar` methods (the helper does this internally).

### Rule: Screen error listening
- Every screen that has a Cubit with an error state MUST handle it in `_handleState` (or equivalent listener).
- Never use `_` to discard the error message parameter — always pass it to `AppSnackBar.showError`.
- Do not hardcode error strings in screens; use the message from the state, with `context.l10n.authErrorGeneric` as fallback only when the message is empty (handled by `AppSnackBar` automatically).

## State Management

- Use `flutter_bloc` with Cubit for state management.
- Use `freezed` to create Cubit state classes.
- Keep Cubit states in `name_state.dart`.
- Generated Freezed files must be committed when required by the project.
- Keep Cubit methods small and named by user action.
- Keep state classes clear and predictable.
- Do not call APIs, storage, or heavy logic directly from widgets.
- Emit loading, success, and error states where needed.
- Use one Cubit per clear screen flow or feature action group.
- Do not share one large Cubit across unrelated screens.
- Keep state immutable.
- Avoid putting `BuildContext` inside Cubits.
- Use explicit Freezed states such as initial, loading, success, empty, and error when the flow needs them.
- Do not use loose boolean flags when a clear Freezed union state is better.

## Navigation

- Do not use `go_router`.
- Use Flutter `Navigator` or the project navigation helper if one is created later.
- Keep route names in `core/constants/app_route_names.dart`.
- Do not hardcode route strings inside screens.
- Keep navigation simple and explicit.

## Localization

- Use Flutter official localization with `flutter_localizations`, `intl`, ARB files, and generated `AppLocalizations`.
- Keep localization setup shared across `student`, `parent`, and `teacher` branches.
- Store translation files in `lib/l10n/`.
- Name ARB files with Flutter's standard pattern, such as `app_en.arb` and `app_ar.arb`.
- Keep all user-visible text in ARB files.
- Keep the simple context helper in `core/localization/localization_extension.dart`.
- Do not hardcode user-facing strings inside screens or widgets.
- Use the project helper `context.l10n.keyName` for visible text.
- Use generated localization methods for dynamic text, placeholders, plurals, and context-aware messages.
- Use `AppLocalizations.supportedLocales` for supported languages.
- Use `AppLocalizations.localizationsDelegates` in `MaterialApp`.
- Support right-to-left languages such as Arabic by avoiding hardcoded `TextDirection`, left/right padding, and left/right alignment when directional alternatives exist.
- Use `start` and `end` instead of `left` and `right` for localized layouts.
- Localize modals, dialogs, bottom sheets, errors, empty states, buttons, and system prompts.
- Test translated text for expansion, truncation, overflow, and RTL layout issues.
- Use pseudo-long text or Arabic text when checking layout resilience.
- Keep translation keys stable and meaningful.
- Do not reuse one translation key for text with different meaning or tone.
- Do not concatenate translated strings in widgets; use ARB placeholders instead.
- Do not put localization setup inside feature widgets.
- For large translation workflows, keep ARB files structured and review missing or outdated translations before release.

Required dependencies:

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any
```

Required `pubspec.yaml` generation setup:

```yaml
flutter:
  generate: true
```

Recommended `l10n.yaml`:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

Required `MaterialApp` setup in `app/app.dart`:

```dart
MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
);
```

Required simple helper pattern in `core/localization/localization_extension.dart`:

```dart
import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
```

Required usage pattern in widgets:

```dart
Text(context.l10n.appName);
```

Required placeholder pattern in ARB:

```json
{
  "welcomeUser": "Welcome, {userName}",
  "@welcomeUser": {
    "placeholders": {
      "userName": {}
    }
  }
}
```

Required dynamic text usage:

```dart
Text(context.l10n.welcomeUser(userName));
```

Required plural pattern in ARB:

```json
{
  "itemCount": "{count, plural, =0{No items} =1{1 item} other{{count} items}}",
  "@itemCount": {
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}
```

Required plural usage:

```dart
Text(context.l10n.itemCount(count));
```

## Clean Code

- Use meaningful names for files, classes, methods, and variables.
- Keep functions short.
- Avoid deeply nested conditions.
- Prefer early returns when they make code easier to read.
- Avoid duplicated code.
- Remove unused imports, dead code, and debug prints before committing.
- Keep formatting consistent with `dart format`.
- Prefer small, clear conditions over complex inline expressions.
- Do not hide important behavior inside clever helpers.
- Keep files focused on one responsibility.
- Follow Dart naming conventions:
  - Files: `snake_case.dart`
  - Classes: `PascalCase`
  - Variables and methods: `camelCase`

## Widget Rules

- Avoid building very large widgets in one file.
- Extract repeated UI into private widgets or shared widgets.
- Keep build methods easy to scan.
- Do not put networking, database, or validation-heavy logic inside `build`.
- Use constants for repeated spacing, colors, and text styles when useful.
- Prefer `StatelessWidget` when local mutable state is not needed.
- Use `BlocBuilder`, `BlocListener`, and `BlocConsumer` only where needed.
- Keep loading, empty, error, and success UI states clear.
- Split a screen when the `build` method becomes hard to read.

## Responsive UI

- Use `flutter_screenutil_plus` for responsive and adaptive sizing.
- Initialize ScreenUtil at the app root before using `.w`, `.h`, `.sp`, or `.r`.
- Use `.w` and `.h` for responsive dimensions.
- Use `.sp` for responsive font sizes.
- Use `.r` for radius values.
- Do not hardcode large fixed sizes when the UI should adapt across devices.
- Keep layouts flexible with `Expanded`, `Flexible`, `Wrap`, `LayoutBuilder`, and scroll views where needed.
- Test important screens on small and large devices.
- Use `core/extensions/adaptive_layout_extension.dart` for reusable width-based layout detection.
- Standard breakpoints are compact `< 600`, medium `>= 600 && < 840`, and expanded `>= 840`.
- Do not use device-name or platform checks to decide mobile/tablet layouts.

## Typography

- Use **DM Sans** from Google Fonts (`GoogleFonts.dmSans(...)`) as the project-wide font for all UI text.
- Use **Space Mono** from Google Fonts (`GoogleFonts.spaceMono(...)`) exclusively for the `'Scolair'` brand word wherever it appears.
- Never hardcode font family strings — always call `GoogleFonts.dmSans(...)` or `GoogleFonts.spaceMono(...)`.
- All font sizes must use `.sp` (from `flutter_screenutil_plus`) for responsive scaling.
- Define all reusable text styles in `core/theme/app_text_styles.dart` using DM Sans.
- Do not add a named style for Space Mono in `AppTextStyles` — apply it inline where `'Scolair'` appears.

## Theme and Dark Mode

- The app uses `ThemeMode.system` — it automatically follows the device setting. Do not add manual theme toggles unless explicitly requested.
- Never reference `AppColors.lightXxx` or `AppColors.darkXxx` directly inside widgets or screens.
- Use `Theme.of(context).colorScheme.xxx` for all colors (surface, outline, primary, onSurface, onSurfaceVariant, etc.).
- Use `Theme.of(context).textTheme.xxx` for all text styles (titleLarge, bodyMedium, bodySmall, etc.).
- Use `Theme.of(context).scaffoldBackgroundColor` for full-screen backgrounds; never set `Scaffold.backgroundColor` to a hardcoded `AppColors` constant.
- `AppColors.lightXxx` / `AppColors.darkXxx` may ONLY appear inside `core/theme/app_colors.dart` and `core/theme/app_theme.dart`.
- `AppColors.primary`, `AppColors.darkTextPrimary` etc. (non-light/dark prefixed) may be used in widget files only when the semantic meaning is fixed regardless of brightness (e.g. white text on a blue primary button).
- The static getters `AppTextStyles.titleLarge`, `.body`, `.caption`, `.titleMedium` are removed — do not add them back. Use `Theme.of(context).textTheme` instead.
- InputDecoration in custom widgets must NOT override `fillColor` — omit it so it inherits from `inputDecorationTheme.fillColor` which is already brightness-aware.

## Assets

- Store all image, icon, and media assets inside `assets/` at the project root.
- Use one sub-folder per asset type: `assets/images/`, `assets/audio/`, etc.
- Declare every asset folder in `pubspec.yaml` under `flutter: assets:`.
- Never hardcode asset path strings directly in widgets or screens.
- Define every asset path as a `static const String` in `core/constants/app_assets.dart`.
- Reference assets in code only via `AppAssets.xxx` (e.g., `Image.asset(AppAssets.logoHeader)`).
- Keep `app_assets.dart` the single source of truth for all asset paths in the project.

## API And Data

- Use repositories to hide data source details from Cubits.
- Remote data sources call APIs.
- Local data sources call cache, preferences, secure storage, or local database code.
- Keep API response parsing inside models or data layer helpers.
- Convert data models to domain entities before exposing them to presentation when useful.
- Use Dio for HTTP client configuration.
- Use Retrofit for API declarations and generated API client code.
- For Frappe list filters, build a Dart filter map, encode it with `jsonEncode`, and pass it as a query parameter; do not concatenate filter JSON into URLs manually.
- Keep Retrofit annotations inside API service files, not inside Cubits or widgets.
- Keep base URL, headers, timeouts, and interceptors inside `core/network/`.
- Never expose raw Dio, Retrofit, HTTP, or storage calls directly to UI code.
- Regenerate Retrofit and Freezed files after changing API services, models, or states.

## Dependency Injection

- Keep dependency setup inside `core/di/`.
- Use `get_it` for dependency injection.
- Keep the main service locator setup in `core/di/dependency_injection.dart`.
- Register Dio, Retrofit API clients, storage wrappers, repositories, use cases, and Cubits there when needed.
- Prefer lazy singletons for long-lived services and factories for Cubits.
- Do not create dependencies directly in widgets unless the object is simple UI-only state.
- Keep DI names clear and predictable.
- Do not create multiple service locator instances.

## Package Rules

- Use only current, supported Flutter and Dart packages.
- Before adding a package, check that it is maintained and compatible with the project Flutter version.
- Prefer the latest stable package version.
- Do not use outdated, abandoned, deprecated, or unsupported packages.
- If the latest package version is not compatible, choose another supported package instead of using an old version.
- Do not add a new package when Flutter, Dart, or an existing project dependency already solves the problem well.
- Keep `pubspec.yaml` dependencies clean and remove unused packages.

## Screen File Size Rule

**Hard limit: no screen dart file may exceed 250 lines.**

To stay within this limit:
- Extract every repeated or sizeable chunk of UI into a private `_Widget` class at the bottom of the same file, or into a named file in `presentation/widgets/` if used by more than one screen.
- Keep the `build` method of `_XxxView` under ~30 lines by delegating to extracted widgets.
- Shared elements (logo header, form footer links, error banners) must be extracted into `presentation/widgets/` and reused across screens.
- Do not duplicate widget code between screen files.


## Cached Network Image

* Use `cached_network_image` for all remote/network images across the app.
* Do not use `Image.network` directly inside screens or feature widgets.
* Create one shared custom image widget inside:

```text
lib/core/widgets/
```

* The shared widget should be reused across all app features and branches: `student`, `parent`, and `teacher`.
* Suggested file name:

```text
lib/core/widgets/app_cached_network_image.dart
```

* Suggested widget name:

```dart
AppCachedNetworkImage
```

* This widget should handle common image states:

  * loading
  * error
  * empty/null image URL
  * border radius
  * fit
  * width and height
  * placeholder behavior
* Screens and feature widgets must call `AppCachedNetworkImage` instead of using `CachedNetworkImage` directly, unless there is a clear reason and it is documented.
* Keep the widget generic and reusable. Do not add feature-specific styling or business logic inside it.

## Shimmer And Skeleton Loading

* Use `skeletonizer: ^2.1.3` for shimmer/skeleton loading UI.
* When data is fetched for the first time, show a skeleton shimmer instead of empty space or a basic loading spinner, especially for lists and cards.
* Shimmer widgets are feature-specific and must be created inside the feature presentation widgets folder:

```text
lib/features/feature_name/presentation/widgets/
```

* Do not place feature-specific shimmer widgets inside `core/widgets/`.
* Name shimmer files based on the list or UI section they represent.

Examples:

```text
courses_list_shimmer.dart
teachers_list_shimmer.dart
students_list_shimmer.dart
assignments_list_shimmer.dart
```

* Name shimmer widgets clearly using PascalCase.

Examples:

```dart
CoursesListShimmer
TeachersListShimmer
StudentsListShimmer
AssignmentsListShimmer
```

* When the user says: “add shimmer”, “add a shimmer”, “add skeleton loading”, or “add loading skeleton”, the agent must understand that this means:

  * use `skeletonizer: ^2.1.3`
  * create a feature-specific shimmer widget
  * place it inside the feature’s `presentation/widgets/`
  * name it after the related list or section
  * show it only during the first data loading state
* Cubits should still emit clear loading, success, empty, and error states.
* Screens should render the shimmer widget during the first loading state before real data is available.
* Do not show shimmer over already-loaded data unless the user explicitly asks for refresh-loading behavior.
* Keep shimmer widgets UI-only. They must not call APIs, Cubits, repositories, storage, or navigation.

## Error Logger

* Use `logger: ^2.7.0` for development error logging and terminal debugging.
* The logger is strictly for developer debugging inside the terminal.
* Do not use `print()`, `debugPrint()`, or raw console logs for errors, API issues, Cubit failures, or debugging output.
* Create a shared logger helper inside:

```text
lib/core/errors/
```

* Suggested file name:

```text
lib/core/errors/app_logger.dart
```

* Suggested class name:

```dart
AppLogger
```

* `AppLogger` should centralize all debug logs and expose clear methods such as:

```dart
AppLogger.debug(message);
AppLogger.info(message);
AppLogger.warning(message);
AppLogger.error(message, error, stackTrace);
```

* All logged messages must include full technical details for developers, including:

  * full error message
  * stack trace
  * API response data (when safe)
  * request details (when needed)

* Logger output must be detailed and complete for debugging purposes inside the terminal.

* These detailed messages must **never** be shown to the user.

* `AppLogger` must be disabled by default for production/release builds.

* There must be a clear trigger in `main.dart` to enable or disable development logging.

* The trigger should control whether logs appear in the terminal during development.

* Suggested pattern:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.configure(
    enabled: true, // development only
  );

  runApp(const App());
}
```

* When preparing production or release builds, logging must be disabled:

```dart
AppLogger.configure(
  enabled: false,
);
```

* Do not expose sensitive data in logs, including:

  * tokens
  * passwords
  * authorization headers
  * personal user data
  * private API response data (unless sanitized)

* `ErrorHandler` may use `AppLogger` internally to log full technical details, but it must return clean and user-friendly `Failure` objects to repositories and Cubits.

* Repositories, Cubits, and widgets must not create their own `Logger()` instances directly.

* All logger usage must go through `AppLogger`.

* User-facing errors must always be simplified and shown using:

```dart
AppSnackBar.showError(context, message);
```

* The message shown to the user must be clean, readable, and safe.

* The detailed developer message must remain only in the terminal logs.

* Logger messages are for developers only and must never replace proper UI error handling.



## Branch Rules

- `student`, `parent`, and `teacher` branches should share these base rules.
- Build and review the rule file in one branch first.
- After the rule file is approved, add the same `.agent/project-rules.md` file to the other branches.
- Keep branch-specific changes inside app code, not inside this shared rules file, unless a real branch rule is needed.
- If a branch needs a special rule, add a small section named after that branch.
- Keep shared architecture the same across all branches.

## Before Commit

- Run `dart format .` when Flutter files exist.
- Run `flutter analyze` before pushing meaningful code changes.
- Run code generation after changing Freezed or Retrofit files.
- Check package versions before adding or updating dependencies.
- Test the changed flow manually.
- Keep each commit focused on one clear change.
- Check that new files are in the correct folder.
- Check that large widgets were split before committing.
- Update the related spec and `.agent/project-memory.md` when the work changes project state.
