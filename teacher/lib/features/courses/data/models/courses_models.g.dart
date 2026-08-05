// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorModel _$InstructorModelFromJson(Map<String, dynamic> json) =>
    InstructorModel(
      name: _stringFromJson(json['name']),
      username: _nullableStringFromJson(json['username']),
      fullName: _nullableStringFromJson(json['full_name']),
      userImage: _nullableStringFromJson(json['user_image']),
      firstName: _nullableStringFromJson(json['first_name']),
      bio: _nullableStringFromJson(json['bio']),
      instructor: _nullableStringFromJson(json['instructor']),
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
      name: _stringFromJson(json['name']),
      progress: _doubleFromJson(json['progress']),
      member: _stringFromJson(json['member']),
      course: _stringFromJson(json['course']),
      purchasedCertificate: _intFromJson(json['purchased_certificate']),
      currentLesson: _nullableStringFromJson(json['current_lesson']),
      certificate: _nullableStringFromJson(json['certificate']),
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
  name: _stringFromJson(json['name']),
  title: _stringFromJson(json['title']),
  tags: _nullableStringFromJson(json['tags']),
  image: _nullableStringFromJson(json['image']),
  videoLink: _nullableStringFromJson(json['video_link']),
  cardGradient: _nullableStringFromJson(json['card_gradient']),
  shortIntroduction: _nullableStringFromJson(json['short_introduction']),
  description: _nullableStringFromJson(json['description']),
  published: _nullableIntFromJson(json['published']),
  upcoming: _nullableIntFromJson(json['upcoming']),
  featured: _nullableIntFromJson(json['featured']),
  disableSelfLearning: _nullableIntFromJson(json['disable_self_learning']),
  publishedOn: _nullableStringFromJson(json['published_on']),
  category: _nullableStringFromJson(json['category']),
  status: _nullableStringFromJson(json['status']),
  paidCourse: _nullableIntFromJson(json['paid_course']),
  paidCertificate: _nullableIntFromJson(json['paid_certificate']),
  coursePrice: _nullableDoubleFromJson(json['course_price']),
  currency: _nullableStringFromJson(json['currency']),
  amountUsd: _nullableDoubleFromJson(json['amount_usd']),
  enableCertification: _nullableIntFromJson(json['enable_certification']),
  lessons: _nullableIntFromJson(json['lessons']),
  enrollments: _nullableIntFromJson(json['enrollments']),
  rating: json['rating'],
  instructors: _instructorsFromJson(json['instructors']),
  membership: _membershipFromJson(json['membership']),
  ratingCount: _nullableIntFromJson(json['rating_count']),
  owner: _nullableStringFromJson(json['owner']),
  creation: _nullableStringFromJson(json['creation']),
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
      idx: _intFromJson(json['idx']),
      name: _stringFromJson(json['name']),
      title: _stringFromJson(json['title']),
      isScormPackage: _intFromJson(json['is_scorm_package']),
      lessonCount: _intFromJson(json['lesson_count']),
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
      idx: _intFromJson(json['idx']),
      name: _stringFromJson(json['name']),
      title: _stringFromJson(json['title']),
      includeInPreview: _intFromJson(json['include_in_preview']),
      fileType: _stringFromJson(json['file_type']),
      icon: _stringFromJson(json['icon']),
      body: _nullableStringFromJson(json['body']),
      content: _nullableStringFromJson(json['content']),
      youtube: _nullableStringFromJson(json['youtube']),
      quizId: _nullableStringFromJson(json['quiz_id']),
      question: _nullableStringFromJson(json['question']),
      course: _nullableStringFromJson(json['course']),
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
      name: _stringFromJson(json['name']),
      title: _stringFromJson(json['title']),
      course: _stringFromJson(json['course']),
      isScormPackage: _intFromJson(json['is_scorm_package']),
      lessons: _lessonSummaryListFromJson(json['lessons']),
      scormPackagePath: _nullableStringFromJson(json['scorm_package_path']),
      launchFile: _nullableStringFromJson(json['launch_file']),
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
      name: _stringFromJson(json['name']),
      title: _stringFromJson(json['title']),
      chapter: _stringFromJson(json['chapter']),
      course: _stringFromJson(json['course']),
      includeInPreview: _intFromJson(json['include_in_preview']),
      fileType: _stringFromJson(json['file_type']),
      creation: _stringFromJson(json['creation']),
      icon: _stringFromJson(json['icon']),
      idx: _intFromJson(json['idx']),
      body: _nullableStringFromJson(json['body']),
      content: _nullableStringFromJson(json['content']),
      instructorContent: _nullableStringFromJson(json['instructor_content']),
      instructorNotes: _nullableStringFromJson(json['instructor_notes']),
      youtube: _nullableStringFromJson(json['youtube']),
      quizId: _nullableStringFromJson(json['quiz_id']),
      question: _nullableStringFromJson(json['question']),
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
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _paginatedCoursesFromJson(json['data']),
);

