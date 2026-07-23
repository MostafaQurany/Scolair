
import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../data/models/courses_models.dart';

abstract class CoursesRepository {
  Future<ApiResult<PaginatedList<CourseModel>>> listCourses({
    String searchText = '',
    bool? publishedFilter,
    int start = 0,
    int pageSize = 30,
  });
  Future<ApiResult<CourseModel>> getCourse(String courseName);
  Future<ApiResult<CourseModel>> createCourse({
    required String title,
    required String description,
    required String shortIntroduction,
    required String tags,
    required bool published,
    required String videoLink,
    String? image,
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
    String? image,
    bool? enableCertification,
  });
  Future<ApiResult<void>> deleteCourse(String courseName);
  Future<ApiResult<PaginatedList<ChapterSummaryModel>>> getChapters(
    String courseName, {
    int start = 0,
    int pageSize = 30,
  });
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
  Future<ApiResult<PaginatedList<LessonSummaryModel>>> getLessons(
    String chapterName, {
    int start = 0,
    int pageSize = 30,
  });
  Future<ApiResult<LessonDetailModel>> getLesson(String lessonName);
  Future<ApiResult<LessonSummaryModel>> createLesson({
    required String title,
    required String chapterName,
    required bool includeInPreview,
    Map<String, dynamic>? content,
  });

  Future<ApiResult<void>> updateLesson({
    required String lessonName,
    required String title,
    required bool includeInPreview,
    Map<String, dynamic>? content,
  });
  Future<ApiResult<void>> deleteLesson({
    required String lessonName,
    required String chapterName,
  });
  Future<ApiResult<MyCoursesData>> myCourses();
  Future<ApiResult<MyCoursesData>> sharedCourses();
  Future<ApiResult<List<StudentModel>>> getStudents(String courseName);
  Future<ApiResult<void>> addStudent({
    required String courseName,
    required String studentEmail,
  });
  Future<ApiResult<void>> removeStudent({
    required String courseName,
    required String studentEmail,
  });
  Future<ApiResult<List<InstructorModel>>> getInstructors(String courseName);
  Future<ApiResult<void>> addInstructor({
    required String courseName,
    required String instructorEmail,
  });
  Future<ApiResult<void>> removeInstructor({
    required String courseName,
    required String instructorEmail,
  });
}
