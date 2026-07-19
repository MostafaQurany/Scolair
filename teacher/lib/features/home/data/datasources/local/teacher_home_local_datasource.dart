import '../../models/teacher_home_response_data.dart';
import '../../models/teacher_wall_post_response_data.dart';

abstract interface class TeacherHomeLocalDataSource {
  Future<TeacherHomeResponseData> getTeacherHome();

  Future<TeacherFeedPageResponseData> getWallPosts({
    required String? filterId,
    required int page,
    required int pageSize,
  });

  Future<TeacherWallPostResponseData> toggleLike({
    required String postId,
    required bool shouldLike,
  });
}

class TeacherHomeLocalDataSourceImpl implements TeacherHomeLocalDataSource {
  TeacherHomeLocalDataSourceImpl();

  // In-memory list to keep track of likes & posts state dynamically
  final List<TeacherWallPostResponseData> _inMemoryPosts = [
    // Post 1: Announcement (Pinned, Owned by teacher, no attachment)
    const TeacherWallPostResponseData(
      id: 'post_001',
      author: WallPostAuthorResponseData(
        id: 'teacher_001',
        displayName: 'Alex Johnson',
        roleLabel: 'Calculus Teacher',
      ),
      type: 'announcement',
      body:
          """Don't forget the upcoming Calculus mid-term next Tuesday. I've uploaded the practice worksheets in the Resources section. Please review the derivatives section thoroughly.
          Don't forget the upcoming Calculus mid-term next Tuesday. I've uploaded the practice worksheets in the Resources section. Please review the derivatives section thoroughly.
          Don't forget the upcoming Calculus mid-term next Tuesday. I've uploaded the practice worksheets in the Resources section. Please review the derivatives section thoroughly.
          Don't forget the upcoming Calculus mid-term next Tuesday. I've uploaded the practice worksheets in the Resources section. Please review the derivatives section thoroughly.
          Don't forget the upcoming Calculus mid-term next Tuesday. I've uploaded the practice worksheets in the Resources section. Please review the derivatives section thoroughly.
          Don't forget the upcoming Calculus mid-term next Tuesday. I've uploaded the practice worksheets in the Resources section. Please review the derivatives section thoroughly.
          """,
      hashtags: ['Calculus', 'ExamPrep'],
      createdAt: '2026-07-19T08:00:00Z',
      audience: WallPostAudienceResponseData(
        id: 'grade_10_a',
        label: 'Grade 10-A',
      ),
      privacy: 'class_room',
      attachment: null,
      likeCount: 24,
      commentCount: 5,
      isLikedByCurrentUser: false,
      isOwnedByCurrentUser: true,
      isPinned: true,
      isAnswered: false,
      permissions: WallPostPermissionsResponseData(
        canEdit: true,
        canDelete: true,
        canPin: true,
        canReport: false,
        canModerate: true,
      ),
    ),
    // Post 2: Discussion (Not owned, contains image attachment, can moderate)
    const TeacherWallPostResponseData(
      id: 'post_002',
      author: WallPostAuthorResponseData(
        id: 'teacher_002',
        displayName: 'Lucas Miller',
        roleLabel: 'History Teacher',
      ),
      type: 'discussion',
      body:
          'Hey everyone! Does anyone want to form a study group for the Math test this weekend? I can host at the library on Saturday morning. 📚',
      hashtags: ['StudyGroup', 'MathHelp'],
      createdAt: '2026-07-19T06:00:00Z',
      audience: WallPostAudienceResponseData(
        id: 'grade_10_a',
        label: 'Grade 10-A',
      ),
      privacy: 'class_room',
      attachment: WallPostAttachmentResponseData(
        id: 'att_001',
        type: 'image',
        url: 'https://picsum.photos/800/450',
        title: 'Study group meeting space',
        aspectRatio: 16 / 9,
      ),
      likeCount: 12,
      commentCount: 8,
      isLikedByCurrentUser: false,
      isOwnedByCurrentUser: false,
      isPinned: false,
      isAnswered: false,
      permissions: WallPostPermissionsResponseData(
        canEdit: false,
        canDelete: false,
        canPin: false,
        canReport: true,
        canModerate: true,
      ),
    ),
    // Post 3: Question (Not owned, marked as answered)
    const TeacherWallPostResponseData(
      id: 'post_003',
      author: WallPostAuthorResponseData(
        id: 'student_001',
        displayName: 'Marcus Reed',
        roleLabel: 'Student',
      ),
      type: 'question',
      body:
          'Physics lab results are now live. Great job on the pendulum experiments today. One small correction on the friction coefficients - check the updated notes.',
      hashtags: ['Physics', 'LabResults'],
      createdAt: '2026-07-19T04:00:00Z',
      audience: WallPostAudienceResponseData(
        id: 'grade_10_b',
        label: 'Grade 10-B',
      ),
      privacy: 'class_room',
      attachment: null,
      likeCount: 18,
      commentCount: 2,
      isLikedByCurrentUser: false,
      isOwnedByCurrentUser: false,
      isPinned: false,
      isAnswered: true,
      permissions: WallPostPermissionsResponseData(
        canEdit: false,
        canDelete: false,
        canPin: false,
        canReport: true,
        canModerate: false,
      ),
    ),
    // Post 4: Resource
    const TeacherWallPostResponseData(
      id: 'post_004',
      author: WallPostAuthorResponseData(
        id: 'teacher_003',
        displayName: 'Sarah Connor',
        roleLabel: 'Biology Teacher',
      ),
      type: 'resource',
      body:
          'Here is the syllabus and recommended reading material for the genetics semester. Let me know if you have trouble accessing the links.',
      hashtags: ['Biology', 'Genetics', 'Syllabus'],
      createdAt: '2026-07-18T15:00:00Z',
      audience: WallPostAudienceResponseData(
        id: 'grade_10_a',
        label: 'Grade 10-A',
      ),
      privacy: 'class_room',
      attachment: null,
      likeCount: 9,
      commentCount: 0,
      isLikedByCurrentUser: false,
      isOwnedByCurrentUser: false,
      isPinned: false,
      isAnswered: false,
      permissions: WallPostPermissionsResponseData(
        canEdit: false,
        canDelete: false,
        canPin: false,
        canReport: true,
        canModerate: false,
      ),
    ),
    // Post 5: Achievement (Page 2)
    const TeacherWallPostResponseData(
      id: 'post_005',
      author: WallPostAuthorResponseData(
        id: 'teacher_001',
        displayName: 'Alex Johnson',
        roleLabel: 'Calculus Teacher',
      ),
      type: 'achievement',
      body:
          'Shoutout to Grade 10-A for achieving a 95% average on the Calculus homework this week! Keep up the amazing work! 🏆🔥',
      hashtags: ['Achievement', 'ProudTeacher'],
      createdAt: '2026-07-18T10:00:00Z',
      audience: WallPostAudienceResponseData(
        id: 'grade_10_a',
        label: 'Grade 10-A',
      ),
      privacy: 'class_room',
      attachment: null,
      likeCount: 42,
      commentCount: 14,
      isLikedByCurrentUser: false,
      isOwnedByCurrentUser: true,
      isPinned: false,
      isAnswered: false,
      permissions: WallPostPermissionsResponseData(
        canEdit: true,
        canDelete: true,
        canPin: true,
        canReport: false,
        canModerate: true,
      ),
    ),
    // Post 6: System Update / Poll (Page 2)
    const TeacherWallPostResponseData(
      id: 'post_006',
      author: WallPostAuthorResponseData(
        id: 'system_admin',
        displayName: 'System Admin',
        roleLabel: 'Administrator',
      ),
      type: 'systemUpdate',
      body:
          'Maintenance: The school portal will be offline for routine database updates on Sunday between 2:00 AM and 4:00 AM. Plan accordingly.',
      hashtags: ['PortalUpdate', 'Maintenance'],
      createdAt: '2026-07-17T12:00:00Z',
      audience: WallPostAudienceResponseData(id: 'all', label: 'All Classes'),
      privacy: 'institution',
      attachment: null,
      likeCount: 5,
      commentCount: 1,
      isLikedByCurrentUser: false,
      isOwnedByCurrentUser: false,
      isPinned: false,
      isAnswered: false,
      permissions: WallPostPermissionsResponseData(
        canEdit: false,
        canDelete: false,
        canPin: false,
        canReport: false,
        canModerate: false,
      ),
    ),
  ];

