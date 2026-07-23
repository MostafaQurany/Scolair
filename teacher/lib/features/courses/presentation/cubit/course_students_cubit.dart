import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/courses_usecases.dart';
import 'course_students_state.dart';

class CourseStudentsCubit extends Cubit<CourseStudentsState> {
  CourseStudentsCubit(
    this._getStudentsUseCase,
    this._addStudentUseCase,
    this._removeStudentUseCase,
  ) : super(const CourseStudentsState());

  final GetStudentsUseCase _getStudentsUseCase;
  final AddStudentUseCase _addStudentUseCase;
  final RemoveStudentUseCase _removeStudentUseCase;

  Future<void> loadStudents(String courseName) async {
    emit(state.copyWith(
      courseName: courseName,
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    ));

    final result = await _getStudentsUseCase(courseName);

    result.when(
      success: (students) {
        emit(state.copyWith(
          isLoading: false,
          students: students,
        ));
      },
      failure: (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ));
      },
    );
  }

  Future<void> addStudent(String email) async {
    final courseName = state.courseName;
    if (courseName == null || courseName.isEmpty) return;

    emit(state.copyWith(
      isAdding: true,
      errorMessage: null,
      successMessage: null,
    ));

    final result = await _addStudentUseCase(
      courseName: courseName,
      studentEmail: email.trim(),
    );

    result.when(
      success: (_) {
        emit(state.copyWith(
          isAdding: false,
          successMessage: 'Student added successfully',
        ));
        loadStudents(courseName);
      },
      failure: (failure) {
        emit(state.copyWith(
          isAdding: false,
          errorMessage: failure.message,
        ));
      },
    );
  }

  Future<void> removeStudent(String email) async {
    final courseName = state.courseName;
    if (courseName == null || courseName.isEmpty) return;

    emit(state.copyWith(
      isRemoving: true,
      errorMessage: null,
      successMessage: null,
    ));

    final result = await _removeStudentUseCase(
      courseName: courseName,
      studentEmail: email.trim(),
    );

    result.when(
      success: (_) {
        emit(state.copyWith(
          isRemoving: false,
          successMessage: 'Student removed successfully',
        ));
        loadStudents(courseName);
      },
      failure: (failure) {
        emit(state.copyWith(
          isRemoving: false,
          errorMessage: failure.message,
        ));
      },
    );
  }
}
