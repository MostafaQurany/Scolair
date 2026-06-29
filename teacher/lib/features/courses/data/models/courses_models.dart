import 'package:json_annotation/json_annotation.dart';

part 'courses_models.g.dart';

@JsonSerializable()
class InstructorModel {
  const InstructorModel({
    required this.name,
    this.username,
    this.fullName,
    this.userImage,
    this.firstName,
    this.bio,
    this.instructor,
  });

  final String name;
  final String? username;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'user_image')
  final String? userImage;
  @JsonKey(name: 'first_name')
  final String? firstName;
  final String? bio;
  final String? instructor;

  factory InstructorModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstructorModelToJson(this);
}

@JsonSerializable()
class MembershipModel {
  const MembershipModel({
    required this.name,
    this.currentLesson,
    required this.progress,
    required this.member,
    required this.course,
    required this.purchasedCertificate,
    this.certificate,
  });

  final String name;
  @JsonKey(name: 'current_lesson')
  final String? currentLesson;
  final double progress;
  final String member;
  final String course;
  @JsonKey(name: 'purchased_certificate')
  final int purchasedCertificate;
  final String? certificate;

  factory MembershipModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipModelFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipModelToJson(this);
}

@JsonSerializable()
class CourseModel {
  const CourseModel({
    required this.name,
    required this.title,
    this.tags,
    this.image,
    this.videoLink,
    this.cardGradient,
    this.shortIntroduction,
    this.description,
    this.published,
    this.upcoming,
    this.featured,
    this.disableSelfLearning,
    this.publishedOn,
    this.category,
    this.status,
    this.paidCourse,
    this.paidCertificate,
    this.coursePrice,
    this.currency,
    this.amountUsd,
    this.enableCertification,
    this.lessons,
    this.enrollments,
    this.rating,
    this.instructors,
    this.membership,
    this.ratingCount,
    this.owner,
    this.creation,
  });

  final String name;
  final String title;
  final String? tags;
  final String? image;
  @JsonKey(name: 'video_link')
  final String? videoLink;
  @JsonKey(name: 'card_gradient')
  final String? cardGradient;
  @JsonKey(name: 'short_introduction')
  final String? shortIntroduction;
  final String? description;
  final int? published;
  final int? upcoming;
  final int? featured;
  @JsonKey(name: 'disable_self_learning')
  final int? disableSelfLearning;
  @JsonKey(name: 'published_on')
  final String? publishedOn;
  final String? category;
  final String? status;
  @JsonKey(name: 'paid_course')
  final int? paidCourse;
  @JsonKey(name: 'paid_certificate')
  final int? paidCertificate;
  @JsonKey(name: 'course_price')
  final double? coursePrice;
  final String? currency;
  @JsonKey(name: 'amount_usd')
  final double? amountUsd;
  @JsonKey(name: 'enable_certification')
  final int? enableCertification;
  final int? lessons;
  final int? enrollments;
  final dynamic rating; // can be String or number from API
  final List<InstructorModel>? instructors;
  @JsonKey(fromJson: _membershipFromJson)
  final MembershipModel? membership;
  @JsonKey(name: 'rating_count')
  final int? ratingCount;
  final String? owner;
  final String? creation;

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}

MembershipModel? _membershipFromJson(Object? json) {
  if (json is Map<String, dynamic>) {
    return MembershipModel.fromJson(json);
  }

  return null;
}

@JsonSerializable()
class ChapterSummaryModel {
  const ChapterSummaryModel({
    required this.idx,
    required this.name,
    required this.title,
    required this.isScormPackage,
    required this.lessonCount,
  });

  final int idx;
  final String name;
  final String title;
  @JsonKey(name: 'is_scorm_package', defaultValue: 0)
  final int isScormPackage;
  @JsonKey(name: 'lesson_count', defaultValue: 0)
  final int lessonCount;

  factory ChapterSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterSummaryModelToJson(this);
}

@JsonSerializable()
class LessonSummaryModel {
  const LessonSummaryModel({
    required this.idx,
    required this.name,
    required this.title,
    required this.includeInPreview,
    this.body,
    this.content,
    this.youtube,
    this.quizId,
    this.question,
    required this.fileType,
    required this.icon,
    this.course,
  });

  final int idx;
  final String name;
  final String title;
  @JsonKey(name: 'include_in_preview')
  final int includeInPreview;
  final String? body;
  final String? content; // serialized Editor.js JSON
  final String? youtube;
  @JsonKey(name: 'quiz_id')
  final String? quizId;
  final String? question;
  @JsonKey(name: 'file_type')
  final String fileType;
  final String icon;
  final String? course;

  factory LessonSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$LessonSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonSummaryModelToJson(this);
}

@JsonSerializable()
class ChapterDetailModel {
  const ChapterDetailModel({
    required this.name,
    required this.title,
    required this.course,
    required this.isScormPackage,
    this.scormPackagePath,
    this.launchFile,
    required this.lessons,
  });

