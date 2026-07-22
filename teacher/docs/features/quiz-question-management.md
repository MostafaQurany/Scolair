# Quiz Question Management — Full Technical Documentation

> **Scope**: Adding questions to a quiz, editing/updating existing questions, removing questions, and bulk operations.
> **Last updated**: 2026-07-21

---

## Table of Contents

1. [Architecture Overview](#1-architecture-overview)
2. [Directory Structure](#2-directory-structure)
3. [Data Layer](#3-data-layer)
   - [Models](#31-models)
   - [Response Data Wrappers](#32-response-data-wrappers)
   - [Remote DataSource](#33-remote-datasource)
   - [Repository Implementation](#34-repository-implementation)
   - [API Endpoints](#35-api-endpoints)
4. [Domain Layer](#4-domain-layer)
   - [Repository Contract](#41-repository-contract)
   - [Use Cases](#42-use-cases)
5. [Presentation Layer](#5-presentation-layer)
   - [Cubits & States](#51-cubits--states)
   - [Screens](#52-screens)
   - [Widgets](#53-widgets)
6. [User Flows](#6-user-flows)
   - [Flow A — Add a New Question Inline](#flow-a--add-a-new-question-inline)
   - [Flow B — Add from Question Bank](#flow-b--add-from-question-bank)
   - [Flow C — Edit an Existing Question](#flow-c--edit-an-existing-question)
   - [Flow D — Remove / Bulk Remove](#flow-d--remove--bulk-remove)
7. [Sequence Diagrams](#7-sequence-diagrams)
8. [JSON Payload Reference](#8-json-payload-reference)

---

## 1. Architecture Overview

The quiz feature follows a **layered architecture** with clear separation of concerns:

```
┌─────────────────────────────────────────────────────┐
│                  PRESENTATION                       │
│  Screens ←→ Cubits ←→ Widgets                       │
├─────────────────────────────────────────────────────┤
│                    DOMAIN                           │
│  Use Cases ←→ Repository Contract                   │
├─────────────────────────────────────────────────────┤
│                     DATA                            │
│  Repository Impl ←→ Remote DataSource ←→ ApiClient  │
│  Models + Response Wrappers                         │
└─────────────────────────────────────────────────────┘
```

**State management**: `flutter_bloc` (Cubit pattern)
**Serialization**: `json_serializable` with custom converters
**State classes**: `freezed`
**Network**: Retrofit-based `ApiClient`

---

## 2. Directory Structure

```
lib/features/quiz/
├── data/
│   ├── datasources/
│   │   └── remote/
│   │       └── quiz_remote_datasource.dart       # Abstract + impl
│   ├── models/
│   │   ├── quiz_models.dart                      # Barrel + converters
│   │   ├── quiz_question_type.dart               # ApiQuestionType enum  (part of quiz_models)
│   │   ├── question_model.dart                   # QuestionModel         (part of quiz_models)
│   │   ├── quiz_question_model.dart              # QuizQuestionModel     (part of quiz_models)
│   │   ├── quiz_model.dart                       # QuizModel             (part of quiz_models)
│   │   ├── quiz_summary_model.dart               # QuizSummaryModel      (part of quiz_models)
│   │   ├── quiz_response_data.dart               # All response wrappers (part of quiz_models)
│   │   └── quiz_models.g.dart                    # Generated code
│   └── repositories/
│       └── quiz_repository_impl.dart             # QuizRepositoryImpl
├── domain/
│   ├── repositories/
│   │   └── quiz_repository.dart                  # QuizRepository (abstract)
│   └── usecases/
│       └── quiz_usecases.dart                    # All use case classes
└── presentation/
    ├── cubit/
    │   ├── quiz_details_cubit.dart               # Main quiz detail logic
    │   ├── quiz_details_state.dart               # QuizDetailsState (freezed)
    │   ├── question_form_cubit.dart              # Standalone question create/update
    │   ├── question_form_state.dart              # QuestionFormState (freezed)
    │   ├── question_bank_cubit.dart              # Question bank list + search
    │   └── question_bank_state.dart              # QuestionBankState (freezed)
    ├── screens/
    │   ├── quiz_details_screen.dart              # Quiz detail page with question list
    │   ├── quiz_questions_slider_screen.dart     # PageView-based question editor
    │   ├── question_bank_screen.dart             # (in lib/features/question/) Pick from bank
    │   ├── question_form_screen.dart             # Standalone question form
    │   └── quiz_settings_screen.dart             # Quiz settings editor
    └── widgets/
        ├── question_form_body.dart               # Reusable question form with all fields
        ├── question_form_sections.dart           # QuestionTypeSelector, OptionTile, etc.
        ├── question_card.dart                    # Compact question card in list
        ├── question_type_badge.dart              # Type label pill
        ├── questions_tab_view.dart               # Sliver list of questions
        ├── quiz_state_widgets.dart               # Loading/empty/error states
        └── quiz_bottom_action_bar.dart           # Bottom action bar
```

Additionally, relevant files from the `question` feature:

```
lib/features/question/
└── presentation/
    ├── screens/
    │   └── question_bank_screen.dart             # Bank selection screen
    └── widgets/
        └── question_type_label.dart              # Extension: label() + isManualGraded
```

---

## 3. Data Layer

### 3.1 Models

#### `ApiQuestionType` — Enum

**File**: `lib/features/quiz/data/models/quiz_question_type.dart`
**Part of**: `quiz_models.dart`

```dart
enum ApiQuestionType {
  @JsonValue('Choices')
  choices,
  @JsonValue('User Input')
  userInput,
  @JsonValue('Open Ended')
  openEnded,
  @JsonValue('File Upload')
  fileUpload,
}
```

**Extension** (in `lib/features/question/presentation/widgets/question_type_label.dart`):

```dart
extension QuestionTypeLabel on ApiQuestionType {
  String label(BuildContext context) {
    return switch (this) {
      ApiQuestionType.choices    => context.l10n.questionTypeChoices,
      ApiQuestionType.userInput  => context.l10n.questionTypeUserInput,
      ApiQuestionType.openEnded  => context.l10n.questionTypeOpenEnded,
      ApiQuestionType.fileUpload => context.l10n.questionTypeFileUpload,
    };
  }

  bool get isManualGraded {
    return this == ApiQuestionType.openEnded ||
        this == ApiQuestionType.fileUpload;
  }
}
```

---

#### `QuestionModel` — Standalone Question from the Question Bank

**File**: `lib/features/quiz/data/models/question_model.dart`
**Part of**: `quiz_models.dart`

| Field | Type | JSON Key | Description |
|-------|------|----------|-------------|
| `name` | `String` | `name` | Unique question ID (e.g. `"Question-00001"`) |
| `question` | `String` | `question` | Question text |
| `type` | `ApiQuestionType` | `type` | Question type |
| `multiple` | `int` | `multiple` | `1` = allow multiple correct answers |
| `option1`–`option5` | `String?` | `option_1`–`option_5` | Choice text (up to 5) |
| `isCorrect1`–`isCorrect5` | `int` | `is_correct_1`–`is_correct_5` | `1` = correct, `0` = incorrect |
| `explanation1`–`explanation5` | `String?` | `explanation_1`–`explanation_5` | Explanation per choice |
| `possibility1`–`possibility5` | `String?` | `possibility_1`–`possibility_5` | User Input possible answers |

**Helper methods**:

```dart
/// Returns non-null options as (1-based-index, text) pairs.
List<(int, String)> get activeOptions;

/// Whether option at 1-based index is correct.
bool isCorrect(int index);

/// Explanation for option at 1-based index.
String? explanation(int index);

/// Non-null possibilities as a flat list.
List<String> get activePossibilities;

factory QuestionModel.fromJson(Map<String, dynamic> json);
Map<String, dynamic> toJson();
```

---

#### `QuizQuestionModel` — Question as Embedded in a Quiz

**File**: `lib/features/quiz/data/models/quiz_question_model.dart`
**Part of**: `quiz_models.dart`

This model represents a question **inside** a quiz's `questions` array. It is similar to `QuestionModel` but includes:

| Extra Field | Type | JSON Key | Description |
|-------------|------|----------|-------------|
| `questionDetail` | `String?` | `question_detail` | Longer text of the question |
| `marks` | `int` | `marks` | Points for this question in the quiz |

**Computed property**:

```dart
/// Prefer question_detail, fall back to question name.
String get displayText => questionDetail ?? question;
```

**Full fields** (same option/correct/explanation/possibility pattern as `QuestionModel`).

---

#### `QuizModel` — Full Quiz Document

**File**: `lib/features/quiz/data/models/quiz_model.dart`
**Part of**: `quiz_models.dart`

| Field | Type | JSON Key | Description |
|-------|------|----------|-------------|
| `name` | `String` | `name` | Quiz unique ID |
| `title` | `String` | `title` | Display title |
| `maxAttempts` | `int` | `max_attempts` | Max student attempts |
| `showAnswers` | `int` | `show_answers` | `1` = show answers after submission |
| `showSubmissionHistory` | `int` | `show_submission_history` | `1` = visible |
| `totalMarks` | `int` | `total_marks` | Calculated total marks |
| `passingPercentage` | `int` | `passing_percentage` | Minimum passing % |
| `duration` | `String?` | `duration` | Time limit (e.g. `"01:00:00"`) |
| `shuffleQuestions` | `int` | `shuffle_questions` | `1` = shuffle |
| `limitQuestionsTo` | `int` | `limit_questions_to` | `0` = all |
| `enableNegativeMarking` | `int` | `enable_negative_marking` | `1` = enabled |
| `marksToCut` | `int` | `marks_to_cut` | Marks deducted for wrong answer |
| `lesson` | `String?` | `lesson` | Linked lesson ID |
| `course` | `String?` | `course` | Linked course ID |
| `owner` | `String?` | `owner` | Creator email |
| `creation` | `String?` | `creation` | Created date |
| `modified` | `String?` | `modified` | Modified date |
| `questions` | `List<QuizQuestionModel>` | `questions` | Embedded question list |

**Key method**:

```dart
QuizModel copyWith({...}); // All fields optional
```

---

#### `QuizSummaryModel` — Lightweight Quiz for List Views

**File**: `lib/features/quiz/data/models/quiz_summary_model.dart`

Same as `QuizModel` but **without** the `questions` list. Used in `listQuizzes` pagination.

---

### 3.2 Response Data Wrappers

**File**: `lib/features/quiz/data/models/quiz_response_data.dart`
**Part of**: `quiz_models.dart`

Every API call returns a consistent wrapper with `state`, `message`, and `data`.

| Class | `data` Type | Used By |
|-------|-------------|---------|
| `ListQuestionsResponseData` | `PaginatedList<QuestionModel>` | `listQuestions` |
| `GetQuestionResponseData` | `QuestionModel` | `getQuestion` |
| `CreateQuestionResponseData` | `QuestionModel` | `createQuestion` |
| `UpdateQuestionResponseData` | `QuestionModel` | `updateQuestion` |
| `DeleteQuestionResponseData` | *(none)* | `deleteQuestion` |
| `ListQuizzesResponseData` | `PaginatedList<QuizSummaryModel>` | `listQuizzes` |
| `GetQuizResponseData` | `QuizModel` | `getQuiz` |
| `CreateQuizResponseData` | `QuizModel` | `createQuiz` |
| `UpdateQuizResponseData` | `QuizModel` | `updateQuiz` |
| `DeleteQuizResponseData` | *(none)* | `deleteQuiz` |
| **`AddQuestionToQuizResponseData`** | **`QuizModel`** | **`addQuestionToQuiz`** |
| **`RemoveQuestionFromQuizResponseData`** | **`QuizModel`** | **`removeQuestionFromQuiz`** |

---

### 3.3 Remote DataSource

**File**: `lib/features/quiz/data/datasources/remote/quiz_remote_datasource.dart`

#### Abstract Interface

```dart
abstract class QuizRemoteDataSource {
  // Questions
  Future<ListQuestionsResponseData> listQuestions({String? type, int start, int pageSize});
  Future<GetQuestionResponseData> getQuestion(String questionName);
  Future<CreateQuestionResponseData> createQuestion(Map<String, dynamic> body);
  Future<UpdateQuestionResponseData> updateQuestion(Map<String, dynamic> body);
  Future<DeleteQuestionResponseData> deleteQuestion(Map<String, dynamic> body);

  // Quizzes
  Future<ListQuizzesResponseData> listQuizzes({int start, int pageSize});
  Future<GetQuizResponseData> getQuiz(String quizName);
  Future<CreateQuizResponseData> createQuiz(Map<String, dynamic> body);
  Future<UpdateQuizResponseData> updateQuiz(Map<String, dynamic> body);
  Future<DeleteQuizResponseData> deleteQuiz(Map<String, dynamic> body);

  // Quiz-Question link
  Future<AddQuestionToQuizResponseData> addQuestionToQuiz(Map<String, dynamic> body);
  Future<RemoveQuestionFromQuizResponseData> removeQuestionFromQuiz(Map<String, dynamic> body);
}
```

#### Implementation

```dart
class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  const QuizRemoteDataSourceImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<AddQuestionToQuizResponseData> addQuestionToQuiz(
    Map<String, dynamic> body,
  ) => _apiClient.addQuestionToQuiz(body);

  @override
  Future<RemoveQuestionFromQuizResponseData> removeQuestionFromQuiz(
    Map<String, dynamic> body,
  ) => _apiClient.removeQuestionFromQuiz(body);

  // ... other methods delegate to _apiClient
}
```

---

### 3.4 Repository Implementation

**File**: `lib/features/quiz/data/repositories/quiz_repository_impl.dart`

```dart
class QuizRepositoryImpl implements QuizRepository {
  const QuizRepositoryImpl(this._remoteDataSource);
  final QuizRemoteDataSource _remoteDataSource;

  // Generic wrapper that catches errors
  Future<ApiResult<T>> _getResult<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return ApiSuccess(result);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<QuizModel>> addQuestionToQuiz({
    required String quiz,
    required String question,
    required int marks,
  }) => _getResult(
    () async => (await _remoteDataSource.addQuestionToQuiz({
      'quiz': quiz,
      'question': question,
      'marks': marks,
    })).data,
  );

  @override
  Future<ApiResult<QuizModel>> removeQuestionFromQuiz({
    required String quiz,
    required String question,
  }) => _getResult(
    () async => (await _remoteDataSource.removeQuestionFromQuiz({
      'quiz': quiz,
      'question': question,
    })).data,
  );

  // ... other methods (createQuestion, updateQuestion, etc.)
}
```

---

### 3.5 API Endpoints

**File**: `lib/core/network/api_endpoints.dart`

| Constant | Path | HTTP Method |
|----------|------|-------------|
| `createQuestion` | `/api/method/lms.question.controllers.create_question` | `POST` |
| `updateQuestion` | `/api/method/lms.question.controllers.update_question` | `PUT` |
| `deleteQuestion` | `/api/method/lms.question.controllers.delete_question` | `DELETE` |
| `listQuizzes` | `/api/method/lms.quiz.controllers.list_quizzes` | `GET` |
| `getQuiz` | `/api/method/lms.quiz.controllers.get_quiz` | `GET` |
| `createQuiz` | `/api/method/lms.quiz.controllers.create_quiz` | `POST` |
| `updateQuiz` | `/api/method/lms.quiz.controllers.update_quiz` | `PUT` |
| `deleteQuiz` | `/api/method/lms.quiz.controllers.delete_quiz` | `DELETE` |
| **`addQuestionToQuiz`** | **`/api/method/lms.quiz.controllers.add_question`** | **`POST`** |
| **`removeQuestionFromQuiz`** | **`/api/method/lms.quiz.controllers.remove_question`** | **`DELETE`** |

**Retrofit ApiClient declarations** (`lib/core/network/api_client.dart`):

```dart
@POST(ApiEndpoints.addQuestionToQuiz)
Future<AddQuestionToQuizResponseData> addQuestionToQuiz(
  @Body() Map<String, dynamic> body,
);

@DELETE(ApiEndpoints.removeQuestionFromQuiz)
Future<RemoveQuestionFromQuizResponseData> removeQuestionFromQuiz(
  @Body() Map<String, dynamic> body,
);

@PUT(ApiEndpoints.updateQuiz)
Future<UpdateQuizResponseData> updateQuiz(
  @Body() Map<String, dynamic> body,
);
```

---

## 4. Domain Layer

### 4.1 Repository Contract

**File**: `lib/features/quiz/domain/repositories/quiz_repository.dart`

```dart
abstract class QuizRepository {
  // Questions
  Future<ApiResult<PaginatedList<QuestionModel>>> listQuestions({
    String? type, int start = 0, int pageSize = 30,
  });
  Future<ApiResult<QuestionModel>> getQuestion(String questionName);
  Future<ApiResult<QuestionModel>> createQuestion(Map<String, dynamic> body);
  Future<ApiResult<QuestionModel>> updateQuestion(Map<String, dynamic> body);
  Future<ApiResult<void>> deleteQuestion(String questionName);

  // Quizzes
  Future<ApiResult<PaginatedList<QuizSummaryModel>>> listQuizzes({
    int start = 0, int pageSize = 30,
  });
  Future<ApiResult<QuizModel>> getQuiz(String quizName);
  Future<ApiResult<QuizModel>> createQuiz(Map<String, dynamic> body);
  Future<ApiResult<QuizModel>> updateQuiz(Map<String, dynamic> body);
  Future<ApiResult<void>> deleteQuiz(String quizName);

  // Quiz-Question link
  Future<ApiResult<QuizModel>> addQuestionToQuiz({
    required String quiz,
    required String question,
    required int marks,
  });
  Future<ApiResult<QuizModel>> removeQuestionFromQuiz({
    required String quiz,
    required String question,
  });
}
```

---

### 4.2 Use Cases

**File**: `lib/features/quiz/domain/usecases/quiz_usecases.dart`

#### Question Use Cases

| Class | Method Signature | Description |
|-------|-----------------|-------------|
| `ListQuestionsUseCase` | `call({String? type, int start, int pageSize})` → `ApiResult<PaginatedList<QuestionModel>>` | Paginated list for Question Bank |
| `GetQuestionUseCase` | `call(String questionName)` → `ApiResult<QuestionModel>` | Fetch single question |
| `CreateQuestionUseCase` | `call(Map<String, dynamic> body)` → `ApiResult<QuestionModel>` | Create a new standalone question |
| `UpdateQuestionUseCase` | `call(Map<String, dynamic> body)` → `ApiResult<QuestionModel>` | Update an existing question |
| `DeleteQuestionUseCase` | `call(String questionName)` → `ApiResult<void>` | Delete a question |

#### Quiz Use Cases

| Class | Method Signature | Description |
|-------|-----------------|-------------|
| `ListQuizzesUseCase` | `call({int start, int pageSize})` → `ApiResult<PaginatedList<QuizSummaryModel>>` | List quizzes |
| `GetQuizUseCase` | `call(String quizName)` → `ApiResult<QuizModel>` | Get full quiz with questions |
| `CreateQuizUseCase` | `call(Map<String, dynamic> body)` → `ApiResult<QuizModel>` | Create a new quiz |
| `UpdateQuizUseCase` | `call(Map<String, dynamic> body)` → `ApiResult<QuizModel>` | Update quiz settings + questions |
| `DeleteQuizUseCase` | `call(String quizName)` → `ApiResult<void>` | Delete a quiz |

#### Quiz-Question Link Use Cases

| Class | Method Signature | Description |
|-------|-----------------|-------------|
| **`AddQuestionToQuizUseCase`** | `call({required String quiz, required String question, required int marks})` → `ApiResult<QuizModel>` | **Link a question to a quiz** |
| **`RemoveQuestionFromQuizUseCase`** | `call({required String quiz, required String question})` → `ApiResult<QuizModel>` | **Unlink a question from a quiz** |

**Implementation pattern** (all use cases follow this):

```dart
class AddQuestionToQuizUseCase {
  const AddQuestionToQuizUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<QuizModel>> call({
    required String quiz,
    required String question,
    required int marks,
  }) => _repository.addQuestionToQuiz(
    quiz: quiz,
    question: question,
    marks: marks,
  );
}
```

---

## 5. Presentation Layer

### 5.1 Cubits & States

#### `QuizDetailsCubit` — Primary Controller

**File**: `lib/features/quiz/presentation/cubit/quiz_details_cubit.dart`

**Constructor dependencies**:

```dart
QuizDetailsCubit(
  this._getQuizUseCase,         // GetQuizUseCase
  this._updateQuizUseCase,      // UpdateQuizUseCase
  this._addQuestionToQuizUseCase,     // AddQuestionToQuizUseCase
  this._removeQuestionFromQuizUseCase, // RemoveQuestionFromQuizUseCase
)
```

**Methods**:

| Method | Signature | Description |
|--------|-----------|-------------|
| `loadQuiz` | `Future<void> loadQuiz(String quizName)` | Fetches quiz from API. Sets `isLoading`, then emits `quiz` or `errorMessage`. |
| **`addQuestion`** | **`Future<void> addQuestion({required String questionName, required int marks})`** | **Calls `addQuestionToQuiz` use case. Sets `isUpdating` while in progress. Emits updated `quiz` on success or `mutationError` on failure.** |
| **`removeQuestion`** | **`Future<void> removeQuestion(String questionName)`** | **Calls `removeQuestionFromQuiz` use case. Same pattern as addQuestion.** |
| **`bulkRemoveQuestions`** | **`Future<void> bulkRemoveQuestions(List<String> questionNames)`** | **Optimistically removes questions from UI, then sequentially calls remove API. On error, reloads quiz from server.** |
| **`updateSettings`** | **`Future<void> updateSettings(Map<String, dynamic> settings)`** | **Calls `updateQuiz` with quiz name/title + settings map. Used by the slider screen to save all questions at once via the `questions` key.** |

**`addQuestion` full implementation**:

```dart
Future<void> addQuestion({
  required String questionName,
  required int marks,
}) async {
  final quiz = state.quiz;
  if (quiz == null) return;
  emit(state.copyWith(isUpdating: true, mutationError: null));
  final result = await _addQuestionToQuizUseCase(
    quiz: quiz.name,
    question: questionName,
    marks: marks,
  );
  result.when(
    success: (updated) => emit(
      state.copyWith(isUpdating: false, quiz: updated, mutationError: null),
    ),
    failure: (failure) => emit(
      state.copyWith(isUpdating: false, mutationError: failure.message),
    ),
  );
}
```

**`updateSettings` full implementation** (used for batch question save):

```dart
Future<void> updateSettings(Map<String, dynamic> settings) async {
  final quiz = state.quiz;
  if (quiz == null) return;
  final body = {'quiz': quiz.name, 'title': quiz.title, ...settings};
  emit(state.copyWith(isUpdating: true, errorMessage: null, mutationError: null));
  final result = await _updateQuizUseCase(body);
  result.when(
    success: (updated) => emit(
      state.copyWith(isUpdating: false, quiz: updated, mutationError: null),
    ),
    failure: (failure) => emit(
      state.copyWith(isUpdating: false, mutationError: failure.message),
    ),
  );
}
```

---

#### `QuizDetailsState`

**File**: `lib/features/quiz/presentation/cubit/quiz_details_state.dart`

```dart
@freezed
abstract class QuizDetailsState with _$QuizDetailsState {
  const factory QuizDetailsState({
    @Default(true) bool isLoading,      // Initial load in progress
    @Default(false) bool isUpdating,    // Mutation (add/remove/update) in progress
    QuizModel? quiz,                     // Loaded quiz data
    String? errorMessage,                // Fatal load error
    String? mutationError,               // Non-fatal mutation error
  }) = _QuizDetailsState;
}
```

---

#### `QuestionFormCubit` — Standalone Create/Update

**File**: `lib/features/quiz/presentation/cubit/question_form_cubit.dart`

```dart
class QuestionFormCubit extends Cubit<QuestionFormState> {
  QuestionFormCubit(this._createQuestionUseCase, this._updateQuestionUseCase)
    : super(const QuestionFormState.initial());

  final CreateQuestionUseCase _createQuestionUseCase;
  final UpdateQuestionUseCase _updateQuestionUseCase;

  Future<void> createQuestion(Map<String, dynamic> body) async {
    emit(const QuestionFormState.submitting());
    final result = await _createQuestionUseCase(body);
    result.when(
      success: (question) => emit(QuestionFormState.success(question)),
      failure: (failure) => emit(QuestionFormState.error(failure.message)),
    );
  }

  Future<void> updateQuestion(Map<String, dynamic> body) async {
    emit(const QuestionFormState.submitting());
    final result = await _updateQuestionUseCase(body);
    result.when(
      success: (question) => emit(QuestionFormState.success(question)),
      failure: (failure) => emit(QuestionFormState.error(failure.message)),
    );
  }
}
```

#### `QuestionFormState`

```dart
@freezed
abstract class QuestionFormState with _$QuestionFormState {
  const factory QuestionFormState.initial() = _Initial;
  const factory QuestionFormState.submitting() = _Submitting;
  const factory QuestionFormState.success(QuestionModel question) = _Success;
  const factory QuestionFormState.error(String message) = _Error;
}
```

---

#### `QuestionBankCubit` — Question Bank List

**File**: `lib/features/quiz/presentation/cubit/question_bank_cubit.dart`

```dart
class QuestionBankCubit extends Cubit<QuestionBankState> {
  QuestionBankCubit(this._listQuestions)
    : super(const QuestionBankState.initial());

  final ListQuestionsUseCase _listQuestions;
  static const int _pageSize = 20;
  final List<QuestionModel> _allQuestions = [];
  bool _hasReachedMax = false;
  String _searchQuery = '';

  Future<void> fetchQuestions({bool refresh = false}) async { ... }
  void search(String query) { ... }
  void _emitFiltered() { ... }
}
```

#### `QuestionBankState`

```dart
@freezed
class QuestionBankState with _$QuestionBankState {
  const factory QuestionBankState.initial() = _Initial;
  const factory QuestionBankState.loading() = _Loading;
  const factory QuestionBankState.loaded({
    required List<QuestionModel> questions,
    required bool hasReachedMax,
  }) = _Loaded;
  const factory QuestionBankState.error(String message) = _Error;
}
```

---

### 5.2 Screens

#### `QuizDetailsScreen` — Quiz Detail Page

**File**: `lib/features/quiz/presentation/screens/quiz_details_screen.dart`

**Purpose**: Displays a single quiz with its question list. Entry point for adding/editing/removing questions.

**Key widgets**:
- `_QuizDetailsBody` — `StatefulWidget` managing selection mode
- `_QuizFab` — FAB for adding new questions

**Navigation functions**:

```dart
/// Opens the slider screen at the last position (new question)
void _addQuestion(BuildContext context, QuizModel quiz) {
  final cubit = context.read<QuizDetailsCubit>();
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: QuizQuestionsSliderScreen(
          quiz: quiz,
          initialIndex: quiz.questions.length, // <-- past the last existing
        ),
      ),
    ),
  );
}
```

**Selection mode** (for bulk operations):

```dart
bool _isSelectionMode = false;
final Set<String> _selectedQuestions = {};

void _toggleSelectionMode() { ... }
void _toggleQuestionSelection(String questionName) { ... }

Future<void> _deleteSelected(BuildContext context, QuizModel quiz) async {
  // Shows confirmation dialog
  // Calls cubit.bulkRemoveQuestions(toDelete)
}
```

---

#### `QuizQuestionsSliderScreen` — PageView Question Editor

**File**: `lib/features/quiz/presentation/screens/quiz_questions_slider_screen.dart`

**Purpose**: A horizontal PageView where each page is a question form. Supports inline creation, bank import, editing, and batch saving.

**Constructor**:

```dart
const QuizQuestionsSliderScreen({
  required this.quiz,        // QuizModel — full quiz with existing questions
  required this.initialIndex, // int — page to open (existing index or length for new)
})
```

**Internal draft model**:

```dart
class _DraftQuestion {
  final String? existingQuestionId;  // Non-null for existing questions
  final QuizQuestionModel? originalData; // Data from the loaded quiz
  final QuestionModel? bankData;     // Data from the question bank
  Map<String, dynamic>? inlineData;  // Form data captured locally
  int marks;                         // Points assigned

  Map<String, dynamic> toPayload() {
    if (inlineData != null) {
      return {'inline': inlineData, 'marks': marks};
    } else if (existingQuestionId != null) {
      return {'question': existingQuestionId, 'marks': marks};
    }
    return {};
  }
}
```

**Key methods**:

| Method | Description |
|--------|-------------|
| `_initDrafts()` | Converts `quiz.questions` into `_DraftQuestion` list. Adds empty draft if no questions exist. |
| `_goToBank()` | Navigates to `QuestionBankScreen`. On return, adds selected `QuestionModel`s as drafts with `bankData` set. |
| `_saveCurrentQuestionLocally()` | Reads form data from `QuestionFormBody` via `GlobalKey` and stores in the draft's `inlineData`. Returns `false` if validation fails. |
| `_onNext()` | Save current → animate to next page. |
| `_onAddNew()` | Save current → add new empty draft → animate to it. |
| **`_onDone()`** | **Save current → build payload list → call `cubit.updateSettings({'questions': payload})` → show success snackbar → pop.** |
| `_removeCurrentQuestion()` | Remove current draft from the list and update the PageView. |
| `_buildInitialQuestion(int index)` | Converts a `_DraftQuestion` back to a `QuestionModel` for pre-filling the form. Priority: `inlineData` → `bankData` → `originalData`. |
| `_blockedBankTypes()` | Returns types blocked from bank selection (can't mix auto-graded and manual-graded). |

**`_onDone()` full implementation — this is the main save path**:

```dart
void _onDone() {
  _saveCurrentQuestionLocally();

  final payload = _drafts.map((d) => d.toPayload()).toList();
  payload.removeWhere((element) => element.isEmpty);
  context.read<QuizDetailsCubit>().updateSettings({'questions': payload});

  if (mounted) {
    AppSnackBar.showSuccess(context, context.l10n.quizSavedSuccess);
    Navigator.pop(context);
  }
}
```

---

#### `QuestionBankScreen` — Pick from Bank

**File**: `lib/features/question/presentation/screens/question_bank_screen.dart`

**Constructor**:

```dart
const QuestionBankScreen({
  this.blockedTypes = const {},  // Types to grey out
  this.confirmLabel,              // Custom button text
})
```

**Flow**:
1. Loads questions via `QuestionBankCubit`
2. User selects questions via checkboxes
3. On confirm → `Navigator.pop(context, selectedQuestions.values.toList())`
4. Returns `List<QuestionModel>` to the calling slider screen

---

### 5.3 Widgets

#### `QuestionFormBody` — Reusable Form Widget

**File**: `lib/features/quiz/presentation/widgets/question_form_body.dart`

**Purpose**: Full question editor form with all fields. Exposed via `GlobalKey<QuestionFormBodyState>` for external data extraction.

**Constructor**:

```dart
const QuestionFormBody({
  this.initialQuestion,  // QuestionModel? — pre-fill for editing
  this.initialMarks = 1, // int — default marks
})
```

**State fields** (17 TextEditingControllers + type + correct options):

```dart
TextEditingController _questionController;
TextEditingController _option1Controller .. _option5Controller;
TextEditingController _explanation1Controller .. _explanation5Controller;
TextEditingController _possibility1Controller .. _possibility5Controller;
TextEditingController _marksController;
ApiQuestionType _type = ApiQuestionType.choices;
bool _multiple = false;
List<int> _correctOptions = [1];
```

**Public methods** (called from slider screen via GlobalKey):

```dart
/// Validates form and returns the question data as a Map.
/// Returns null if validation fails.
Map<String, dynamic>? getFormData() {
  if (!_formKey.currentState!.validate()) return null;

  final body = <String, dynamic>{
    'question': _questionController.text.trim(),
    'type': switch (_type) {
      ApiQuestionType.choices   => 'Choices',
      ApiQuestionType.userInput => 'User Input',
      ApiQuestionType.openEnded => 'Open Ended',
      ApiQuestionType.fileUpload => 'File Upload',
    },
  };

  if (isEditing) {
    body['question'] = widget.initialQuestion!.name;
  }

  if (_type == ApiQuestionType.choices) {
    // Adds option_1..5, is_correct_1..5, explanation_1..5, multiple
  } else if (_type == ApiQuestionType.userInput) {
    // Adds possibility_1..5
  }
  return body;
}

/// Returns the marks value from the marks field.
int getMarks() {
  return int.tryParse(_marksController.text.trim()) ?? 1;
}
```

**UI sections** (conditionally shown based on `_type`):
- **Always**: Question type selector + marks field + question text input
- **Choices**: Multiple toggle switch + 5 `OptionTile` widgets
- **User Input**: `UserInputSection` with 5 possibility fields
- **Open Ended**: `OpenEndedHint` info box
- **File Upload**: `FileUploadHint` info box

---

#### `QuestionFormSections` — Sub-widgets

**File**: `lib/features/quiz/presentation/widgets/question_form_sections.dart`

| Widget | Purpose |
|--------|---------|
| `QuestionTypeSelector` | Horizontal type pills (Choices / User Input / Open Ended / File Upload) |
| `ChoicesSection` | Switch for multiple + 5 `OptionTile` widgets |
| `OptionTile` | Single choice option with: correct toggle icon, text field, explanation field |
| `UserInputSection` | 5 `_PossibilityField` widgets for User Input type |
| `_PossibilityField` | Numbered text field for a possible answer |
| `OpenEndedHint` | Info message for open-ended type |
| `FileUploadHint` | Info message for file upload type |

---

#### `QuestionsTabView` — Question List in Quiz Details

**File**: `lib/features/quiz/presentation/widgets/questions_tab_view.dart`

```dart
class QuestionsTabView extends StatelessWidget {
  const QuestionsTabView({
    required this.quiz,
    this.onDeleteQuestion,
    required this.onAddQuestion,
    this.isSelectionMode = false,
    this.selectedQuestions = const {},
    this.onToggleSelection,
  });
}
```

**Behavior**:
- If `quiz.questions.isEmpty` → shows `QuizEmptyState` with add button
- Otherwise → shows `SliverList` of `QuestionCard` widgets
- Each card can be tapped to open the slider at that index
- Extra bottom spacer for FAB clearance

**Navigation to slider on tap**:

```dart
void _navigateToSlider(BuildContext context, int index) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: context.read<QuizDetailsCubit>(),
        child: QuizQuestionsSliderScreen(quiz: quiz, initialIndex: index),
      ),
    ),
  );
}
```

---

#### `QuestionCard` — Compact Question Card

**File**: `lib/features/quiz/presentation/widgets/question_card.dart`

Displays: question number, type badge, marks badge, question preview text, choices count, and delete/select actions. Theme-aware (supports dark/light mode).

---

## 6. User Flows

### Flow A — Add a New Question Inline

```
QuizDetailsScreen
 │  User taps FAB (+) or "Add Question" button
 ▼
QuizQuestionsSliderScreen(quiz, initialIndex: quiz.questions.length)
 │  A new empty _DraftQuestion is created
 │  PageView shows QuestionFormBody(initialQuestion: null)
 │  User fills in: type, question text, options, marks
 │
 │  [User taps "Add New"] → saves current, adds another blank draft
 │  [User taps "Done"]
 ▼
_onDone()
 │  Calls _saveCurrentQuestionLocally()
 │  Builds payload: [{inline: {...}, marks: N}, ...]
 │  Calls context.read<QuizDetailsCubit>().updateSettings({'questions': payload})
 ▼
QuizDetailsCubit.updateSettings()
 │  Merges quiz name/title + {questions: payload}
 │  Calls UpdateQuizUseCase → QuizRepository.updateQuiz → API PUT
 ▼
API returns updated QuizModel → state.quiz updated → UI rebuilds
```

### Flow B — Add from Question Bank

```
QuizQuestionsSliderScreen (on last slide)
 │  User taps "Question Bank" button in AppBar
 ▼
QuestionBankScreen(blockedTypes: {...})
 │  Shows paginated question list from API
 │  User selects one or more questions via checkboxes
 │  User taps "Add to Quiz"
 ▼
Navigator.pop(context, List<QuestionModel>)
 │
 ▼  Back in QuizQuestionsSliderScreen._goToBank()
 │  For each selected question:
 │    _drafts.add(_DraftQuestion(
 │      existingQuestionId: q.name,
 │      bankData: q,
 │      marks: 1,
 │    ))
 │  Shows success snackbar
 │
 │  User reviews each question in the slider
 │  [User taps "Done"] → same as Flow A _onDone()
```

### Flow C — Edit an Existing Question

```
QuizDetailsScreen
 │  User taps on a QuestionCard
 ▼
QuestionsTabView._navigateToSlider(context, index)
 ▼
QuizQuestionsSliderScreen(quiz, initialIndex: index)
 │  _initDrafts() converts quiz.questions to _DraftQuestion list
 │  Each draft has: existingQuestionId, originalData, marks
 │  _buildInitialQuestion(index) → _questionFromOriginal()
 │    converts QuizQuestionModel → QuestionModel for form pre-fill
 │
 │  QuestionFormBody(initialQuestion: questionModel, initialMarks: marks)
 │  User edits fields
 │  [User taps "Done"]
 ▼
_onDone()
 │  Same as Flow A — all drafts serialized and sent via updateSettings
```

### Flow D — Remove / Bulk Remove

**Single remove** (from question card):

```
QuestionCard → onDelete callback
 ▼
QuizDetailsCubit.removeQuestion(questionName)
 │  API DELETE → returns updated QuizModel
 │  State updated → UI removes card
```

**Bulk remove** (selection mode):

```
QuizDetailsScreen
 │  User taps checklist icon → enters selection mode
 │  User selects multiple questions via checkboxes
 │  User taps delete icon
 ▼
_deleteSelected() → shows confirmation dialog
 ▼
QuizDetailsCubit.bulkRemoveQuestions(questionNames)
 │  STEP 1: Optimistic UI update — removes questions from state.quiz.questions
 │  STEP 2: Sequentially calls removeQuestionFromQuiz for each
 │  STEP 3: On any failure → shows error → reloads quiz from API
```

---

## 7. Sequence Diagrams

### Adding a Question (Inline)

```
User        SliderScreen     QuestionFormBody   QuizDetailsCubit   UpdateQuizUseCase    API
 │               │                 │                  │                  │                │
 │──tap Done────►│                 │                  │                  │                │
 │               │──getFormData()─►│                  │                  │                │
 │               │◄──Map<S,d>──── │                  │                  │                │
 │               │                 │                  │                  │                │
 │               │──updateSettings({questions:[...]})►│                  │                │
 │               │                 │                  │──call(body)─────►│                │
 │               │                 │                  │                  │──PUT /update──►│
 │               │                 │                  │                  │◄──QuizModel────│
 │               │                 │                  │◄──ApiSuccess─────│                │
 │               │                 │                  │──emit(quiz)      │                │
 │◄──pop + snack─│                 │                  │                  │                │
```

### Adding from Question Bank

```
User       SliderScreen     BankScreen    QuestionBankCubit    API
 │              │                │               │              │
 │──tap Bank───►│                │               │              │
 │              │──push(Bank)───►│               │              │
 │              │                │──loadInitial()►│              │
 │              │                │               │──GET list───►│
 │              │                │               │◄─questions───│
 │              │                │◄──loaded──────│              │
 │──select Qs──►│                │               │              │
 │──tap Add────►│                │               │              │
 │              │◄─pop(List<Q>)──│               │              │
 │              │──add to _drafts│               │              │
 │◄──snackbar───│                │               │              │
```

---

## 8. JSON Payload Reference

### Add Question to Quiz (direct API)

```json
POST /api/method/lms.quiz.controllers.add_question
{
  "quiz": "LMS-Quiz-00001",
  "question": "Question-00042",
  "marks": 5
}
```

**Response**: `AddQuestionToQuizResponseData` → `QuizModel`

---

### Remove Question from Quiz

```json
DELETE /api/method/lms.quiz.controllers.remove_question
{
  "quiz": "LMS-Quiz-00001",
  "question": "Question-00042"
}
```

**Response**: `RemoveQuestionFromQuizResponseData` → `QuizModel`

---

### Update Quiz (batch questions via slider "Done")

```json
PUT /api/method/lms.quiz.controllers.update_quiz
{
  "quiz": "LMS-Quiz-00001",
  "title": "Math Midterm",
  "questions": [
    {
      "question": "Question-00001",
      "marks": 5
    },
    {
      "inline": {
        "question": "What is 2+2?",
        "type": "Choices",
        "option_1": "3",
        "option_2": "4",
        "option_3": "5",
        "is_correct_1": 0,
        "is_correct_2": 1,
        "is_correct_3": 0,
        "explanation_2": "Basic addition"
      },
      "marks": 2
    }
  ]
}
```

**Response**: `UpdateQuizResponseData` → `QuizModel`

---

### Create Question (standalone)

```json
POST /api/method/lms.question.controllers.create_question
{
  "question": "What is the capital of France?",
  "type": "Choices",
  "option_1": "London",
  "option_2": "Paris",
  "option_3": "Berlin",
  "is_correct_1": 0,
  "is_correct_2": 1,
  "is_correct_3": 0,
  "explanation_2": "Paris is the capital of France",
  "multiple": 0
}
```

**Response**: `CreateQuestionResponseData` → `QuestionModel`

---

### Update Question (standalone)

```json
PUT /api/method/lms.question.controllers.update_question
{
  "question": "Question-00042",
  "type": "Choices",
  "option_1": "Updated option",
  ...
}
```

**Response**: `UpdateQuestionResponseData` → `QuestionModel`
