import 'dart:io';

import '../../../../core/network/api_result.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_settings_repository.dart';

class GetUserProfileUseCase {
  const GetUserProfileUseCase(this._repository);
  final ProfileSettingsRepository _repository;

  Future<ApiResult<UserProfile>> call() => _repository.getUserInfo();
}

class EditUserProfileUseCase {
  const EditUserProfileUseCase(this._repository);
  final ProfileSettingsRepository _repository;

  Future<ApiResult<UserProfile>> call({
    String? firstName,
    String? lastName,
    String? headline,
    String? bio,
    String? openTo,
    String? linkedin,
    String? github,
    String? twitter,
    String? language,
  }) => _repository.editProfile(
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
}

class UploadProfileImageUseCase {
  const UploadProfileImageUseCase(this._repository);
  final ProfileSettingsRepository _repository;

  Future<ApiResult<String>> call(File file) =>
      _repository.uploadProfileImage(file);
}
