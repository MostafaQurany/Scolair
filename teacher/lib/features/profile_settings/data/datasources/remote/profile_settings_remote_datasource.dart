import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../core/network/api_client.dart';
import '../../models/edit_profile_request_data.dart';
import '../../models/upload_profile_image_response_data.dart';
import '../../models/user_profile_response_data.dart';

abstract class ProfileSettingsRemoteDataSource {
  Future<UserProfileResponseData> getUserInfo();
  Future<UserProfileResponseData> editProfile(EditProfileRequestData request);
  Future<UploadProfileImageResponseData> uploadProfileImage(File file);
}

class ProfileSettingsRemoteDataSourceImpl
    implements ProfileSettingsRemoteDataSource {
  const ProfileSettingsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<UserProfileResponseData> getUserInfo() => _apiClient.getUserInfo();

  @override
  Future<UserProfileResponseData> editProfile(EditProfileRequestData request) =>
      _apiClient.editProfile(request);

  @override
  Future<UploadProfileImageResponseData> uploadProfileImage(File file) async {
    final multipartFile = await MultipartFile.fromFile(file.path);
    return _apiClient.uploadProfileImage(file: multipartFile);
  }
}
