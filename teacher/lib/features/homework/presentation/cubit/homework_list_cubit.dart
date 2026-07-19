import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/list_homeworks_request_data.dart';
import '../../domain/usecases/homework_usecases.dart';
import 'homework_list_state.dart';

class HomeworkListCubit extends Cubit<HomeworkListState> {
  HomeworkListCubit(this._listHomeworkPageUseCase, this._deleteHomeworkUseCase)
    : super(const HomeworkListState());

  final ListHomeworkPageUseCase _listHomeworkPageUseCase;
  final DeleteHomeworkUseCase _deleteHomeworkUseCase;
  int _requestId = 0;

  Future<void> loadInitial() => _loadFirstPage(refresh: false);

  Future<void> refresh() => _loadFirstPage(refresh: true);

  Future<void> retry() => _loadFirstPage(refresh: false);

  Future<void> changeFilter(HomeworkPublishedFilter filter) async {
    if (filter == state.filter) return;
    emit(state.copyWith(filter: filter));
    await _loadFirstPage(refresh: false);
  }

  Future<void> _loadFirstPage({required bool refresh}) async {
    final requestId = ++_requestId;
    emit(
      state.copyWith(
        isInitialLoading: !refresh,
        isRefreshing: refresh,
        clearError: true,
        clearPaginationError: true,
      ),
    );
    final result = await _listHomeworkPageUseCase(
      start: 0,
      pageSize: state.pageSize,
      publishedFilter: state.filter,
    );
    if (requestId != _requestId) return;
    result.when(
      success: (page) => emit(
        state.copyWith(
          items: page.items,
          start: page.start,
          total: page.total,
          hasNextPage: page.hasNextPage,
          isInitialLoading: false,
          isRefreshing: false,
          clearError: true,
        ),
      ),
      failure: (failure) => emit(
        state.copyWith(
          isInitialLoading: false,
          isRefreshing: false,
          errorMessage: failure.message,
          errorSerial: state.errorSerial + 1,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isInitialLoading ||
        state.isRefreshing ||
        state.isLoadingMore ||
        !state.hasNextPage) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true, clearPaginationError: true));
    final result = await _listHomeworkPageUseCase(
      start: state.items.length,
      pageSize: state.pageSize,
      publishedFilter: state.filter,
    );
    result.when(
      success: (page) {
        final byName = {for (final item in state.items) item.name: item};
        for (final item in page.items) {
          byName[item.name] = item;
        }
        emit(
          state.copyWith(
            items: byName.values.toList(growable: false),
            start: page.start,
            total: page.total,
            hasNextPage: page.hasNextPage,
            isLoadingMore: false,
          ),
        );
      },
      failure: (failure) => emit(
        state.copyWith(
          isLoadingMore: false,
          paginationErrorMessage: failure.message,
          errorSerial: state.errorSerial + 1,
        ),
      ),
    );
  }

  Future<bool> deleteHomework(String homeworkName) async {
    if (state.deletingNames.contains(homeworkName)) return false;
    emit(
      state.copyWith(
        deletingNames: {...state.deletingNames, homeworkName},
        clearError: true,
      ),
    );
    final result = await _deleteHomeworkUseCase(homeworkName);
    return result.when(
      success: (_) {
        final updatedItems = state.items
            .where((item) => item.name != homeworkName)
            .toList(growable: false);
        emit(
          state.copyWith(
            items: updatedItems,
            total: state.total > 0 ? state.total - 1 : 0,
            deletingNames: {...state.deletingNames}..remove(homeworkName),
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            deletingNames: {...state.deletingNames}..remove(homeworkName),
            errorMessage: failure.message,
            errorSerial: state.errorSerial + 1,
          ),
        );
        return false;
      },
    );
  }
}
