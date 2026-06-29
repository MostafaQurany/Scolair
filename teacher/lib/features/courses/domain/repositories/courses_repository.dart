import 'dart:io';
import '../../../../core/network/api_result.dart';
import '../../data/models/courses_models.dart';

abstract class CoursesRepository {
  Future<ApiResult<List<CourseModel>>> listCourses({
    String searchText = '',
    bool? publishedFilter,
  });
  Future<ApiResult<CourseModel>> getCourse(String courseName);
  Future<ApiResult<CourseModel>> createCourse({
    required String title,
    required String description,
    required String shortIntroduction,
    required String tags,
    required bool published,
    required String videoLink,
    required bool enableCertification,
  });
  Future<ApiResult<CourseModel>> updateCourse({
    required String courseName,
    required String title,
    String? description,
    String? shortIntroduction,
    String? tags,
    bool? published,
    String? videoLink,
    bool? enableCertification,
  });
  Future<ApiResult<void>> deleteCourse(String courseName);
  Future<ApiResult<List<ChapterSummaryModel>>> getChapters(String courseName);
  Future<ApiResult<ChapterDetailModel>> getChapter(String chapterName);
  Future<ApiResult<ChapterSummaryModel>> createChapter({
    required String title,
    required String courseName,
    required bool isScormPackage,
  });
  Future<ApiResult<void>> updateChapter({
    required String chapterName,
    required String title,
  });
  Future<ApiResult<void>> deleteChapter(String chapterName);
  Future<ApiResult<List<LessonSummaryModel>>> getLessons(String chapterName);
  Future<ApiResult<LessonDetailModel>> getLesson(String lessonName);
  Future<ApiResult<LessonSummaryModel>> createLesson({
    required String title,
    required String chapterName,
    required bool includeInPreview,
    Map<String, dynamic>? content,
  });
  Future<ApiResult<String>> uploadFile({
    required File file,
    required int isPrivate,
    required String doctype,
    required String docname,
    required String fieldname,
  });
  Future<ApiResult<void>> updateLesson({
    required String lessonName,
    required String title,
    required bool includeInPreview,
    Map<String, dynamic>? content,
  });
  Future<ApiResult<void>> deleteLesson(String lessonName);
  Future<ApiResult<MyCoursesData>> myCourses();
}