Map<String, dynamic> _$ListCoursesResponseDataToJson(
  ListCoursesResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': _paginatedCoursesToJson(instance.data),
};

GetCourseResponseData _$GetCourseResponseDataFromJson(
  Map<String, dynamic> json,
) => GetCourseResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _courseFromJson(json['data']),
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
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _courseFromJson(json['data']),
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
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _paginatedChaptersFromJson(json['data']),
);

Map<String, dynamic> _$GetChaptersResponseDataToJson(
  GetChaptersResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': _paginatedChaptersToJson(instance.data),
};

GetChapterResponseData _$GetChapterResponseDataFromJson(
  Map<String, dynamic> json,
) => GetChapterResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _chapterDetailFromJson(json['data']),
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
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _chapterSummaryFromJson(json['data']),
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
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _paginatedLessonsFromJson(json['data']),
);

Map<String, dynamic> _$GetLessonsResponseDataToJson(
  GetLessonsResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': _paginatedLessonsToJson(instance.data),
};

GetLessonResponseData _$GetLessonResponseDataFromJson(
  Map<String, dynamic> json,
) => GetLessonResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _lessonDetailFromJson(json['data']),
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
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _lessonSummaryFromJson(json['data']),
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
      role: _stringFromJson(json['role']),
      courses: _courseListFromJson(json['courses']),
    );

Map<String, dynamic> _$MyCoursesDataToJson(MyCoursesData instance) =>
    <String, dynamic>{'role': instance.role, 'courses': instance.courses};

MyCoursesResponseData _$MyCoursesResponseDataFromJson(
  Map<String, dynamic> json,
) => MyCoursesResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _myCoursesDataFromJson(json['data']),
);

Map<String, dynamic> _$MyCoursesResponseDataToJson(
  MyCoursesResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
  name: _stringFromJson(json['name']),
  member: _nullableStringFromJson(json['member']),
  memberName: _nullableStringFromJson(json['member_name']),
  memberUsername: _nullableStringFromJson(json['member_username']),
  memberImage: _nullableStringFromJson(json['member_image']),
  progress: _nullableDoubleFromJson(json['progress']),
  currentLesson: _nullableStringFromJson(json['current_lesson']),
  creation: _nullableStringFromJson(json['creation']),
);

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'member': instance.member,
      'member_name': instance.memberName,
      'member_username': instance.memberUsername,
      'member_image': instance.memberImage,
      'progress': instance.progress,
      'current_lesson': instance.currentLesson,
      'creation': instance.creation,
    };

GetStudentsResponseData _$GetStudentsResponseDataFromJson(
  Map<String, dynamic> json,
) => GetStudentsResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _studentsListFromJson(json['data']),
);

Map<String, dynamic> _$GetStudentsResponseDataToJson(
  GetStudentsResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

GetInstructorsResponseData _$GetInstructorsResponseDataFromJson(
  Map<String, dynamic> json,
) => GetInstructorsResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _instructorsListFromJson(json['data']),
);

Map<String, dynamic> _$GetInstructorsResponseDataToJson(
  GetInstructorsResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};
