// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotificationsResponseData _$GetNotificationsResponseDataFromJson(
  Map<String, dynamic> json,
) => GetNotificationsResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: _paginatedNotificationsFromJson(json['data']),
);

Map<String, dynamic> _$GetNotificationsResponseDataToJson(
  GetNotificationsResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': _paginatedNotificationsToJson(instance.data),
};

GenericNotificationResponseData _$GenericNotificationResponseDataFromJson(
  Map<String, dynamic> json,
) => GenericNotificationResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
);

Map<String, dynamic> _$GenericNotificationResponseDataToJson(
  GenericNotificationResponseData instance,
) => <String, dynamic>{'state': instance.state, 'message': instance.message};
