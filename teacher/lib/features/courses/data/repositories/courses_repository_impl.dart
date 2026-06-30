import 'dart:io';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repositories/courses_repository.dart';
import '../datasources/remote/courses_remote_datasource.dart';
import '../models/courses_models.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  const CoursesRepositoryImpl(this._remoteDataSource);

  final CoursesRemoteDataSource _remoteDataSource;

  Future<ApiResult<T>> _getResult<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return ApiSuccess(result);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<CourseModel>>> listCourses({
    String searchText = '',
    bool? publishedFilter,
  }) => _getResult(
    () async => (await _remoteDataSource.listCourses(
      searchText: searchText,
      publishedFilter: publishedFilter,
    )).data,
  );

  @override
  Future<ApiResult<CourseModel>> getCourse(String courseName) => _getResult(
    () async => (await _remoteDataSource.getCourse(courseName)).data,
  );

  @override
  Future<ApiResult<CourseModel>> createCourse({
    required String title,
    required String description,
    required String shortIntroduction,
    required String tags,
    required bool published,
    required String videoLink,
    String? image,
    required bool enableCertification,
  }) => _getResult(() async {
    final body = {
      'title': title,
      'description': description,
      'short_introduction': shortIntroduction,
      'tags': tags,
      'published': published,
      'video_link': videoLink,
      'image': ?image,
      'enable_certification': enableCertification,
    };
    final response = await _remoteDataSource.createCourse(body);
    return response.data;
  });

  @override
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
  }) => _getResult(() async {
    final body = <String, dynamic>{
      'course': courseName,
      'title': title,
      'description': ?description,
      'short_introduction': ?shortIntroduction,
      'tags': ?tags,
      'published': ?published,
      'video_link': ?videoLink,
      'image': ?image,
      'enable_certification': ?enableCertification,
    };
    final response = await _remoteDataSource.updateCourse(body);
    return response.data;
  });

  @override
  Future<ApiResult<void>> deleteCourse(String courseName) =>
      _getResult(() => _remoteDataSource.deleteCourse({'course': courseName}));

  @override
  Future<ApiResult<List<ChapterSummaryModel>>> getChapters(String courseName) =>
      _getResult(() async {
        final response = await _remoteDataSource.getChapters(courseName);
        return response.data;
      });

  @override
  Future<ApiResult<ChapterDetailModel>> getChapter(String chapterName) =>
      _getResult(() async {
        final response = await _remoteDataSource.getChapter(chapterName);
        return response.data;
      });

  @override
  Future<ApiResult<ChapterSummaryModel>> createChapter({
    required String title,
    required String courseName,
    required bool isScormPackage,
  }) => _getResult(() async {
    final response = await _remoteDataSource.createChapter({
      'title': title,
      'course': courseName,
      'is_scorm_package': isScormPackage,
    });
    return response.data;
  });

  @override
  Future<ApiResult<void>> updateChapter({
    required String chapterName,
    required String title,
  }) => _getResult(
    () => _remoteDataSource.updateChapter({
      'chapter': chapterName,
      'title': title,
    }),
  );

  @override
  Future<ApiResult<void>> deleteChapter(String chapterName) => _getResult(
    () => _remoteDataSource.deleteChapter({'chapter': chapterName}),
  );

  @override
  Future<ApiResult<List<LessonSummaryModel>>> getLessons(String chapterName) =>
      _getResult(() async {
        final response = await _remoteDataSource.getLessons(chapterName);
        return response.data;
      });

  @override
  Future<ApiResult<LessonDetailModel>> getLesson(String lessonName) =>
      _getResult(() async {
        final response = await _remoteDataSource.getLesson(lessonName);
        return response.data;
      });

  @override
  Future<ApiResult<LessonSummaryModel>> createLesson({
    required String title,
    required String chapterName,
    required bool includeInPreview,
    Map<String, dynamic>? content,
  }) => _getResult(() async {
    final body = {
      'title': title,
      'chapter': chapterName,
      'include_in_preview': includeInPreview,
      'content': ?content,
    };
    final response = await _remoteDataSource.createLesson(body);
    return response.data;
  });

  @override
  Future<ApiResult<String>> uploadFile({
    required File file,
    required int isPrivate,
    required String doctype,
    required String docname,
    required String fieldname,
  }) => _getResult(() async {
    final response = await _remoteDataSource.uploadFile(
      file: file,
      isPrivate: isPrivate,
      doctype: doctype,
      docname: docname,
      fieldname: fieldname,
    );
    return response.message.fileUrl;
  });

  @override
  Future<ApiResult<void>> updateLesson({
    required String lessonName,
    required String title,
    required bool includeInPreview,
    Map<String, dynamic>? content,
  }) => _getResult(
    () => _remoteDataSource.updateLesson({
      'lesson': lessonName,
      'title': title,
      'include_in_preview': includeInPreview,
      'content': ?content,
    }),
  );

  @override
  Future<ApiResult<void>> deleteLesson(String lessonName) =>
      _getResult(() => _remoteDataSource.deleteLesson({'lesson': lessonName}));

  @override
  Future<ApiResult<MyCoursesData>> myCourses() =>
      _getResult(() async => (await _remoteDataSource.myCourses()).data);
}
