import '../../../../core/network/api_result.dart';
import '../../data/models/homework_models.dart';
import '../repositories/homework_repository.dart';

class ListHomeworkUseCase {
  const ListHomeworkUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<List<HomeworkModel>>> call() => _repository.listHomework();
}

class CreateHomeworkUseCase {
  const CreateHomeworkUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<HomeworkModel>> call(HomeworkModel homework) =>
      _repository.createHomework(homework);
}

class UpdateHomeworkUseCase {
  const UpdateHomeworkUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<HomeworkModel>> call(HomeworkModel homework) =>
      _repository.updateHomework(homework);
}

class DeleteHomeworkUseCase {
  const DeleteHomeworkUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<void>> call(String id) => _repository.deleteHomework(id);
}

class DuplicateHomeworkUseCase {
  const DuplicateHomeworkUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<HomeworkModel>> call(String id) =>
      _repository.duplicateHomework(id);
}
