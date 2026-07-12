Map<String, dynamic> _asStringMap(Object? json) {
  if (json is Map) {
    return json.map((key, value) => MapEntry(key.toString(), value));
  }
  return <String, dynamic>{};
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

/// Common shape for paginated list endpoints:
/// `{ "items": [...], "total": n, "start": n, "page_size": n, "has_next_page": bool }`.
class PaginatedList<T> {
  const PaginatedList({
    required this.items,
    required this.total,
    required this.start,
    required this.pageSize,
    required this.hasNextPage,
  });

  const PaginatedList.empty()
    : items = const [],
      total = 0,
      start = 0,
      pageSize = 0,
      hasNextPage = false;

  final List<T> items;
  final int total;
  final int start;
  final int pageSize;
  final bool hasNextPage;

  static PaginatedList<T> fromJson<T>(
    Object? json,
    T Function(Map<String, dynamic>) itemFromJson,
  ) {
    final map = _asStringMap(json);
    final itemsJson = map['items'];
    final items = itemsJson is List
        ? itemsJson
              .whereType<Map>()
              .map((e) => itemFromJson(_asStringMap(e)))
              .toList()
        : <T>[];
    return PaginatedList<T>(
      items: items,
      total: _intFromJson(map['total']),
      start: _intFromJson(map['start']),
      pageSize: _intFromJson(map['page_size']),
      hasNextPage: map['has_next_page'] == true,
    );
  }

  /// Merges an already-loaded page with the next page fetched via "load more",
  /// keeping the accumulated items but adopting the latest pagination cursor.
  PaginatedList<T> appendPage(PaginatedList<T> next) => PaginatedList<T>(
    items: [...items, ...next.items],
    total: next.total,
    start: next.start,
    pageSize: next.pageSize,
    hasNextPage: next.hasNextPage,
  );
}
