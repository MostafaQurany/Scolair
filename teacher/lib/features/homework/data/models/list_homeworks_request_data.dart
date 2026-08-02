import 'dart:convert';

enum HomeworkPublishedFilter { all, published, drafts }

class ListHomeworksRequestData {
  const ListHomeworksRequestData({
    required this.start,
    required this.pageSize,
    this.publishedFilter = HomeworkPublishedFilter.all,
    this.course,
    this.chapter,
    this.lesson,
  });

  final int start;
  final int pageSize;
  final HomeworkPublishedFilter publishedFilter;
  final String? course;
  final String? chapter;
  final String? lesson;

  Map<String, dynamic> toJson() {
    final published = switch (publishedFilter) {
      HomeworkPublishedFilter.all => null,
      HomeworkPublishedFilter.published => 1,
      HomeworkPublishedFilter.drafts => 0,
    };
    return <String, dynamic>{
      'start': start,
      'page_size': pageSize,
      if (published != null) 'filters': jsonEncode({'published': published}),
      if (course != null && course!.isNotEmpty) 'course': course,
      if (chapter != null && chapter!.isNotEmpty) 'chapter': chapter,
      if (lesson != null && lesson!.isNotEmpty) 'lesson': lesson,
    };
  }
}
