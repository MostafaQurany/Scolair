import '../../../../core/network/paginated_list.dart';
import '../../domain/entities/homework_submission.dart';
import '../models/homework_submission_models.dart';

extension SubmissionsPageMapper on SubmissionsPageData {
  PaginatedList<HomeworkSubmissionItem> toDomain() => PaginatedList(
    items: items.map((item) => item.toDomain()).toList(growable: false),
    total: total,
    start: start,
    pageSize: pageSize,
    hasNextPage: hasNextPage,
  );
}

extension SubmissionItemMapper on SubmissionItemData {
  HomeworkSubmissionItem toDomain() => HomeworkSubmissionItem(
    name: name,
    member: member,
    status: status,
    isLate: isLate == 1,
    autoMarks: autoMarks,
    marks: marks,
    feedback: feedback,
    submittedOn: submittedOn,
    studentName: studentName,
  );
}

extension SubmissionDetailMapper on SubmissionDetailData {
  HomeworkSubmissionDetail toDomain() => HomeworkSubmissionDetail(
    name: name,
    homework: homework,
    member: member,
    status: status,
    isLate: isLate == 1,
    autoMarks: autoMarks,
    marks: marks,
    feedback: feedback,
    submittedOn: submittedOn,
    studentName: studentName,
    questions: questions.map((q) => q.toDomain()).toList(growable: false),
  );
}

extension SubmissionQuestionMapper on SubmissionQuestionItemData {
  SubmissionQuestionDetail toDomain() => SubmissionQuestionDetail(
    question: question,
    questionText: questionText,
    type: type,
    maxMarks: maxMarks,
    answer: answer,
    isCorrect: isCorrect == null ? null : isCorrect == 1,
    marksAwarded: marksAwarded,
    note: note,
  );
}
