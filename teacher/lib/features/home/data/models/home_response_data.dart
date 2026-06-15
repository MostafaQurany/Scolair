import 'package:json_annotation/json_annotation.dart';

part 'home_response_data.g.dart';

@JsonSerializable()
class HomeResponseData {
  const HomeResponseData({
    required this.classCount,
    required this.assignmentCount,
  });

  final int classCount;
  final int assignmentCount;

  factory HomeResponseData.fromJson(Map<String, dynamic> json) {
    return _$HomeResponseDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeResponseDataToJson(this);
}
