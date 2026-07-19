import 'dart:developer' as developer;

import '../../domain/entities/teacher_feed_page.dart';
import '../../domain/entities/teacher_feed_filter.dart';
import '../../domain/entities/teacher_home.dart';
import '../../domain/entities/teacher_profile.dart';
import '../../domain/entities/teacher_wall_post.dart';
import '../models/teacher_home_response_data.dart';
import '../models/teacher_wall_post_response_data.dart';

abstract final class TeacherHomeMapper {
  static TeacherProfile mapProfile(TeacherProfileResponseData data) {
    return TeacherProfile(
      id: data.id,
      displayName: data.displayName,
      imageUrl: data.imageUrl,
    );
  }

  static TeacherFeedFilter mapFilter(TeacherFeedFilterResponseData data) {
    return TeacherFeedFilter(
      id: data.id,
      label: data.label,
      type: _mapFilterType(data.type),
    );
  }

  static TeacherHome mapHome(TeacherHomeResponseData data) {
    return TeacherHome(
      teacher: mapProfile(data.teacher),
      greetingActivityTitle: data.greetingActivityTitle,
      organizationNoticeCount: data.organizationNoticeCount,
      filters: data.filters.map(mapFilter).toList(),
    );
  }

  static WallPostAuthor mapAuthor(WallPostAuthorResponseData data) {
    return WallPostAuthor(
      id: data.id,
      displayName: data.displayName,
      imageUrl: data.imageUrl,
      roleLabel: data.roleLabel,
    );
  }

  static WallPostAttachment? mapAttachment(
    WallPostAttachmentResponseData? data,
  ) {
    if (data == null) return null;
    return WallPostAttachment(
      id: data.id,
      type: _mapAttachmentType(data.type),
      url: data.url,
      thumbnailUrl: data.thumbnailUrl,
      title: data.title,
      aspectRatio: data.aspectRatio,
    );
  }

  static WallPostAudience mapAudience(WallPostAudienceResponseData data) {
    return WallPostAudience(id: data.id, label: data.label);
  }

  static WallPostPermissions mapPermissions(
    WallPostPermissionsResponseData data,
  ) {
    return WallPostPermissions(
      canEdit: data.canEdit,
      canDelete: data.canDelete,
      canPin: data.canPin,
      canReport: data.canReport,
      canModerate: data.canModerate,
    );
  }

  static TeacherWallPost mapPost(TeacherWallPostResponseData data) {
    final parsedCreated = DateTime.tryParse(data.createdAt);
    if (parsedCreated == null) {
      developer.log(
        'Failed to parse createdAt date: ${data.createdAt} for post ${data.id}',
        name: 'scolair.home.mapper',
        level: 900, // WARNING
      );
    }

    DateTime? parsedUpdated;
    if (data.updatedAt != null) {
      parsedUpdated = DateTime.tryParse(data.updatedAt!);
      if (parsedUpdated == null) {
        developer.log(
          'Failed to parse updatedAt date: ${data.updatedAt} for post ${data.id}',
          name: 'scolair.home.mapper',
          level: 900, // WARNING
        );
      }
    }

    return TeacherWallPost(
      id: data.id,
      author: mapAuthor(data.author),
      type: _mapPostType(data.type),
      body: data.body,
      hashtags: data.hashtags,
      createdAt: parsedCreated ?? DateTime.now(),
      updatedAt: parsedUpdated,
      audience: mapAudience(data.audience),
      privacy: _mapPrivacy(data.privacy),
      attachment: mapAttachment(data.attachment),
      likeCount: data.likeCount,
      commentCount: data.commentCount,
      isLikedByCurrentUser: data.isLikedByCurrentUser,
      isOwnedByCurrentUser: data.isOwnedByCurrentUser,
      isPinned: data.isPinned,
      isAnswered: data.isAnswered,
      permissions: mapPermissions(data.permissions),
    );
  }

  static TeacherFeedPage mapFeedPage(TeacherFeedPageResponseData data) {
    return TeacherFeedPage(
      posts: data.posts.map(mapPost).toList(),
      hasMore: data.hasMore,
      nextPage: data.nextPage,
    );
  }

  static TeacherFeedFilterType _mapFilterType(String type) {
    return switch (type.toLowerCase()) {
      'all' => TeacherFeedFilterType.all,
      'classroom' || 'class_room' => TeacherFeedFilterType.classRoom,
      'course' => TeacherFeedFilterType.course,
      'subject' => TeacherFeedFilterType.subject,
      'group' => TeacherFeedFilterType.group,
      _ => TeacherFeedFilterType.all,
    };
  }

  static WallPostType _mapPostType(String type) {
    return switch (type.toLowerCase()) {
      'announcement' => WallPostType.announcement,
      'question' => WallPostType.question,
      'discussion' => WallPostType.discussion,
      'resource' => WallPostType.resource,
      'assignment_update' ||
      'assignmentupdate' => WallPostType.assignmentUpdate,
      'quiz_update' || 'quizupdate' => WallPostType.quizUpdate,
      'achievement' => WallPostType.achievement,
      'poll' => WallPostType.poll,
      'system_update' || 'systemupdate' => WallPostType.systemUpdate,
      _ => WallPostType.discussion,
    };
  }

  static WallPostPrivacy _mapPrivacy(String privacy) {
    return switch (privacy.toLowerCase()) {
      'institution' => WallPostPrivacy.institution,
      'branch' => WallPostPrivacy.branch,
      'classroom' || 'class_room' => WallPostPrivacy.classRoom,
      'course' => WallPostPrivacy.course,
      'group' => WallPostPrivacy.group,
      'private_audience' || 'private' => WallPostPrivacy.privateAudience,
      _ => WallPostPrivacy.classRoom,
    };
  }

  static WallPostAttachmentType _mapAttachmentType(String type) {
    return switch (type.toLowerCase()) {
      'image' => WallPostAttachmentType.image,
      'video' => WallPostAttachmentType.video,
      'document' => WallPostAttachmentType.document,
      'link' => WallPostAttachmentType.link,
      _ => WallPostAttachmentType.image,
    };
  }
}