  final String name;
  final String title;
  final String course;
  @JsonKey(name: 'is_scorm_package')
  final int isScormPackage;
  @JsonKey(name: 'scorm_package_path')
  final String? scormPackagePath;
  @JsonKey(name: 'launch_file')
  final String? launchFile;
  final List<LessonSummaryModel> lessons;

  factory ChapterDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterDetailModelToJson(this);
}

@JsonSerializable()
class LessonDetailModel {
  const LessonDetailModel({
    required this.name,
    required this.title,
    required this.chapter,
    required this.course,
    required this.includeInPreview,
    this.body,
    this.content,
    this.instructorContent,
    this.instructorNotes,
    this.youtube,
    this.quizId,
    this.question,
    required this.fileType,
    required this.creation,
    required this.icon,
    required this.idx,
  });

  final String name;
  final String title;
  final String chapter;
  final String course;
  @JsonKey(name: 'include_in_preview')
  final int includeInPreview;
  final String? body;
  final String? content; // serialized Editor.js JSON
  @JsonKey(name: 'instructor_content')
  final String? instructorContent;
  @JsonKey(name: 'instructor_notes')
  final String? instructorNotes;
  final String? youtube;
  @JsonKey(name: 'quiz_id')
  final String? quizId;
  final String? question;
  @JsonKey(name: 'file_type')
  final String fileType;
  final String creation;
  final String icon;
  final int idx;

  factory LessonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$LessonDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonDetailModelToJson(this);
}

// --- Response Wrappers ---

@JsonSerializable()
class ListCoursesResponseData {
  const ListCoursesResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final List<CourseModel> data;

  factory ListCoursesResponseData.fromJson(Map<String, dynamic> json) =>
      _$ListCoursesResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListCoursesResponseDataToJson(this);
}

@JsonSerializable()
class GetCourseResponseData {
  const GetCourseResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final CourseModel data;

  factory GetCourseResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetCourseResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetCourseResponseDataToJson(this);
}

@JsonSerializable()
class CreateCourseResponseData {
  const CreateCourseResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final CourseModel data;

  factory CreateCourseResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateCourseResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCourseResponseDataToJson(this);
}

@JsonSerializable()
class GetChaptersResponseData {
  const GetChaptersResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final List<ChapterSummaryModel> data;

  factory GetChaptersResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetChaptersResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetChaptersResponseDataToJson(this);
}

@JsonSerializable()
class GetChapterResponseData {
  const GetChapterResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final ChapterDetailModel data;

  factory GetChapterResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetChapterResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetChapterResponseDataToJson(this);
}

@JsonSerializable()
class CreateChapterResponseData {
  const CreateChapterResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final ChapterSummaryModel data;

  factory CreateChapterResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateChapterResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateChapterResponseDataToJson(this);
}

@JsonSerializable()
class GetLessonsResponseData {
  const GetLessonsResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final List<LessonSummaryModel> data;

  factory GetLessonsResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetLessonsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetLessonsResponseDataToJson(this);
}

@JsonSerializable()
class GetLessonResponseData {
  const GetLessonResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final LessonDetailModel data;

  factory GetLessonResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetLessonResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetLessonResponseDataToJson(this);
}

@JsonSerializable()
class CreateLessonResponseData {
  const CreateLessonResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final LessonSummaryModel data;

  factory CreateLessonResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateLessonResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLessonResponseDataToJson(this);
}

@JsonSerializable()
class MyCoursesData {
  const MyCoursesData({required this.role, required this.courses});

  final String role;
  final List<CourseModel> courses;

  factory MyCoursesData.fromJson(Map<String, dynamic> json) =>
      _$MyCoursesDataFromJson(json);

  Map<String, dynamic> toJson() => _$MyCoursesDataToJson(this);
}

@JsonSerializable()
class MyCoursesResponseData {
  const MyCoursesResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final MyCoursesData data;

  factory MyCoursesResponseData.fromJson(Map<String, dynamic> json) =>
      _$MyCoursesResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$MyCoursesResponseDataToJson(this);
}

@JsonSerializable()
class UploadFileMessage {
  const UploadFileMessage({required this.fileUrl, this.name});

  @JsonKey(name: 'file_url')
  final String fileUrl;
  final String? name;

  factory UploadFileMessage.fromJson(Map<String, dynamic> json) =>
      _$UploadFileMessageFromJson(json);

  Map<String, dynamic> toJson() => _$UploadFileMessageToJson(this);
}

@JsonSerializable()
class UploadFileResponseData {
  const UploadFileResponseData({required this.message});

  final UploadFileMessage message;

  factory UploadFileResponseData.fromJson(Map<String, dynamic> json) =>
      _$UploadFileResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$UploadFileResponseDataToJson(this);
}
