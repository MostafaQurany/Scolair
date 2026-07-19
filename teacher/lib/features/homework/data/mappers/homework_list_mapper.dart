import '../../../../core/network/paginated_list.dart';
import '../../../../core/utils/app_date_time_formatter.dart';
import '../../domain/entities/homework_list_item.dart';
import '../models/list_homeworks_response_data.dart';

extension HomeworksPageMapper on HomeworksPageResponseData {
  PaginatedList<HomeworkListItem> toDomain() => PaginatedList(
    items: items.map((item) => item.toDomain()).toList(growable: false),
    total: total,
    start: start,
    pageSize: pageSize,
    hasNextPage: hasNextPage,
  );
}

extension HomeworkItemMapper on HomeworkItemResponseData {
  HomeworkListItem toDomain() => HomeworkListItem(
    name: name,
    title: title,
    instructions: instructions,
    attachment: attachment,
    course: course,
    lesson: lesson,
    batch: batch,
    dueDate: AppDateTimeFormatter.tryParseApiDateTime(dueDate),
    rawDueDate: dueDate,
    maxMarks: maxMarks,
    allowLateSubmission: allowLateSubmission == 1,
    isPublished: published == 1,
  );
}
