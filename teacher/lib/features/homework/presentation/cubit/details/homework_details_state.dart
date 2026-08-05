import '../../../domain/entities/homework_detail.dart';

enum HomeworkDetailsStatus { initial, loading, success, failure, mutating }

class HomeworkDetailsState {
  const HomeworkDetailsState({
    this.status = HomeworkDetailsStatus.initial,
    this.homework,
    this.errorMessage,
    this.hasSubmissions = false,
    this.isEditMode = false,
    this.isBatchSaving = false,
    this.batchProgress = 0,
    this.batchTotal = 0,
    this.batchErrors = const [],
  });

  final HomeworkDetailsStatus status;
  final HomeworkDetail? homework;
  final String? errorMessage;
  final bool hasSubmissions;
  final bool isEditMode;
  final bool isBatchSaving;
  final int batchProgress;
  final int batchTotal;
  final List<String> batchErrors;

  HomeworkDetailsState copyWith({
    HomeworkDetailsStatus? status,
    HomeworkDetail? homework,
    String? errorMessage,
    bool? hasSubmissions,
    bool? isEditMode,
    bool? isBatchSaving,
    int? batchProgress,
    int? batchTotal,
    List<String>? batchErrors,
  }) => HomeworkDetailsState(
      status: status ?? this.status,
      homework: homework ?? this.homework,
      errorMessage: errorMessage ?? this.errorMessage,
      hasSubmissions: hasSubmissions ?? this.hasSubmissions,
      isEditMode: isEditMode ?? this.isEditMode,
      isBatchSaving: isBatchSaving ?? this.isBatchSaving,
      batchProgress: batchProgress ?? this.batchProgress,
      batchTotal: batchTotal ?? this.batchTotal,
      batchErrors: batchErrors ?? this.batchErrors,
    );
}
