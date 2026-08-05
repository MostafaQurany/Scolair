class WallPostAuthor {
  const WallPostAuthor({
    required this.id,
    required this.displayName,
    this.imageUrl,
    this.roleLabel,
  });

  final String id;
  final String displayName;
  final String? imageUrl;
  final String? roleLabel;
}

enum WallPostType {
  announcement,
  question,
  discussion,
  resource,
  assignmentUpdate,
  quizUpdate,
  achievement,
  poll,
  systemUpdate,
}

enum WallPostPrivacy {
  institution,
  branch,
  classRoom,
  course,
  group,
  privateAudience,
}

enum WallPostAttachmentType { image, video, document, link }

class WallPostAttachment {
  const WallPostAttachment({
    required this.id,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.title,
    this.aspectRatio,
  });

  final String id;
  final WallPostAttachmentType type;
  final String url;
  final String? thumbnailUrl;
  final String? title;
  final double? aspectRatio;
}

class WallPostAudience {
  const WallPostAudience({required this.id, required this.label});

  final String id;
  final String label;
}

class WallPostPermissions {
  const WallPostPermissions({
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
}

class TeacherWallPost {
  const TeacherWallPost({
    required this.id,
    required this.author,
    required this.type,
    required this.body,
    required this.hashtags,
    required this.createdAt,
    required this.audience, required this.privacy, required this.likeCount, required this.commentCount, required this.isLikedByCurrentUser, required this.isOwnedByCurrentUser, required this.isPinned, required this.isAnswered, required this.permissions, this.updatedAt,
    this.attachment,
  });

  final String id;
  final WallPostAuthor author;
  final WallPostType type;
  final String body;
  final List<String> hashtags;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final WallPostAudience audience;
  final WallPostPrivacy privacy;
  final WallPostAttachment? attachment;
  final int likeCount;
  final int commentCount;
  final bool isLikedByCurrentUser;
  final bool isOwnedByCurrentUser;
  final bool isPinned;
  final bool isAnswered;
  final WallPostPermissions permissions;

  TeacherWallPost copyWith({
    String? id,
    WallPostAuthor? author,
    WallPostType? type,
    String? body,
    List<String>? hashtags,
    DateTime? createdAt,
    DateTime? updatedAt,
    WallPostAudience? audience,
    WallPostPrivacy? privacy,
    WallPostAttachment? attachment,
    int? likeCount,
    int? commentCount,
    bool? isLikedByCurrentUser,
    bool? isOwnedByCurrentUser,
    bool? isPinned,
    bool? isAnswered,
    WallPostPermissions? permissions,
  }) => TeacherWallPost(
      id: id ?? this.id,
      author: author ?? this.author,
      type: type ?? this.type,
      body: body ?? this.body,
      hashtags: hashtags ?? this.hashtags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      audience: audience ?? this.audience,
      privacy: privacy ?? this.privacy,
      attachment: attachment ?? this.attachment,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLikedByCurrentUser: isLikedByCurrentUser ?? this.isLikedByCurrentUser,
      isOwnedByCurrentUser: isOwnedByCurrentUser ?? this.isOwnedByCurrentUser,
      isPinned: isPinned ?? this.isPinned,
      isAnswered: isAnswered ?? this.isAnswered,
      permissions: permissions ?? this.permissions,
    );
}
