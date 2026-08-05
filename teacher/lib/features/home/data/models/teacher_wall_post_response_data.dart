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

  factory WallPostAuthorResponseData.fromJson(Map<String, dynamic> json) =>
      _$WallPostAuthorResponseDataFromJson(json);

  final String id;
  final String displayName;
  final String? imageUrl;
  final String? roleLabel;

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

  factory WallPostAttachmentResponseData.fromJson(Map<String, dynamic> json) =>
      _$WallPostAttachmentResponseDataFromJson(json);

  final String id;
  final String type;
  final String url;
  final String? thumbnailUrl;
  final String? title;
  final double? aspectRatio;

  Map<String, dynamic> toJson() => _$WallPostAttachmentResponseDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class WallPostAudienceResponseData {
  const WallPostAudienceResponseData({required this.id, required this.label});

  factory WallPostAudienceResponseData.fromJson(Map<String, dynamic> json) =>
      _$WallPostAudienceResponseDataFromJson(json);

  final String id;
  final String label;

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

  factory WallPostPermissionsResponseData.fromJson(Map<String, dynamic> json) =>
      _$WallPostPermissionsResponseDataFromJson(json);

  final bool canEdit;
  final bool canDelete;
  final bool canPin;
  final bool canReport;
  final bool canModerate;

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
    required this.audience, required this.privacy, required this.likeCount, required this.commentCount, required this.isLikedByCurrentUser, required this.isOwnedByCurrentUser, required this.isPinned, required this.isAnswered, required this.permissions, this.updatedAt,
    this.attachment,
  });

  factory TeacherWallPostResponseData.fromJson(Map<String, dynamic> json) =>
      _$TeacherWallPostResponseDataFromJson(json);

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

  Map<String, dynamic> toJson() => _$TeacherWallPostResponseDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TeacherFeedPageResponseData {
  const TeacherFeedPageResponseData({
    required this.posts,
    required this.hasMore,
    required this.nextPage,
  });

  factory TeacherFeedPageResponseData.fromJson(Map<String, dynamic> json) =>
      _$TeacherFeedPageResponseDataFromJson(json);

  final List<TeacherWallPostResponseData> posts;
  final bool hasMore;
  final int nextPage;

  Map<String, dynamic> toJson() => _$TeacherFeedPageResponseDataToJson(this);
}
