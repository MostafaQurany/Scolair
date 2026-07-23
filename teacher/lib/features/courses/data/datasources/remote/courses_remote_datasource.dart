import 'dart:convert';


import '../../../../../core/network/api_client.dart';
import '../../models/courses_models.dart';

abstract class CoursesRemoteDataSource {
  Future<ListCoursesResponseData> listCourses({
    String searchText = '',
    bool? publishedFilter,
    int start = 0,
    int pageSize = 30,
  });
  Future<GetCourseResponseData> getCourse(String courseName);
  Future<CreateCourseResponseData> createCourse(Map<String, dynamic> body);
  Future<CreateCourseResponseData> updateCourse(Map<String, dynamic> body);
  Future<void> deleteCourse(Map<String, dynamic> body);
  Future<GetChaptersResponseData> getChapters(
    String courseName, {
    int start = 0,
    int pageSize = 30,
  });
  Future<GetChapterResponseData> getChapter(String chapterName);
  Future<CreateChapterResponseData> createChapter(Map<String, dynamic> body);
  Future<void> updateChapter(Map<String, dynamic> body);
  Future<void> deleteChapter(Map<String, dynamic> body);
  Future<GetLessonsResponseData> getLessons(
    String chapterName, {
    int start = 0,
    int pageSize = 30,
  });
  Future<GetLessonResponseData> getLesson(String lessonName);
  Future<CreateLessonResponseData> createLesson(Map<String, dynamic> body);

  Future<void> updateLesson(Map<String, dynamic> body);
  Future<void> deleteLesson(Map<String, dynamic> body);
  Future<MyCoursesResponseData> myCourses();
  Future<MyCoursesResponseData> sharedCourses();
  Future<GetStudentsResponseData> getStudents(String courseName);
  Future<void> addStudent(Map<String, dynamic> body);
  Future<void> removeStudent(Map<String, dynamic> body);
  Future<GetInstructorsResponseData> getInstructors(String courseName);
  Future<void> addInstructor(Map<String, dynamic> body);
  Future<void> removeInstructor(Map<String, dynamic> body);
}

class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  const CoursesRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<ListCoursesResponseData> listCourses({
    String searchText = '',
    bool? publishedFilter,
    int start = 0,
    int pageSize = 30,
  }) {
    final trimmedSearch = searchText.trim();
    final filters = <String, dynamic>{
      if (publishedFilter != null) 'published': publishedFilter ? 1 : 0,
      if (trimmedSearch.isNotEmpty) 'name': ['like', '%$trimmedSearch%'],
    };

    return _apiClient.listCourses(
      filters.isEmpty ? null : jsonEncode(filters),
      start,
      pageSize,
    );
  }

  @override
  Future<GetCourseResponseData> getCourse(String courseName) =>
      _apiClient.getCourse(courseName);

  @override
  Future<CreateCourseResponseData> createCourse(Map<String, dynamic> body) =>
      _apiClient.createCourse(body);

  @override
  Future<CreateCourseResponseData> updateCourse(Map<String, dynamic> body) =>
      _apiClient.updateCourse(body);

  @override
  Future<void> deleteCourse(Map<String, dynamic> body) =>
      _apiClient.deleteCourse(body);

  @override
  Future<GetChaptersResponseData> getChapters(
    String courseName, {
    int start = 0,
    int pageSize = 30,
  }) => _apiClient.getChapters(courseName, start, pageSize);

  @override
  Future<GetChapterResponseData> getChapter(String chapterName) =>
      _apiClient.getChapter(chapterName);

  @override
  Future<CreateChapterResponseData> createChapter(Map<String, dynamic> body) =>
      _apiClient.createChapter(body);

  @override
  Future<void> updateChapter(Map<String, dynamic> body) =>
      _apiClient.updateChapter(body);

  @override
  Future<void> deleteChapter(Map<String, dynamic> body) =>
      _apiClient.deleteChapter(body);

  @override
  Future<GetLessonsResponseData> getLessons(
    String chapterName, {
    int start = 0,
    int pageSize = 30,
  }) => _apiClient.getLessons(chapterName, start, pageSize);

  @override
  Future<GetLessonResponseData> getLesson(String lessonName) =>
      _apiClient.getLesson(lessonName);

  @override
  Future<CreateLessonResponseData> createLesson(Map<String, dynamic> body) =>
      _apiClient.createLesson(body);


  @override
  Future<void> updateLesson(Map<String, dynamic> body) =>
      _apiClient.updateLesson(body);

  @override
  Future<void> deleteLesson(Map<String, dynamic> body) =>
      _apiClient.deleteLesson(body);

  @override
  Future<MyCoursesResponseData> myCourses() => _apiClient.myCourses();

  @override
  Future<MyCoursesResponseData> sharedCourses() => _apiClient.sharedCourses();

  @override
  Future<GetStudentsResponseData> getStudents(String courseName) =>
      _apiClient.getStudents(courseName);

  @override
  Future<void> addStudent(Map<String, dynamic> body) =>
      _apiClient.addStudent(body);

  @override
  Future<void> removeStudent(Map<String, dynamic> body) =>
      _apiClient.removeStudent(body);

  @override
  Future<GetInstructorsResponseData> getInstructors(String courseName) =>
      _apiClient.getInstructors(courseName);

  @override
  Future<void> addInstructor(Map<String, dynamic> body) =>
      _apiClient.addInstructor(body);

  @override
  Future<void> removeInstructor(Map<String, dynamic> body) =>
      _apiClient.removeInstructor(body);
}
