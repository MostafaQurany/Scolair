import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/courses_usecases.dart';
import 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit(this._listCoursesUseCase, this._getMyCoursesUseCase)
      : super(const CoursesState());

  final ListCoursesUseCase _listCoursesUseCase;
  final GetMyCoursesUseCase _getMyCoursesUseCase;

  Future<void> loadCourses() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final allRes = await _listCoursesUseCase();
    final myRes = await _getMyCoursesUseCase();

    allRes.when(
      success: (allCourses) {
        myRes.when(
          success: (myCoursesData) {
            emit(state.copyWith(
              isLoading: false,
              allCourses: allCourses,
              myCourses: myCoursesData.courses,
            ));
          },
          failure: (fail) {
            emit(state.copyWith(
              isLoading: false,
              allCourses: allCourses,
              myCourses: const [],
              errorMessage: fail.message,
            ));
          },
        );
      },
      failure: (fail) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: fail.message,
        ));
      },
    );
  }
}
