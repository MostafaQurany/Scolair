import 'dart:io';
import '../../../../core/network/api_result.dart';
import '../../data/models/courses_models.dart';
import '../repositories/courses_repository.dart';

class ListCoursesUseCase {
  const ListCoursesUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<List<CourseModel>>> call({
    String searchText = '',
    bool? publishedFilter,
  }) => _repository.listCourses(
    searchText: searchText,
    publishedFilter: publishedFilter,
  );
}

class GetCourseUseCase {
  const GetCourseUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<CourseModel>> call(String courseName) =>
      _repository.getCourse(courseName);
}

class CreateCourseUseCase {
  const CreateCourseUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<CourseModel>> call({
    required String title,
    required String description,
    required String shortIntroduction,
    required String tags,
    required bool published,
    required String videoLink,
    String? image,
    required bool enableCertification,
  }) => _repository.createCourse(
    title: title,
    description: description,
    shortIntroduction: shortIntroduction,
    tags: tags,
    published: published,
    videoLink: videoLink,
    image: image,
    enableCertification: enableCertification,
  );
}

class UpdateCourseUseCase {
  const UpdateCourseUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<CourseModel>> call({
    required String courseName,
    required String title,
    String? description,
    String? shortIntroduction,
    String? tags,
    bool? published,
    String? videoLink,
    String? image,
    bool? enableCertification,
  }) => _repository.updateCourse(
    courseName: courseName,
    title: title,
    description: description,
    shortIntroduction: shortIntroduction,
    tags: tags,
    published: published,
    videoLink: videoLink,
    image: image,
    enableCertification: enableCertification,
  );
}

class DeleteCourseUseCase {
  const DeleteCourseUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<void>> call(String courseName) =>
      _repository.deleteCourse(courseName);
}

class GetChaptersUseCase {
  const GetChaptersUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<List<ChapterSummaryModel>>> call(String courseName) =>
      _repository.getChapters(courseName);
}

class GetChapterUseCase {
  const GetChapterUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<ChapterDetailModel>> call(String chapterName) =>
      _repository.getChapter(chapterName);
}

class CreateChapterUseCase {
  const CreateChapterUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<ChapterSummaryModel>> call({
    required String title,
    required String courseName,
    required bool isScormPackage,
  }) => _repository.createChapter(
    title: title,
    courseName: courseName,
    isScormPackage: isScormPackage,
  );
}

class UpdateChapterUseCase {
  const UpdateChapterUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<void>> call({
    required String chapterName,
    required String title,
  }) => _repository.updateChapter(chapterName: chapterName, title: title);
}

class DeleteChapterUseCase {
  const DeleteChapterUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<void>> call(String chapterName) =>
      _repository.deleteChapter(chapterName);
}

class GetLessonsUseCase {
  const GetLessonsUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<List<LessonSummaryModel>>> call(String chapterName) =>
      _repository.getLessons(chapterName);
}

class GetLessonUseCase {
  const GetLessonUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<LessonDetailModel>> call(String lessonName) =>
      _repository.getLesson(lessonName);
}

class CreateLessonUseCase {
  const CreateLessonUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<LessonSummaryModel>> call({
    required String title,
    required String chapterName,
    required bool includeInPreview,
    Map<String, dynamic>? content,
  }) => _repository.createLesson(
    title: title,
    chapterName: chapterName,
    includeInPreview: includeInPreview,
    content: content,
  );
}

class UploadFileUseCase {
  const UploadFileUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<String>> call({
    required File file,
    required int isPrivate,
    required String doctype,
    required String docname,
    required String fieldname,
  }) => _repository.uploadFile(
    file: file,
    isPrivate: isPrivate,
    doctype: doctype,
    docname: docname,
    fieldname: fieldname,
  );
}

class UpdateLessonUseCase {
  const UpdateLessonUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<void>> call({
    required String lessonName,
    required String title,
    required bool includeInPreview,
    Map<String, dynamic>? content,
  }) => _repository.updateLesson(
    lessonName: lessonName,
    title: title,
    includeInPreview: includeInPreview,
    content: content,
  );
}

class DeleteLessonUseCase {
  const DeleteLessonUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<void>> call(String lessonName) =>
      _repository.deleteLesson(lessonName);
}

class GetMyCoursesUseCase {
  const GetMyCoursesUseCase(this._repository);
  final CoursesRepository _repository;
  Future<ApiResult<MyCoursesData>> call() => _repository.myCourses();
}
