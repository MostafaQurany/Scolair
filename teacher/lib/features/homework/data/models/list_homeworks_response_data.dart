class ListHomeworksResponseData {
  const ListHomeworksResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory ListHomeworksResponseData.fromJson(Object? json) {
    final map = _map(json);
    return ListHomeworksResponseData(
      state: _string(map['state']),
      message: _string(map['message']),
      data: HomeworksPageResponseData.fromJson(map['data']),
    );
  }

  final String state;
  final String message;
  final HomeworksPageResponseData data;
}

class HomeworksPageResponseData {
  const HomeworksPageResponseData({
    required this.items,
    required this.total,
    required this.start,
    required this.pageSize,
    required this.hasNextPage,
  });

  factory HomeworksPageResponseData.fromJson(Object? json) {
    final map = _map(json);
    final rawItems = map['items'];
    return HomeworksPageResponseData(
      items: rawItems is List
          ? rawItems.map(HomeworkItemResponseData.fromJson).toList()
          : const [],
      total: _integer(map['total']),
      start: _integer(map['start']),
      pageSize: _integer(map['page_size']),
      hasNextPage: _boolean(map['has_next_page']),
    );
  }

  final List<HomeworkItemResponseData> items;
  final int total;
  final int start;
  final int pageSize;
  final bool hasNextPage;
}

class HomeworkItemResponseData {
  const HomeworkItemResponseData({
    required this.name,
    required this.title,
    required this.instructions,
    required this.course,
    required this.dueDate,
    required this.maxMarks,
    required this.allowLateSubmission,
    required this.published,
    this.attachment,
    this.lesson,
    this.batch,
  });

  factory HomeworkItemResponseData.fromJson(Object? json) {
    final map = _map(json);
    return HomeworkItemResponseData(
      name: _string(map['name']),
      title: _string(map['title']),
      instructions: _string(map['instructions']),
      attachment: _nullableString(map['attachment']),
      course: _string(map['course']),
      lesson: _nullableString(map['lesson']),
      batch: _nullableString(map['batch']),
      dueDate: _nullableString(map['due_date']),
      maxMarks: _integer(map['max_marks']),
      allowLateSubmission: _integer(map['allow_late_submission']),
      published: _integer(map['published']),
    );
  }

  final String name;
  final String title;
  final String instructions;
  final String? attachment;
  final String course;
  final String? lesson;
  final String? batch;
  final String? dueDate;
  final int maxMarks;
  final int allowLateSubmission;
  final int published;
}

Map<String, dynamic> _map(Object? value) => value is Map
    ? value.map((key, item) => MapEntry(key.toString(), item))
    : <String, dynamic>{};

String _string(Object? value) => value?.toString().trim() ?? '';

String? _nullableString(Object? value) {
  final parsed = _string(value);
  return parsed.isEmpty ? null : parsed;
}

int _integer(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(_string(value)) ?? 0;
}

bool _boolean(Object? value) {
  if (value is bool) return value;
  return _integer(value) == 1;
}
