import 'package:json_annotation/json_annotation.dart';

part 'teacher_wall_post_response_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WallPostAuthorResponseData {
  const WallPostAuthorResponseData({
    required this.id,
    required this.displayName,
    this.imageUrl,
    this.roleLabel,
  });

  final String id;
  final String displayName;
  final String? imageUrl;
  final String? roleLabel;

  factory WallPostAuthorResponseData.fromJson(Map<String, dynamic> json) =>
      _$WallPostAuthorResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$WallPostAuthorResponseDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class WallPostAttachmentResponseData {
  const WallPostAttachmentResponseData({
    required this.id,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.title,
    this.aspectRatio,
  });

  final String id;
  final String type;
  final String url;
  final String? thumbnailUrl;
  final String? title;
  final double? aspectRatio;

  factory WallPostAttachmentResponseData.fromJson(Map<String, dynamic> json) =>
      _$WallPostAttachmentResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$WallPostAttachmentResponseDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class WallPostAudienceResponseData {
  const WallPostAudienceResponseData({required this.id, required this.label});

  final String id;
  final String label;

  factory WallPostAudienceResponseData.fromJson(Map<String, dynamic> json) =>
      _$WallPostAudienceResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$WallPostAudienceResponseDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class WallPostPermissionsResponseData {
  const WallPostPermissionsResponseData({
    required this.canEdit,
    required this.canDelete,
    required this.canPin,
    required this.canReport,
    required this.canModerate,
  });

  final bool canEdit;
  final bool canDelete;
  final bool canPin;
  final bool canReport;
  final bool canModerate;

  factory WallPostPermissionsResponseData.fromJson(Map<String, dynamic> json) =>
      _$WallPostPermissionsResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$WallPostPermissionsResponseDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TeacherWallPostResponseData {
  const TeacherWallPostResponseData({
    required this.id,
    required this.author,
    required this.type,
    required this.body,
    required this.hashtags,
    required this.createdAt,
    this.updatedAt,
    required this.audience,
    required this.privacy,
    this.attachment,
    required this.likeCount,
    required this.commentCount,
    required this.isLikedByCurrentUser,
    required this.isOwnedByCurrentUser,
    required this.isPinned,
    required this.isAnswered,
    required this.permissions,
  });

  final String id;
  final WallPostAuthorResponseData author;
  final String type;
  final String body;
  final List<String> hashtags;
  final String createdAt;
  final String? updatedAt;
  final WallPostAudienceResponseData audience;
  final String privacy;
  final WallPostAttachmentResponseData? attachment;
  final int likeCount;
  final int commentCount;
  final bool isLikedByCurrentUser;
  final bool isOwnedByCurrentUser;
  final bool isPinned;
  final bool isAnswered;
  final WallPostPermissionsResponseData permissions;

  factory TeacherWallPostResponseData.fromJson(Map<String, dynamic> json) =>
      _$TeacherWallPostResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherWallPostResponseDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TeacherFeedPageResponseData {
  const TeacherFeedPageResponseData({
    required this.posts,
    required this.hasMore,
    required this.nextPage,
  });

  final List<TeacherWallPostResponseData> posts;
  final bool hasMore;
  final int nextPage;

  factory TeacherFeedPageResponseData.fromJson(Map<String, dynamic> json) =>
      _$TeacherFeedPageResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherFeedPageResponseDataToJson(this);
}
