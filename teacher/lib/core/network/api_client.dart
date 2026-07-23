import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/auth/data/models/change_password_request_data.dart';
import '../../features/auth/data/models/forgot_password_request_data.dart';
import '../../features/auth/data/models/forgot_password_send_otp_response_data.dart';
import '../../features/auth/data/models/google_login_request_data.dart';
import '../../features/auth/data/models/login_request_data.dart';
import '../../features/auth/data/models/login_response_data.dart';
import '../../features/auth/data/models/logout_request_data.dart';
import '../../features/auth/data/models/otp_verify_request_data.dart';
import '../../features/auth/data/models/otp_verify_response_data.dart';
import '../../features/auth/data/models/refresh_token_request_data.dart';
import '../../features/auth/data/models/refresh_token_response_data.dart';
import '../../features/auth/data/models/register_request_data.dart';
import '../../features/auth/data/models/register_response_data.dart';
import '../../features/auth/data/models/reset_password_request_data.dart';
import '../../features/courses/data/models/courses_models.dart';
import '../models/upload_file_response.dart';
import '../../features/quiz/data/models/quiz_models.dart';
import 'api_endpoints.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(ApiEndpoints.login)
  Future<LoginResponseData> login(@Body() LoginRequestData request);

  @POST(ApiEndpoints.register)
  Future<RegisterResponseData> register(@Body() RegisterRequestData request);

  @POST(ApiEndpoints.googleLogin)
  Future<LoginResponseData> googleLogin(@Body() GoogleLoginRequestData request);

  @POST(ApiEndpoints.refreshToken)
  Future<RefreshTokenResponseData> refreshToken(
    @Body() RefreshTokenRequestData request,
  );

  @POST(ApiEndpoints.logout)
  Future<void> logout(@Body() LogoutRequestData request);

  @POST(ApiEndpoints.forgotPasswordSendOtp)
  Future<ForgotPasswordSendOtpResponseData> forgotPasswordSendOtp(
    @Body() ForgotPasswordRequestData request,
  );

  @POST(ApiEndpoints.forgotPasswordVerifyOtp)
  Future<OtpVerifyResponseData> forgotPasswordVerifyOtp(
    @Body() OtpVerifyRequestData request,
  );

  @POST(ApiEndpoints.forgotPasswordReset)
  Future<RegisterResponseData> forgotPasswordReset(
    @Body() ResetPasswordRequestData request,
  );

  @POST(ApiEndpoints.changePassword)
  Future<void> changePassword(@Body() ChangePasswordRequestData request);

  @GET(ApiEndpoints.listCourses)
  Future<ListCoursesResponseData> listCourses(
    @Query('filters') String? filters,
    @Query('start') int start,
    @Query('page_size') int pageSize,
  );

  @GET(ApiEndpoints.getCourse)
  Future<GetCourseResponseData> getCourse(@Query('course') String courseName);

  @POST(ApiEndpoints.createCourse)
  Future<CreateCourseResponseData> createCourse(
    @Body() Map<String, dynamic> body,
  );

  @PUT(ApiEndpoints.updateCourse)
  Future<CreateCourseResponseData> updateCourse(
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiEndpoints.deleteCourse)
  Future<void> deleteCourse(@Body() Map<String, dynamic> body);

  @GET(ApiEndpoints.getChapters)
  Future<GetChaptersResponseData> getChapters(
    @Query('course') String courseName,
    @Query('start') int start,
    @Query('page_size') int pageSize,
  );

  @GET(ApiEndpoints.getChapter)
  Future<GetChapterResponseData> getChapter(
    @Query('chapter') String chapterName,
  );

  @POST(ApiEndpoints.createChapter)
  Future<CreateChapterResponseData> createChapter(
    @Body() Map<String, dynamic> body,
  );

  @PUT(ApiEndpoints.updateChapter)
  Future<void> updateChapter(@Body() Map<String, dynamic> body);

  @DELETE(ApiEndpoints.deleteChapter)
  Future<void> deleteChapter(@Body() Map<String, dynamic> body);

  @GET(ApiEndpoints.getLessons)
  Future<GetLessonsResponseData> getLessons(
    @Query('chapter') String chapterName,
    @Query('start') int start,
    @Query('page_size') int pageSize,
  );

  @GET(ApiEndpoints.getLesson)
  Future<GetLessonResponseData> getLesson(@Query('lesson') String lessonName);

  @POST(ApiEndpoints.createLesson)
  Future<CreateLessonResponseData> createLesson(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.uploadFile)
  @MultiPart()
  Future<UploadFileResponseData> uploadFile({
    @Part(name: 'file') required MultipartFile file,
    @Part(name: 'is_private') required int isPrivate,
  });

  @PUT(ApiEndpoints.updateLesson)
  Future<void> updateLesson(@Body() Map<String, dynamic> body);

  @DELETE(ApiEndpoints.deleteLesson)
  Future<void> deleteLesson(@Body() Map<String, dynamic> body);

  @GET(ApiEndpoints.myCourses)
  Future<MyCoursesResponseData> myCourses();

  @GET(ApiEndpoints.sharedCourses)
  Future<MyCoursesResponseData> sharedCourses();

  @GET(ApiEndpoints.getStudents)
  Future<GetStudentsResponseData> getStudents(
    @Query('course') String courseName,
  );

  @POST(ApiEndpoints.addStudent)
  Future<void> addStudent(@Body() Map<String, dynamic> body);

  @DELETE(ApiEndpoints.removeStudent)
  Future<void> removeStudent(@Body() Map<String, dynamic> body);

  @GET(ApiEndpoints.getInstructors)
  Future<GetInstructorsResponseData> getInstructors(
    @Query('course') String courseName,
  );

  @POST(ApiEndpoints.addInstructor)
  Future<void> addInstructor(@Body() Map<String, dynamic> body);

  @DELETE(ApiEndpoints.removeInstructor)
  Future<void> removeInstructor(@Body() Map<String, dynamic> body);

  // === Quiz — Questions ===

  @GET(ApiEndpoints.listQuestions)
  Future<ListQuestionsResponseData> listQuestions(
    @Query('type') String? type,
    @Query('quiz') String? quiz,
    @Query('homework') String? homework,
    @Query('lesson') String? lesson,
    @Query('chapter') String? chapter,
    @Query('course') String? course,
    @Query('start') int start,
    @Query('page_size') int pageSize,
  );

  @GET(ApiEndpoints.getQuestion)
  Future<GetQuestionResponseData> getQuestion(
    @Query('question') String questionName,
  );

  @POST(ApiEndpoints.createQuestion)
  Future<CreateQuestionResponseData> createQuestion(
    @Body() Map<String, dynamic> body,
  );

  @PUT(ApiEndpoints.updateQuestion)
  Future<UpdateQuestionResponseData> updateQuestion(
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiEndpoints.deleteQuestion)
  Future<DeleteQuestionResponseData> deleteQuestion(
    @Query('question') String questionName,
  );

  // === Quiz — Quizzes ===

  @GET(ApiEndpoints.listQuizzes)
  Future<ListQuizzesResponseData> listQuizzes(
    @Query('start') int start,
    @Query('page_size') int pageSize,
  );

  @GET(ApiEndpoints.getQuiz)
  Future<GetQuizResponseData> getQuiz(@Query('quiz') String quizName);

  @POST(ApiEndpoints.createQuiz)
  Future<CreateQuizResponseData> createQuiz(@Body() Map<String, dynamic> body);

  @PUT(ApiEndpoints.updateQuiz)
  Future<UpdateQuizResponseData> updateQuiz(@Body() Map<String, dynamic> body);

  @DELETE(ApiEndpoints.deleteQuiz)
  Future<DeleteQuizResponseData> deleteQuiz(@Body() Map<String, dynamic> body);

  // === Quiz — Quiz-Question link ===

  @POST(ApiEndpoints.addQuestionToQuiz)
  Future<AddQuestionToQuizResponseData> addQuestionToQuiz(
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiEndpoints.removeQuestionFromQuiz)
  Future<RemoveQuestionFromQuizResponseData> removeQuestionFromQuiz(
    @Body() Map<String, dynamic> body,
  );
}
