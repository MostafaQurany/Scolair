// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_wall_post_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallPostAuthorResponseData _$WallPostAuthorResponseDataFromJson(
  Map<String, dynamic> json,
) => WallPostAuthorResponseData(
  id: json['id'] as String,
  displayName: json['display_name'] as String,
  imageUrl: json['image_url'] as String?,
  roleLabel: json['role_label'] as String?,
);

Map<String, dynamic> _$WallPostAuthorResponseDataToJson(
  WallPostAuthorResponseData instance,
) => <String, dynamic>{
  'id': instance.id,
  'display_name': instance.displayName,
  'image_url': instance.imageUrl,
  'role_label': instance.roleLabel,
};

WallPostAttachmentResponseData _$WallPostAttachmentResponseDataFromJson(
  Map<String, dynamic> json,
) => WallPostAttachmentResponseData(
  id: json['id'] as String,
  type: json['type'] as String,
  url: json['url'] as String,
  thumbnailUrl: json['thumbnail_url'] as String?,
  title: json['title'] as String?,
  aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
);

Map<String, dynamic> _$WallPostAttachmentResponseDataToJson(
  WallPostAttachmentResponseData instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'url': instance.url,
  'thumbnail_url': instance.thumbnailUrl,
  'title': instance.title,
  'aspect_ratio': instance.aspectRatio,
};

WallPostAudienceResponseData _$WallPostAudienceResponseDataFromJson(
  Map<String, dynamic> json,
) => WallPostAudienceResponseData(
  id: json['id'] as String,
  label: json['label'] as String,
);

Map<String, dynamic> _$WallPostAudienceResponseDataToJson(
  WallPostAudienceResponseData instance,
) => <String, dynamic>{'id': instance.id, 'label': instance.label};

WallPostPermissionsResponseData _$WallPostPermissionsResponseDataFromJson(
  Map<String, dynamic> json,
) => WallPostPermissionsResponseData(
  canEdit: json['can_edit'] as bool,
  canDelete: json['can_delete'] as bool,
  canPin: json['can_pin'] as bool,
  canReport: json['can_report'] as bool,
  canModerate: json['can_moderate'] as bool,
);

Map<String, dynamic> _$WallPostPermissionsResponseDataToJson(
  WallPostPermissionsResponseData instance,
) => <String, dynamic>{
  'can_edit': instance.canEdit,
  'can_delete': instance.canDelete,
  'can_pin': instance.canPin,
  'can_report': instance.canReport,
  'can_moderate': instance.canModerate,
};

TeacherWallPostResponseData _$TeacherWallPostResponseDataFromJson(
  Map<String, dynamic> json,
) => TeacherWallPostResponseData(
  id: json['id'] as String,
  author: WallPostAuthorResponseData.fromJson(
    json['author'] as Map<String, dynamic>,
  ),
  type: json['type'] as String,
  body: json['body'] as String,
  hashtags: (json['hashtags'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  createdAt: json['created_at'] as String,
  audience: WallPostAudienceResponseData.fromJson(
    json['audience'] as Map<String, dynamic>,
  ),
  privacy: json['privacy'] as String,
  likeCount: (json['like_count'] as num).toInt(),
  commentCount: (json['comment_count'] as num).toInt(),
  isLikedByCurrentUser: json['is_liked_by_current_user'] as bool,
  isOwnedByCurrentUser: json['is_owned_by_current_user'] as bool,
  isPinned: json['is_pinned'] as bool,
  isAnswered: json['is_answered'] as bool,
  permissions: WallPostPermissionsResponseData.fromJson(
    json['permissions'] as Map<String, dynamic>,
  ),
  updatedAt: json['updated_at'] as String?,
  attachment: json['attachment'] == null
      ? null
      : WallPostAttachmentResponseData.fromJson(
          json['attachment'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$TeacherWallPostResponseDataToJson(
  TeacherWallPostResponseData instance,
) => <String, dynamic>{
  'id': instance.id,
  'author': instance.author,
  'type': instance.type,
  'body': instance.body,
  'hashtags': instance.hashtags,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'audience': instance.audience,
  'privacy': instance.privacy,
  'attachment': instance.attachment,
  'like_count': instance.likeCount,
  'comment_count': instance.commentCount,
  'is_liked_by_current_user': instance.isLikedByCurrentUser,
  'is_owned_by_current_user': instance.isOwnedByCurrentUser,
  'is_pinned': instance.isPinned,
  'is_answered': instance.isAnswered,
  'permissions': instance.permissions,
};

TeacherFeedPageResponseData _$TeacherFeedPageResponseDataFromJson(
  Map<String, dynamic> json,
) => TeacherFeedPageResponseData(
  posts: (json['posts'] as List<dynamic>)
      .map(
        (e) => TeacherWallPostResponseData.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  hasMore: json['has_more'] as bool,
  nextPage: (json['next_page'] as num).toInt(),
);

Map<String, dynamic> _$TeacherFeedPageResponseDataToJson(
  TeacherFeedPageResponseData instance,
) => <String, dynamic>{
  'posts': instance.posts,
  'has_more': instance.hasMore,
  'next_page': instance.nextPage,
};
