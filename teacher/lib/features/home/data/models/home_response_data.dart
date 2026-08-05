import 'package:json_annotation/json_annotation.dart';

part 'home_response_data.g.dart';

@JsonSerializable()
class HomeResponseData {
  const HomeResponseData({
    required this.classCount,
    required this.assignmentCount,
  });

  factory HomeResponseData.fromJson(Map<String, dynamic> json) => _$HomeResponseDataFromJson(json);

  final int classCount;
  final int assignmentCount;

  Map<String, dynamic> toJson() => _$HomeResponseDataToJson(this);
}
