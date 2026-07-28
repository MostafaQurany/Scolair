import 'dart:io';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/storage/app_shared_preferences.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_settings_repository.dart';
import '../datasources/remote/profile_settings_remote_datasource.dart';
import '../models/edit_profile_request_data.dart';

class ProfileSettingsRepositoryImpl implements ProfileSettingsRepository {
  const ProfileSettingsRepositoryImpl(
    this._remoteDataSource,
    this._preferences,
  );

  final ProfileSettingsRemoteDataSource _remoteDataSource;
  final AppSharedPreferences _preferences;

  Future<ApiResult<T>> _getResult<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return ApiSuccess(result);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  Future<void> _syncSharedPreferences(UserProfile profile) async {
    await _preferences.saveUserData(
      name: profile.name ?? '',
      email: profile.email ?? '',
      username: profile.username ?? '',
      fullName: profile.fullName ?? profile.displayedName,
      roles: profile.roles,
      userImage: profile.displayImageUrl,
    );
  }

  @override
  Future<ApiResult<UserProfile>> getUserInfo() => _getResult(() async {
    final response = await _remoteDataSource.getUserInfo();
    final profile = response.toDomain();
    await _syncSharedPreferences(profile);
    return profile;
  });

  @override
  Future<ApiResult<UserProfile>> editProfile({
    String? firstName,
    String? lastName,
    String? headline,
    String? bio,
    String? openTo,
    String? linkedin,
    String? github,
    String? twitter,
    String? language,
  }) => _getResult(() async {
    final request = EditProfileRequestData(
      firstName: firstName,
      lastName: lastName,
      headline: headline,
      bio: bio,
      openTo: openTo,
      linkedin: linkedin,
      github: github,
      twitter: twitter,
      language: language,
    );
    final response = await _remoteDataSource.editProfile(request);
    final profile = response.toDomain();
    await _syncSharedPreferences(profile);
    return profile;
  });

  @override
  Future<ApiResult<String>> uploadProfileImage(File file) =>
      _getResult(() async {
        final response = await _remoteDataSource.uploadProfileImage(file);
        final url = response.fileUrl ?? response.userImage ?? '';
        if (url.isNotEmpty) {
          final currentName = _preferences.getUserName() ?? '';
          final currentEmail = _preferences.getUserEmail() ?? '';
          final currentUsername = _preferences.getUsername() ?? '';
          final currentFullName = _preferences.getFullName() ?? '';
          final currentRoles = _preferences.getUserRoles();
          await _preferences.saveUserData(
            name: currentName,
            email: currentEmail,
            username: currentUsername,
            fullName: currentFullName,
            roles: currentRoles,
            userImage: url,
          );
        }
        return url;
      });
}
