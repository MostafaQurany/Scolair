import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/network/paginated_list.dart';

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

  @JsonKey(fromJson: _stringFromJson)
  final String name;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? username;
  @JsonKey(name: 'full_name', fromJson: _nullableStringFromJson)
  final String? fullName;
  @JsonKey(name: 'user_image', fromJson: _nullableStringFromJson)
  final String? userImage;
  @JsonKey(name: 'first_name', fromJson: _nullableStringFromJson)
  final String? firstName;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? bio;
  @JsonKey(fromJson: _nullableStringFromJson)
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

  @JsonKey(fromJson: _stringFromJson)
  final String name;
  @JsonKey(name: 'current_lesson', fromJson: _nullableStringFromJson)
  final String? currentLesson;
  @JsonKey(fromJson: _doubleFromJson)
  final double progress;
  @JsonKey(fromJson: _stringFromJson)
  final String member;
  @JsonKey(fromJson: _stringFromJson)
  final String course;
  @JsonKey(name: 'purchased_certificate', fromJson: _intFromJson)
  final int purchasedCertificate;
  @JsonKey(fromJson: _nullableStringFromJson)
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

  @JsonKey(fromJson: _stringFromJson)
  final String name;
  @JsonKey(fromJson: _stringFromJson)
  final String title;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? tags;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? image;
  @JsonKey(name: 'video_link', fromJson: _nullableStringFromJson)
  final String? videoLink;
  @JsonKey(name: 'card_gradient', fromJson: _nullableStringFromJson)
  final String? cardGradient;
  @JsonKey(name: 'short_introduction', fromJson: _nullableStringFromJson)
  final String? shortIntroduction;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? description;
  @JsonKey(fromJson: _nullableIntFromJson)
  final int? published;
  @JsonKey(fromJson: _nullableIntFromJson)
  final int? upcoming;
  @JsonKey(fromJson: _nullableIntFromJson)
  final int? featured;
  @JsonKey(name: 'disable_self_learning', fromJson: _nullableIntFromJson)
  final int? disableSelfLearning;
  @JsonKey(name: 'published_on', fromJson: _nullableStringFromJson)
  final String? publishedOn;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? category;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? status;
  @JsonKey(name: 'paid_course', fromJson: _nullableIntFromJson)
  final int? paidCourse;
  @JsonKey(name: 'paid_certificate', fromJson: _nullableIntFromJson)
  final int? paidCertificate;
  @JsonKey(name: 'course_price', fromJson: _nullableDoubleFromJson)
  final double? coursePrice;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? currency;
  @JsonKey(name: 'amount_usd', fromJson: _nullableDoubleFromJson)
  final double? amountUsd;
  @JsonKey(name: 'enable_certification', fromJson: _nullableIntFromJson)
  final int? enableCertification;
  @JsonKey(fromJson: _nullableIntFromJson)
  final int? lessons;
  @JsonKey(fromJson: _nullableIntFromJson)
  final int? enrollments;
  final dynamic rating; // can be String or number from API
  @JsonKey(fromJson: _instructorsFromJson)
  final List<InstructorModel>? instructors;
  @JsonKey(fromJson: _membershipFromJson)
  final MembershipModel? membership;
  @JsonKey(name: 'rating_count', fromJson: _nullableIntFromJson)
  final int? ratingCount;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? owner;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? creation;

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
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

  @JsonKey(fromJson: _intFromJson)
  final int idx;
  @JsonKey(fromJson: _stringFromJson)
  final String name;
  @JsonKey(fromJson: _stringFromJson)
  final String title;
  @JsonKey(name: 'is_scorm_package', fromJson: _intFromJson)
  final int isScormPackage;
  @JsonKey(name: 'lesson_count', fromJson: _intFromJson)
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

  @JsonKey(fromJson: _intFromJson)
  final int idx;
  @JsonKey(fromJson: _stringFromJson)
  final String name;
  @JsonKey(fromJson: _stringFromJson)
  final String title;
  @JsonKey(name: 'include_in_preview', fromJson: _intFromJson)
  final int includeInPreview;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? body;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? content; // serialized Editor.js JSON
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? youtube;
  @JsonKey(name: 'quiz_id', fromJson: _nullableStringFromJson)
  final String? quizId;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? question;
  @JsonKey(name: 'file_type', fromJson: _stringFromJson)
  final String fileType;
  @JsonKey(fromJson: _stringFromJson)
  final String icon;
  @JsonKey(fromJson: _nullableStringFromJson)
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

  @JsonKey(fromJson: _stringFromJson)
  final String name;
  @JsonKey(fromJson: _stringFromJson)
  final String title;
  @JsonKey(fromJson: _stringFromJson)
  final String course;
  @JsonKey(name: 'is_scorm_package', fromJson: _intFromJson)
  final int isScormPackage;
  @JsonKey(name: 'scorm_package_path', fromJson: _nullableStringFromJson)
  final String? scormPackagePath;
  @JsonKey(name: 'launch_file', fromJson: _nullableStringFromJson)
  final String? launchFile;
  @JsonKey(fromJson: _lessonSummaryListFromJson)
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

  @JsonKey(fromJson: _stringFromJson)
  final String name;
  @JsonKey(fromJson: _stringFromJson)
  final String title;
  @JsonKey(fromJson: _stringFromJson)
  final String chapter;
  @JsonKey(fromJson: _stringFromJson)
  final String course;
  @JsonKey(name: 'include_in_preview', fromJson: _intFromJson)
  final int includeInPreview;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? body;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? content; // serialized Editor.js JSON
  @JsonKey(name: 'instructor_content', fromJson: _nullableStringFromJson)
  final String? instructorContent;
  @JsonKey(name: 'instructor_notes', fromJson: _nullableStringFromJson)
  final String? instructorNotes;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? youtube;
  @JsonKey(name: 'quiz_id', fromJson: _nullableStringFromJson)
  final String? quizId;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? question;
  @JsonKey(name: 'file_type', fromJson: _stringFromJson)
  final String fileType;
  @JsonKey(fromJson: _stringFromJson)
  final String creation;
  @JsonKey(fromJson: _stringFromJson)
  final String icon;
  @JsonKey(fromJson: _intFromJson)
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

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _paginatedCoursesFromJson, toJson: _paginatedCoursesToJson)
  final PaginatedList<CourseModel> data;

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

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _courseFromJson)
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

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _courseFromJson)
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

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(
    fromJson: _paginatedChaptersFromJson,
    toJson: _paginatedChaptersToJson,
  )
  final PaginatedList<ChapterSummaryModel> data;

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

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _chapterDetailFromJson)
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

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _chapterSummaryFromJson)
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

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _paginatedLessonsFromJson, toJson: _paginatedLessonsToJson)
  final PaginatedList<LessonSummaryModel> data;

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

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _lessonDetailFromJson)
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

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _lessonSummaryFromJson)
  final LessonSummaryModel data;

  factory CreateLessonResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateLessonResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLessonResponseDataToJson(this);
}