  @override
  Future<TeacherHomeResponseData> getTeacherHome() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return const TeacherHomeResponseData(
      teacher: TeacherProfileResponseData(
        id: 'teacher_001',
        displayName: 'Alex Johnson',
        imageUrl: null, // Forces initials avatar
      ),
      greetingActivityTitle: null, // Forces fallback sentence
      organizationNoticeCount: 2,
      filters: [
        TeacherFeedFilterResponseData(
          id: 'all',
          label: 'All Classes',
          type: 'all',
        ),
        TeacherFeedFilterResponseData(
          id: 'grade_10_a',
          label: 'Grade 10-A',
          type: 'classroom',
        ),
        TeacherFeedFilterResponseData(
          id: 'grade_10_b',
          label: 'Grade 10-B',
          type: 'classroom',
        ),
        TeacherFeedFilterResponseData(
          id: 'math',
          label: 'Math',
          type: 'subject',
        ),
        TeacherFeedFilterResponseData(
          id: 'science',
          label: 'Science',
          type: 'subject',
        ),
      ],
    );
  }

  @override
  Future<TeacherFeedPageResponseData> getWallPosts({
    required String? filterId,
    required int page,
    required int pageSize,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Filter posts if filterId is not 'all' or null
    final filtered = _inMemoryPosts.where((post) {
      if (filterId == null || filterId == 'all') return true;
      if (post.audience.id == filterId) return true;
      if (post.type.toLowerCase() == filterId.toLowerCase()) return true;
      // Subject filtering mapping stub
      if (filterId == 'math' &&
          (post.hashtags.contains('Calculus') ||
              post.hashtags.contains('MathHelp'))) {
        return true;
      }
      if (filterId == 'science' && post.hashtags.contains('Physics')) {
        return true;
      }
      return false;
    }).toList();

    final startIndex = (page - 1) * pageSize;
    if (startIndex >= filtered.length) {
      return TeacherFeedPageResponseData(
        posts: [],
        hasMore: false,
        nextPage: page,
      );
    }

    final endIndex = (startIndex + pageSize).clamp(0, filtered.length);
    final pagedPosts = filtered.sublist(startIndex, endIndex);
    final hasMore = endIndex < filtered.length;

    return TeacherFeedPageResponseData(
      posts: pagedPosts,
      hasMore: hasMore,
      nextPage: page + 1,
    );
  }

  @override
  Future<TeacherWallPostResponseData> toggleLike({
    required String postId,
    required bool shouldLike,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _inMemoryPosts.indexWhere((p) => p.id == postId);
    if (index == -1) {
      throw Exception('Post not found');
    }

    final post = _inMemoryPosts[index];
    final updatedPost = TeacherWallPostResponseData(
      id: post.id,
      author: post.author,
      type: post.type,
      body: post.body,
      hashtags: post.hashtags,
      createdAt: post.createdAt,
      updatedAt: post.updatedAt,
      audience: post.audience,
      privacy: post.privacy,
      attachment: post.attachment,
      likeCount: shouldLike
          ? (post.isLikedByCurrentUser ? post.likeCount : post.likeCount + 1)
          : (post.isLikedByCurrentUser ? post.likeCount - 1 : post.likeCount),
      commentCount: post.commentCount,
      isLikedByCurrentUser: shouldLike,
      isOwnedByCurrentUser: post.isOwnedByCurrentUser,
      isPinned: post.isPinned,
      isAnswered: post.isAnswered,
      permissions: post.permissions,
    );

    _inMemoryPosts[index] = updatedPost;
    return updatedPost;
  }
}
