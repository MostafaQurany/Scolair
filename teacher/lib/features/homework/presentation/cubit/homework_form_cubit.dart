import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/app_date_time_formatter.dart';
import '../../data/models/homework_mutation_models.dart';
import '../../domain/entities/homework_list_item.dart';
import '../../domain/usecases/homework_usecases.dart';
import 'homework_form_state.dart';

class HomeworkFormCubit extends Cubit<HomeworkFormState> {
  HomeworkFormCubit(this._createRemoteUseCase, this._updateRemoteUseCase)
      : super(const HomeworkFormState());

  final CreateHomeworkRemoteUseCase _createRemoteUseCase;
  final UpdateHomeworkRemoteUseCase _updateRemoteUseCase;

  void initForEdit(HomeworkListItem item) {
    emit(
      state.copyWith(
        editingHomeworkName: item.name,
        title: item.title,
        instructions: item.instructions,
        dueDate: item.dueDate,
        course: item.course,
        courseTitle: item.course,
        lesson: item.lesson,
        lessonTitle: item.lesson,
        batch: item.batch,
        allowLateSubmission: item.allowLateSubmission,
      ),
    );
  }

  void setTitle(String val) => emit(state.copyWith(title: val));

  void setDueDate(DateTime val) => emit(state.copyWith(dueDate: val));

  void setLesson(String? val) => emit(state.copyWith(lesson: val, clearBatch: true));

  void setBatch(String? val) => emit(state.copyWith(batch: val));

  void setCourseAndLesson({
    required String course,
    required String lesson,
    required String courseTitle,
    required String lessonTitle,
  }) => emit(
    state.copyWith(
      course: course,
      lesson: lesson,
      courseTitle: courseTitle,
      lessonTitle: lessonTitle,
      clearBatch: true,
    ),
  );

  void setInstructions(String val) => emit(state.copyWith(instructions: val));

  void setAllowLateSubmission(bool val) =>
      emit(state.copyWith(allowLateSubmission: val));

  Future<void> submitForm({required bool publish}) async {
    if (!state.isFormValid || state.dueDate == null) return;

    emit(state.copyWith(status: HomeworkFormStatus.submitting));

    final dueDateStr = AppDateTimeFormatter.formatForApi(state.dueDate!);
    if (state.isEditing) {
      final request = UpdateHomeworkRequestData(
        homeworkName: state.editingHomeworkName!,
        title: state.title.trim(),
        dueDate: dueDateStr,
        course: state.course,
        lesson: state.lesson,
        batch: state.batch,
        instructions: state.instructions.trim(),
        allowLateSubmission: state.allowLateSubmission ? 1 : 0,
        published: publish ? 1 : 0,
      );
      final result = await _updateRemoteUseCase(request);
      switch (result) {
        case ApiSuccess(data: final detail):
          emit(state.copyWith(
            status: HomeworkFormStatus.success,
            createdHomeworkName: detail.name,
          ));
        case ApiFailure(error: final error):
          emit(state.copyWith(status: HomeworkFormStatus.failure, errorMessage: error.message));
      }
    } else {
      final request = CreateHomeworkRequestData(
        title: state.title.trim(),
        dueDate: dueDateStr,
        course: state.course,
        lesson: state.lesson,
        batch: state.batch,
        instructions: state.instructions.trim(),
        allowLateSubmission: state.allowLateSubmission ? 1 : 0,
        published: publish ? 1 : 0,
      );
      final result = await _createRemoteUseCase(request);
      switch (result) {
        case ApiSuccess(data: final detail):
          emit(state.copyWith(
            status: HomeworkFormStatus.success,
            createdHomeworkName: detail.name,
          ));
        case ApiFailure(error: final error):
          emit(state.copyWith(status: HomeworkFormStatus.failure, errorMessage: error.message));
      }
    }
  }
}
