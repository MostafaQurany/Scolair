import '../../domain/entities/home_summary.dart';
import '../models/home_response_data.dart';

extension HomeResponseDataMapper on HomeResponseData {
  HomeSummary toEntity() {
    return HomeSummary(
      classCount: classCount,
      assignmentCount: assignmentCount,
    );
  }
}
