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
