import 'package:json_annotation/json_annotation.dart';

import '../../../../core/network/paginated_list.dart';

part 'quiz_question_type.dart';
part 'question_model.dart';
part 'quiz_question_model.dart';
part 'quiz_summary_model.dart';
part 'quiz_model.dart';
part 'quiz_response_data.dart';
part 'quiz_models.g.dart';

// --- Safe JSON converters ---

Map<String, dynamic> _asStringMap(Object? json) {
  if (json is Map) {
    return json.map((key, value) => MapEntry(key.toString(), value));
  }
  return <String, dynamic>{};
}

String _stringFromJson(Object? value) => value?.toString() ?? '';

String? _nullableStringFromJson(Object? value) {
  if (value == null) return null;
  return value.toString();
}

int _intFromJson(Object? value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is bool) return value ? 1 : 0;
  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return 0;
    return int.tryParse(trimmed) ?? double.tryParse(trimmed)?.toInt() ?? 0;
  }
  return 0;
}

// --- Model-specific converters ---

QuestionModel _questionFromJson(Object? json) =>
    QuestionModel.fromJson(_asStringMap(json));

QuizModel _quizFromJson(Object? json) => QuizModel.fromJson(_asStringMap(json));

List<QuizQuestionModel> _quizQuestionsFromJson(Object? json) {
  if (json is! List) return <QuizQuestionModel>[];
  return json
      .whereType<Map>()
      .map((item) => QuizQuestionModel.fromJson(_asStringMap(item)))
      .toList();
}

PaginatedList<QuestionModel> _paginatedQuestionsFromJson(Object? json) =>
    PaginatedList.fromJson(json, _questionFromJson);

Map<String, dynamic> _paginatedQuestionsToJson(
  PaginatedList<QuestionModel> data,
) => {
  'items': data.items.map((e) => e.toJson()).toList(),
  'total': data.total,
  'start': data.start,
  'page_size': data.pageSize,
  'has_next_page': data.hasNextPage,
};

//----- Model-specific Quize converters ---

PaginatedList<QuizSummaryModel> _paginatedQuizzesFromJson(Object? json) =>
    PaginatedList.fromJson(json, _quizessFromJson);

Map<String, dynamic> _paginatedQuizzesToJson(
  PaginatedList<QuizSummaryModel> data,
) => {
  'items': data.items.map((e) => e.toJson()).toList(),
  'total': data.total,
  'start': data.start,
  'page_size': data.pageSize,
  'has_next_page': data.hasNextPage,
};

QuizSummaryModel _quizessFromJson(Object? json) =>
    QuizSummaryModel.fromJson(_asStringMap(json));
