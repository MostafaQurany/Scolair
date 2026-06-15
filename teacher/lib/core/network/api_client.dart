import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'api_endpoints.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(ApiEndpoints.health)
  Future<void> healthCheck();
}
