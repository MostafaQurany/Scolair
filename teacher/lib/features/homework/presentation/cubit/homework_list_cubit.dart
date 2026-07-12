import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/homework_usecases.dart';
import 'homework_list_state.dart';

class HomeworkListCubit extends Cubit<HomeworkListState> {
  HomeworkListCubit(
    this._listHomeworkUseCase,
    this._deleteHomeworkUseCase,
    this._duplicateHomeworkUseCase,
  ) : super(const HomeworkListState());

  final ListHomeworkUseCase _listHomeworkUseCase;
  final DeleteHomeworkUseCase _deleteHomeworkUseCase;
  final DuplicateHomeworkUseCase _duplicateHomeworkUseCase;

  Future<void> loadHomework() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _listHomeworkUseCase();
    result.when(
      success: (homework) =>
          emit(state.copyWith(isLoading: false, homework: homework)),
      failure: (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
    );
  }

  Future<void> deleteHomework(String id) async {
    final result = await _deleteHomeworkUseCase(id);
    result.when(success: (_) => loadHomework(), failure: (_) {});
  }

  Future<void> duplicateHomework(String id) async {
    final result = await _duplicateHomeworkUseCase(id);
    result.when(success: (_) => loadHomework(), failure: (_) {});
  }
}
