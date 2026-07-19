import '../../../../core/network/api_result.dart';
import '../entities/teacher_home.dart';
import '../repositories/teacher_home_repository.dart';

class GetTeacherHomeUseCase {
  const GetTeacherHomeUseCase(this._repository);

  final TeacherHomeRepository _repository;

  Future<ApiResult<TeacherHome>> call() => _repository.getTeacherHome();
}
