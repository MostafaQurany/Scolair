import 'package:json_annotation/json_annotation.dart';

import '../../../../core/network/paginated_list.dart';
import 'notification_model.dart';

part 'notification_response_models.g.dart';

PaginatedList<NotificationModel> _paginatedNotificationsFromJson(Object? json) =>
    PaginatedList.fromJson<NotificationModel>(
      json,
      NotificationModel.fromJson,
    );

Map<String, dynamic> _paginatedNotificationsToJson(
        PaginatedList<NotificationModel> list) =>
    <String, dynamic>{
      'items': list.items.map((e) => e.toJson()).toList(),
      'total': list.total,
      'start': list.start,
      'page_size': list.pageSize,
      'has_next_page': list.hasNextPage,
    };

@JsonSerializable()
class GetNotificationsResponseData {
  const GetNotificationsResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory GetNotificationsResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationsResponseDataFromJson(json);

  final String state;
  final String message;
  @JsonKey(fromJson: _paginatedNotificationsFromJson, toJson: _paginatedNotificationsToJson)
  final PaginatedList<NotificationModel> data;

  Map<String, dynamic> toJson() => _$GetNotificationsResponseDataToJson(this);
}

@JsonSerializable()
class GenericNotificationResponseData {
  const GenericNotificationResponseData({
    required this.state,
    required this.message,
  });

  factory GenericNotificationResponseData.fromJson(Map<String, dynamic> json) =>
      _$GenericNotificationResponseDataFromJson(json);

  final String state;
  final String message;

  Map<String, dynamic> toJson() => _$GenericNotificationResponseDataToJson(this);
}

