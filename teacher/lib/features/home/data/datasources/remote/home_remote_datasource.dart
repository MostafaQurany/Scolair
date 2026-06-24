import '../../../../../core/network/api_client.dart';

class HomeRemoteDataSource {
  const HomeRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<void> checkHealth() async {
    throw Exception("hello");
  }
}
