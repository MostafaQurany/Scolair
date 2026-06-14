import '../../domain/entities/home_summary.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/local/home_local_datasource.dart';
import '../mappers/home_mapper.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._localDataSource);

  final HomeLocalDataSource _localDataSource;

  @override
  Future<HomeSummary> getSummary() async {
    final response = await _localDataSource.getSummary();
    return response.toEntity();
  }
}
