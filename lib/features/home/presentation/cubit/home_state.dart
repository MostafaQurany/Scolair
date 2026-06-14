import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/home_summary.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    HomeSummary? summary,
    String? errorMessage,
  }) = _HomeState;
}
