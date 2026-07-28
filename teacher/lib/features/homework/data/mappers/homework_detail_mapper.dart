import '../../../../core/utils/app_date_time_formatter.dart';
import '../../domain/entities/homework_detail.dart';
import '../models/homework_detail_models.dart';

extension HomeworkDetailMapper on HomeworkDetailData {
  HomeworkDetail toDomain() => HomeworkDetail(
    name: name,
    title: title,
    instructions: instructions,
    course: course,
    attachment: attachment,
    lesson: lesson,
    batch: batch,
    dueDate: AppDateTimeFormatter.tryParseApiDateTime(dueDate),
    rawDueDate: dueDate,
    maxMarks: maxMarks,
    allowLateSubmission: allowLateSubmission == 1,
    isPublished: published == 1,
    owner: owner,
    questions: questions.map((q) => q.toDomain()).toList(growable: false),
  );
}

extension HomeworkQuestionItemMapper on HomeworkQuestionItemData {
  HomeworkQuestionItem toDomain() => HomeworkQuestionItem(
    name: name,
    question: question,
    type: type,
    marks: marks,
    multiple: multiple == 1,
    attachment: attachment,
    options: [
      if (option1 != null && option1!.isNotEmpty) option1!,
      if (option2 != null && option2!.isNotEmpty) option2!,
      if (option3 != null && option3!.isNotEmpty) option3!,
      if (option4 != null && option4!.isNotEmpty) option4!,
    ],
    correctOptions: [
      isCorrect1 == 1,
      isCorrect2 == 1,
      isCorrect3 == 1,
      isCorrect4 == 1,
    ],
    explanations: [
      explanation1,
      explanation2,
      explanation3,
      explanation4,
    ],
  );
}
