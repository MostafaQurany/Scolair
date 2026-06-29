// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorModel _$InstructorModelFromJson(Map<String, dynamic> json) =>
    InstructorModel(
      name: json['name'] as String,
      username: json['username'] as String?,
      fullName: json['full_name'] as String?,
      userImage: json['user_image'] as String?,
      firstName: json['first_name'] as String?,
      bio: json['bio'] as String?,
      instructor: json['instructor'] as String?,
    );

Map<String, dynamic> _$InstructorModelToJson(InstructorModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'full_name': instance.fullName,
      'user_image': instance.userImage,
      'first_name': instance.firstName,
      'bio': instance.bio,
      'instructor': instance.instructor,
    };

MembershipModel _$MembershipModelFromJson(Map<String, dynamic> json) =>
    MembershipModel(
      name: json['name'] as String,
      currentLesson: json['current_lesson'] as String?,
      progress: (json['progress'] as num).toDouble(),
      member: json['member'] as String,
      course: json['course'] as String,
      purchasedCertificate: (json['purchased_certificate'] as num).toInt(),
      certificate: json['certificate'] as String?,
    );

Map<String, dynamic> _$MembershipModelToJson(MembershipModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'current_lesson': instance.currentLesson,
      'progress': instance.progress,
      'member': instance.member,
      'course': instance.course,
      'purchased_certificate': instance.purchasedCertificate,
      'certificate': instance.certificate,
    };

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
  name: json['name'] as String,
  title: json['title'] as String,
  tags: json['tags'] as String?,
  image: json['image'] as String?,
  videoLink: json['video_link'] as String?,
  cardGradient: json['card_gradient'] as String?,
  shortIntroduction: json['short_introduction'] as String?,
  description: json['description'] as String?,
  published: (json['published'] as num?)?.toInt(),
  upcoming: (json['upcoming'] as num?)?.toInt(),
  featured: (json['featured'] as num?)?.toInt(),
  disableSelfLearning: (json['disable_self_learning'] as num?)?.toInt(),
  publishedOn: json['published_on'] as String?,
  category: json['category'] as String?,
  status: json['status'] as String?,
  paidCourse: (json['paid_course'] as num?)?.toInt(),
  paidCertificate: (json['paid_certificate'] as num?)?.toInt(),
  coursePrice: (json['course_price'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
  amountUsd: (json['amount_usd'] as num?)?.toDouble(),
  enableCertification: (json['enable_certification'] as num?)?.toInt(),
  lessons: (json['lessons'] as num?)?.toInt(),
  enrollments: (json['enrollments'] as num?)?.toInt(),
  rating: json['rating'],
  instructors: (json['instructors'] as List<dynamic>?)
      ?.map((e) => InstructorModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  membership: _membershipFromJson(json['membership']),
  ratingCount: (json['rating_count'] as num?)?.toInt(),
  owner: json['owner'] as String?,
  creation: json['creation'] as String?,
);

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'tags': instance.tags,
      'image': instance.image,
      'video_link': instance.videoLink,
      'card_gradient': instance.cardGradient,
      'short_introduction': instance.shortIntroduction,
      'description': instance.description,
      'published': instance.published,
      'upcoming': instance.upcoming,
      'featured': instance.featured,
      'disable_self_learning': instance.disableSelfLearning,
      'published_on': instance.publishedOn,
      'category': instance.category,
      'status': instance.status,
      'paid_course': instance.paidCourse,
      'paid_certificate': instance.paidCertificate,
      'course_price': instance.coursePrice,
      'currency': instance.currency,
      'amount_usd': instance.amountUsd,
      'enable_certification': instance.enableCertification,
      'lessons': instance.lessons,
      'enrollments': instance.enrollments,
      'rating': instance.rating,
      'instructors': instance.instructors,
      'membership': instance.membership,
      'rating_count': instance.ratingCount,
      'owner': instance.owner,
      'creation': instance.creation,
    };

ChapterSummaryModel _$ChapterSummaryModelFromJson(Map<String, dynamic> json) =>
    ChapterSummaryModel(
      idx: (json['idx'] as num).toInt(),
      name: json['name'] as String,
      title: json['title'] as String,
      isScormPackage: (json['is_scorm_package'] as num?)?.toInt() ?? 0,
      lessonCount: (json['lesson_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ChapterSummaryModelToJson(
  ChapterSummaryModel instance,
) => <String, dynamic>{
  'idx': instance.idx,
  'name': instance.name,
  'title': instance.title,
  'is_scorm_package': instance.isScormPackage,
  'lesson_count': instance.lessonCount,
};

LessonSummaryModel _$LessonSummaryModelFromJson(Map<String, dynamic> json) =>
    LessonSummaryModel(
      idx: (json['idx'] as num).toInt(),
      name: json['name'] as String,
      title: json['title'] as String,
      includeInPreview: (json['include_in_preview'] as num).toInt(),
      body: json['body'] as String?,
      content: json['content'] as String?,
      youtube: json['youtube'] as String?,
      quizId: json['quiz_id'] as String?,
      question: json['question'] as String?,
      fileType: json['file_type'] as String,
      icon: json['icon'] as String,
      course: json['course'] as String?,
    );

Map<String, dynamic> _$LessonSummaryModelToJson(LessonSummaryModel instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'name': instance.name,
      'title': instance.title,
      'include_in_preview': instance.includeInPreview,
      'body': instance.body,
      'content': instance.content,
      'youtube': instance.youtube,
      'quiz_id': instance.quizId,
      'question': instance.question,
      'file_type': instance.fileType,
      'icon': instance.icon,
      'course': instance.course,
    };

ChapterDetailModel _$ChapterDetailModelFromJson(Map<String, dynamic> json) =>
    ChapterDetailModel(
      name: json['name'] as String,
      title: json['title'] as String,
      course: json['course'] as String,
      isScormPackage: (json['is_scorm_package'] as num).toInt(),
      scormPackagePath: json['scorm_package_path'] as String?,
      launchFile: json['launch_file'] as String?,
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => LessonSummaryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChapterDetailModelToJson(ChapterDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'course': instance.course,
      'is_scorm_package': instance.isScormPackage,
      'scorm_package_path': instance.scormPackagePath,
      'launch_file': instance.launchFile,
      'lessons': instance.lessons,
    };

LessonDetailModel _$LessonDetailModelFromJson(Map<String, dynamic> json) =>
    LessonDetailModel(
      name: json['name'] as String,
      title: json['title'] as String,
      chapter: json['chapter'] as String,
      course: json['course'] as String,
      includeInPreview: (json['include_in_preview'] as num).toInt(),
      body: json['body'] as String?,
      content: json['content'] as String?,
      instructorContent: json['instructor_content'] as String?,
      instructorNotes: json['instructor_notes'] as String?,
      youtube: json['youtube'] as String?,
      quizId: json['quiz_id'] as String?,
      question: json['question'] as String?,
      fileType: json['file_type'] as String,
      creation: json['creation'] as String,
      icon: json['icon'] as String,
      idx: (json['idx'] as num).toInt(),
    );

Map<String, dynamic> _$LessonDetailModelToJson(LessonDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'chapter': instance.chapter,
      'course': instance.course,
      'include_in_preview': instance.includeInPreview,
      'body': instance.body,
      'content': instance.content,
      'instructor_content': instance.instructorContent,
      'instructor_notes': instance.instructorNotes,
      'youtube': instance.youtube,
      'quiz_id': instance.quizId,
      'question': instance.question,
      'file_type': instance.fileType,
      'creation': instance.creation,
      'icon': instance.icon,
      'idx': instance.idx,
    };

ListCoursesResponseData _$ListCoursesResponseDataFromJson(
  Map<String, dynamic> json,
) => ListCoursesResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ListCoursesResponseDataToJson(
  ListCoursesResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

GetCourseResponseData _$GetCourseResponseDataFromJson(
  Map<String, dynamic> json,
) => GetCourseResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: CourseModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GetCourseResponseDataToJson(
  GetCourseResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

CreateCourseResponseData _$CreateCourseResponseDataFromJson(
  Map<String, dynamic> json,
) => CreateCourseResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: CourseModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateCourseResponseDataToJson(
  CreateCourseResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

GetChaptersResponseData _$GetChaptersResponseDataFromJson(
  Map<String, dynamic> json,
) => GetChaptersResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => ChapterSummaryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetChaptersResponseDataToJson(
  GetChaptersResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

GetChapterResponseData _$GetChapterResponseDataFromJson(
  Map<String, dynamic> json,
) => GetChapterResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: ChapterDetailModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GetChapterResponseDataToJson(
  GetChapterResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

CreateChapterResponseData _$CreateChapterResponseDataFromJson(
  Map<String, dynamic> json,
) => CreateChapterResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: ChapterSummaryModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateChapterResponseDataToJson(
  CreateChapterResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

GetLessonsResponseData _$GetLessonsResponseDataFromJson(
  Map<String, dynamic> json,
) => GetLessonsResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => LessonSummaryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetLessonsResponseDataToJson(
  GetLessonsResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

GetLessonResponseData _$GetLessonResponseDataFromJson(
  Map<String, dynamic> json,
) => GetLessonResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: LessonDetailModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GetLessonResponseDataToJson(
  GetLessonResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

CreateLessonResponseData _$CreateLessonResponseDataFromJson(
  Map<String, dynamic> json,
) => CreateLessonResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: LessonSummaryModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateLessonResponseDataToJson(
  CreateLessonResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

MyCoursesData _$MyCoursesDataFromJson(Map<String, dynamic> json) =>
    MyCoursesData(
      role: json['role'] as String,
      courses: (json['courses'] as List<dynamic>)
          .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyCoursesDataToJson(MyCoursesData instance) =>
    <String, dynamic>{'role': instance.role, 'courses': instance.courses};

MyCoursesResponseData _$MyCoursesResponseDataFromJson(
  Map<String, dynamic> json,
) => MyCoursesResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: MyCoursesData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MyCoursesResponseDataToJson(
  MyCoursesResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

UploadFileMessage _$UploadFileMessageFromJson(Map<String, dynamic> json) =>
    UploadFileMessage(
      fileUrl: json['file_url'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UploadFileMessageToJson(UploadFileMessage instance) =>
    <String, dynamic>{'file_url': instance.fileUrl, 'name': instance.name};

UploadFileResponseData _$UploadFileResponseDataFromJson(
  Map<String, dynamic> json,
) => UploadFileResponseData(
  message: UploadFileMessage.fromJson(json['message'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UploadFileResponseDataToJson(
  UploadFileResponseData instance,
) => <String, dynamic>{'message': instance.message};
