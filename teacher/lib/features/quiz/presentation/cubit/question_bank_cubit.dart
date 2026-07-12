import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/quiz_models.dart';
import '../../domain/usecases/quiz_usecases.dart';
import 'question_bank_state.dart';

class QuestionBankCubit extends Cubit<QuestionBankState> {
  QuestionBankCubit(this._listQuestions)
    : super(const QuestionBankState.initial());

  final ListQuestionsUseCase _listQuestions;

  static const int _pageSize = 20;
  final List<QuestionModel> _allQuestions = [];
  bool _hasReachedMax = false;

  String _searchQuery = '';

  Future<void> fetchQuestions({bool refresh = false}) async {
    if (refresh) {
      _allQuestions.clear();
      _hasReachedMax = false;
    }

    if (_hasReachedMax) return;

    if (_allQuestions.isEmpty) {
      emit(const QuestionBankState.loading());
    }

    final result = await _listQuestions(
      start: _allQuestions.length,
      pageSize: _pageSize,
    );

    result.when(
      success: (paginatedList) {
        _hasReachedMax = paginatedList.items.length < _pageSize;
        _allQuestions.addAll(paginatedList.items);
        _emitFiltered();
      },
      failure: (error) {
        emit(QuestionBankState.error(error.message));
      },
    );
  }

  void search(String query) {
    _searchQuery = query.toLowerCase();
    _emitFiltered();
  }

  void _emitFiltered() {
    if (_searchQuery.isEmpty) {
      emit(
        QuestionBankState.loaded(
          questions: _allQuestions,
          hasReachedMax: _hasReachedMax,
        ),
      );
    } else {
      final filtered = _allQuestions
          .where((q) => q.question.toLowerCase().contains(_searchQuery))
          .toList();
      emit(
        QuestionBankState.loaded(
          questions: filtered,
          hasReachedMax: _hasReachedMax,
        ),
      );
    }
  }
}