@JsonSerializable()
class MyCoursesData {
  const MyCoursesData({required this.role, required this.courses});

  @JsonKey(fromJson: _stringFromJson)
  final String role;
  @JsonKey(fromJson: _courseListFromJson)
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

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _myCoursesDataFromJson)
  final MyCoursesData data;

  factory MyCoursesResponseData.fromJson(Map<String, dynamic> json) =>
      _$MyCoursesResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$MyCoursesResponseDataToJson(this);
}

@JsonSerializable()
class StudentModel {
  const StudentModel({
    required this.name,
    this.member,
    this.memberName,
    this.memberUsername,
    this.memberImage,
    this.progress,
    this.currentLesson,
    this.creation,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String name;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? member;
  @JsonKey(name: 'member_name', fromJson: _nullableStringFromJson)
  final String? memberName;
  @JsonKey(name: 'member_username', fromJson: _nullableStringFromJson)
  final String? memberUsername;
  @JsonKey(name: 'member_image', fromJson: _nullableStringFromJson)
  final String? memberImage;
  @JsonKey(fromJson: _nullableDoubleFromJson)
  final double? progress;
  @JsonKey(name: 'current_lesson', fromJson: _nullableStringFromJson)
  final String? currentLesson;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? creation;

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}

@JsonSerializable()
class GetStudentsResponseData {
  const GetStudentsResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _studentsListFromJson)
  final List<StudentModel> data;

  factory GetStudentsResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetStudentsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetStudentsResponseDataToJson(this);
}

@JsonSerializable()
class GetInstructorsResponseData {
  const GetInstructorsResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _instructorsListFromJson)
  final List<InstructorModel> data;

  factory GetInstructorsResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetInstructorsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetInstructorsResponseDataToJson(this);
}

// --- Safe JSON converters for Frappe dynamic/null responses ---

Map<String, dynamic> _asStringMap(Object? json) {
  if (json is Map) {
    return json.map((key, value) => MapEntry(key.toString(), value));
  }
  return <String, dynamic>{};
}

String _stringFromJson(Object? value) => value?.toString() ?? '';

String? _nullableStringFromJson(Object? value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is Map || value is List) {
    try {
      return jsonEncode(value);
    } catch (_) {
      return value.toString();
    }
  }
  return value.toString();
}

