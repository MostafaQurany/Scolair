import '../../models/home_response_data.dart';

class HomeLocalDataSource {
  const HomeLocalDataSource();

  Future<HomeResponseData> getSummary() async {
    return const HomeResponseData(classCount: 3, assignmentCount: 5);
  }
}
