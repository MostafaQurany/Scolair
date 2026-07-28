import 'dart:io';

import '../../../../core/network/api_result.dart';
import '../entities/user_profile.dart';

abstract class ProfileSettingsRepository {
  Future<ApiResult<UserProfile>> getUserInfo();
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
  });
  Future<ApiResult<String>> uploadProfileImage(File file);
}