int _intFromJson(Object? value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is bool) return value ? 1 : 0;
  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return 0;
    return int.tryParse(trimmed) ?? double.tryParse(trimmed)?.toInt() ?? 0;
  }
  return 0;
}

int? _nullableIntFromJson(Object? value) {
  if (value == null) return null;
  if (value is String && value.trim().isEmpty) return null;
  return _intFromJson(value);
}

double _doubleFromJson(Object? value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is bool) return value ? 1.0 : 0.0;
  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return 0.0;
    return double.tryParse(trimmed) ?? 0.0;
  }
  return 0.0;
}

double? _nullableDoubleFromJson(Object? value) {
  if (value == null) return null;
  if (value is String && value.trim().isEmpty) return null;
  return _doubleFromJson(value);
}

List<InstructorModel>? _instructorsFromJson(Object? json) {
  if (json is! List) return null;
  return json
      .whereType<Map>()
      .map((item) => InstructorModel.fromJson(_asStringMap(item)))
      .toList();
}

MembershipModel? _membershipFromJson(Object? json) {
  if (json is Map) {
    return MembershipModel.fromJson(_asStringMap(json));
  }
  return null;
}

CourseModel _courseFromJson(Object? json) =>
    CourseModel.fromJson(_asStringMap(json));

ChapterSummaryModel _chapterSummaryFromJson(Object? json) =>
    ChapterSummaryModel.fromJson(_asStringMap(json));

ChapterDetailModel _chapterDetailFromJson(Object? json) =>
    ChapterDetailModel.fromJson(_asStringMap(json));

LessonSummaryModel _lessonSummaryFromJson(Object? json) =>
    LessonSummaryModel.fromJson(_asStringMap(json));

LessonDetailModel _lessonDetailFromJson(Object? json) =>
    LessonDetailModel.fromJson(_asStringMap(json));

MyCoursesData _myCoursesDataFromJson(Object? json) =>
    MyCoursesData.fromJson(_asStringMap(json));

List<CourseModel> _courseListFromJson(Object? json) {
  if (json is! List) return <CourseModel>[];
  return json
      .whereType<Map>()
      .map((item) => CourseModel.fromJson(_asStringMap(item)))
      .toList();
}

List<LessonSummaryModel> _lessonSummaryListFromJson(Object? json) {
  if (json is! List) return <LessonSummaryModel>[];
  return json
      .whereType<Map>()
      .map((item) => LessonSummaryModel.fromJson(_asStringMap(item)))
      .toList();
}

PaginatedList<CourseModel> _paginatedCoursesFromJson(Object? json) =>
    PaginatedList.fromJson(json, _courseFromJson);

Map<String, dynamic> _paginatedCoursesToJson(PaginatedList<CourseModel> data) =>
    {
      'items': data.items.map((e) => e.toJson()).toList(),
      'total': data.total,
      'start': data.start,
      'page_size': data.pageSize,
      'has_next_page': data.hasNextPage,
    };

PaginatedList<LessonSummaryModel> _paginatedLessonsFromJson(Object? json) =>
    PaginatedList.fromJson(json, _lessonSummaryFromJson);

Map<String, dynamic> _paginatedLessonsToJson(
  PaginatedList<LessonSummaryModel> data,
) => {
  'items': data.items.map((e) => e.toJson()).toList(),
  'total': data.total,
  'start': data.start,
  'page_size': data.pageSize,
  'has_next_page': data.hasNextPage,
};

PaginatedList<ChapterSummaryModel> _paginatedChaptersFromJson(Object? json) =>
    PaginatedList.fromJson(json, _chapterSummaryFromJson);

Map<String, dynamic> _paginatedChaptersToJson(
  PaginatedList<ChapterSummaryModel> data,
) => {
  'items': data.items.map((e) => e.toJson()).toList(),
  'total': data.total,
  'start': data.start,
  'page_size': data.pageSize,
  'has_next_page': data.hasNextPage,
};

List<StudentModel> _studentsListFromJson(Object? json) {
  if (json is Map) {
    final items = json['items'];
    if (items is List) {
      return items
          .whereType<Map>()
          .map((item) => StudentModel.fromJson(_asStringMap(item)))
          .toList();
    }
  }
  if (json is List) {
    return json
        .whereType<Map>()
        .map((item) => StudentModel.fromJson(_asStringMap(item)))
        .toList();
  }
  return <StudentModel>[];
}

List<InstructorModel> _instructorsListFromJson(Object? json) {
  if (json is! List) return <InstructorModel>[];
  return json
      .whereType<Map>()
      .map((item) => InstructorModel.fromJson(_asStringMap(item)))
      .toList();
}

