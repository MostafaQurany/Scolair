import '../../../../../core/network/api_client.dart';

class HomeRemoteDataSource {
  const HomeRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<void> checkHealth() {
    return _apiClient.healthCheck();
  }
}
