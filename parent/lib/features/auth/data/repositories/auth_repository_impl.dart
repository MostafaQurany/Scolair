import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/storage/app_secure_storage.dart';
import '../../domain/entities/auth_token.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../models/change_password_request_data.dart';
import '../models/forgot_password_request_data.dart';
import '../models/google_login_request_data.dart';
import '../models/login_request_data.dart';
import '../models/login_response_data.dart';
import '../models/logout_request_data.dart';
import '../models/otp_verify_request_data.dart';
import '../models/refresh_token_request_data.dart';
import '../models/register_request_data.dart';
import '../models/reset_password_request_data.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource, this._secureStorage);

  final AuthRemoteDataSource _remoteDataSource;
  final AppSecureStorage _secureStorage;

  @override
  Future<ApiResult<void>> register(
    String fullName,
    String email,
    String password,
    bool verifyTerms,
  ) => _voidResult(
    () => _remoteDataSource.register(
      RegisterRequestData(
        email: email,
        fullName: fullName,
        verifyTerms: verifyTerms ? 1 : 0,
        password: password,
      ),
    ),
  );

  @override
  Future<ApiResult<AuthToken>> login(String username, String password) =>
      _authResult(
        () => _remoteDataSource.login(
          LoginRequestData(username: username, password: password),
        ),
        (r) => _tokenFromResponse(r),
      );

  @override
  Future<ApiResult<AuthToken>> googleLogin(String idToken) => _authResult(
    () =>
        _remoteDataSource.googleLogin(GoogleLoginRequestData(idToken: idToken)),
    (r) => _tokenFromResponse(r),
  );

  @override
  Future<ApiResult<AuthToken>> refreshToken(String refreshToken) =>
      _authResult(() async {
        final response = await _remoteDataSource.refreshToken(
          RefreshTokenRequestData(refreshToken: refreshToken),
        );
        await _secureStorage.saveAccessToken(response.data.accessToken);
        await _secureStorage.saveRefreshToken(response.data.refreshToken);
        return LoginResponseData(
          state: response.state,
          message: response.message,
          data: LoginTokenData(
            accessToken: response.data.accessToken,
            refreshToken: response.data.refreshToken,
            expiresIn: response.data.expiresIn,
            tokenType: 'Bearer',
            scope: '',
          ),
        );
      }, (r) => _tokenFromResponse(r));

  @override
  Future<ApiResult<void>> logout(String accessToken) => _voidResult(
    () => _remoteDataSource.logout(LogoutRequestData(token: accessToken)),
  );

  @override
  Future<ApiResult<String>> forgotPasswordSendOtp(String email) async {
    try {
      final response = await _remoteDataSource.forgotPasswordSendOtp(
        ForgotPasswordRequestData(email: email),
      );
      return ApiSuccess(response.data.sessionId);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<String>> forgotPasswordVerifyOtp(
    String sessionId,
    String otp,
  ) async {
    try {
      final response = await _remoteDataSource.forgotPasswordVerifyOtp(
        OtpVerifyRequestData(sessionId: sessionId, otp: otp),
      );
      return ApiSuccess(response.data.resetToken);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> forgotPasswordReset(
    String resetToken,
    String newPassword,
  ) => _voidResult(
    () => _remoteDataSource.forgotPasswordReset(
      ResetPasswordRequestData(
        resetToken: resetToken,
        newPassword: newPassword,
      ),
    ),
  );

  @override
  Future<ApiResult<void>> changePassword(
    String oldPassword,
    String newPassword,
  ) => _voidResult(
    () => _remoteDataSource.changePassword(
      ChangePasswordRequestData(
        oldPassword: oldPassword,
        newPassword: newPassword,
      ),
    ),
  );

  Future<ApiResult<AuthToken>> _authResult<T>(
    Future<T> Function() call,
    AuthToken Function(T) map,
  ) async {
    try {
      final result = await call();
      final token = map(result);
      await _secureStorage.saveAccessToken(token.accessToken);
      await _secureStorage.saveRefreshToken(token.refreshToken);
      return ApiSuccess(token);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> _voidResult(Future<void> Function() call) async {
    try {
      await call();
      return const ApiSuccess(null);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  AuthToken _tokenFromResponse(LoginResponseData r) => AuthToken(
    accessToken: r.data.accessToken,
    refreshToken: r.data.refreshToken,
  );
}
