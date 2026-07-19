import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/teacher_home.dart';
import '../../domain/entities/teacher_wall_post.dart';

part 'home_state.freezed.dart';

@freezed
sealed class TeacherHomeState with _$TeacherHomeState {
  const factory TeacherHomeState.initial() = TeacherHomeInitial;

  const factory TeacherHomeState.loading() = TeacherHomeLoading;

  const factory TeacherHomeState.success({
    required TeacherHome home,
    required List<TeacherWallPost> posts,
    required String selectedFilterId,
    required bool hasMore,
    required bool isLoadingMore,
    required bool isRefreshing,
    @Default(false) bool isFiltering,
    String? actionError,
  }) = TeacherHomeSuccess;

  const factory TeacherHomeState.empty({
    required TeacherHome home,
    required String selectedFilterId,
    @Default(false) bool isFiltering,
  }) = TeacherHomeEmpty;

  const factory TeacherHomeState.error({required String message}) =
      TeacherHomeError;
}
