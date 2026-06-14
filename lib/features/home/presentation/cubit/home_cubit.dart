import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_home_summary_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getHomeSummaryUseCase) : super(const HomeState());

  final GetHomeSummaryUseCase _getHomeSummaryUseCase;

  Future<void> loadSummary() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final summary = await _getHomeSummaryUseCase();
      emit(state.copyWith(isLoading: false, summary: summary));
    } on Object catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }
}
