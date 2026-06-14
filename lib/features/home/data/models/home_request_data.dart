import 'package:json_annotation/json_annotation.dart';

part 'home_request_data.g.dart';

@JsonSerializable()
class HomeRequestData {
  const HomeRequestData({required this.userId});

  final String userId;

  factory HomeRequestData.fromJson(Map<String, dynamic> json) {
    return _$HomeRequestDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeRequestDataToJson(this);
}
