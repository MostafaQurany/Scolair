// ignore_for_file: prefer_initializing_formals
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/profile_usecases.dart';
import 'authenticated_user_state.dart';

class AuthenticatedUserCubit extends Cubit<AuthenticatedUserState> {
  AuthenticatedUserCubit({
    required GetUserProfileUseCase getUserProfileUseCase,
    required EditUserProfileUseCase editUserProfileUseCase,
    required UploadProfileImageUseCase uploadProfileImageUseCase,
  }) : _getUserProfileUseCase = getUserProfileUseCase,
       _editUserProfileUseCase = editUserProfileUseCase,
       _uploadProfileImageUseCase = uploadProfileImageUseCase,
       super(const AuthenticatedUserState.initial());

  final GetUserProfileUseCase _getUserProfileUseCase;
  final EditUserProfileUseCase _editUserProfileUseCase;
  final UploadProfileImageUseCase _uploadProfileImageUseCase;

  UserProfile? _currentProfile;
  UserProfile? get currentProfile => _currentProfile;

  void clear() {
    _currentProfile = null;
    emit(const AuthenticatedUserState.initial());
  }

  Future<void> fetchProfile() async {
    if (_currentProfile == null) {
      emit(const AuthenticatedUserState.loading());
    } else {
      emit(AuthenticatedUserState.loaded(_currentProfile!, isUpdating: true));
    }

    final result = await _getUserProfileUseCase();
    result.when(
      success: (profile) {
        _currentProfile = profile;
        emit(AuthenticatedUserState.loaded(profile));
      },
      failure: (error) {
        if (_currentProfile == null) {
          emit(AuthenticatedUserState.error(error.message));
        } else {
          emit(AuthenticatedUserState.loaded(_currentProfile!));
        }
      },
    );
  }

  Future<void> _refreshProfileSilently({
    UserProfile Function(UserProfile serverProfile)? reconcile,
  }) async {
    if (_currentProfile == null) return;

    final result = await _getUserProfileUseCase();
    result.when(
      success: (profile) {
        final latestProfile = reconcile?.call(profile) ?? profile;
        _currentProfile = latestProfile;
        emit(AuthenticatedUserState.loaded(latestProfile));
      },
      failure: (_) {
        // Keep the latest visible profile when a background refresh fails.
        if (_currentProfile != null) {
          emit(AuthenticatedUserState.loaded(_currentProfile!));
        }
      },
    );
  }

  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? headline,
    String? bio,
    String? openTo,
    String? linkedin,
    String? github,
    String? twitter,
    String? language,
  }) async {
    final previousProfile = _currentProfile;
    final optimisticFullName =
        _currentProfile != null && (firstName != null || lastName != null)
        ? '${firstName ?? _currentProfile!.firstName ?? ''} '
                  '${lastName ?? _currentProfile!.lastName ?? ''}'
              .trim()
        : null;
    if (_currentProfile != null) {
      _currentProfile = _currentProfile!.copyWith(
        fullName: optimisticFullName,
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
      emit(AuthenticatedUserState.loaded(_currentProfile!, isUpdating: true));
    } else {
      emit(const AuthenticatedUserState.loading());
    }

    final result = await _editUserProfileUseCase(
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

    return result.when(
      success: (profile) {
        _currentProfile = profile;
        final reconciledProfile = profile.copyWith(
          fullName: optimisticFullName,
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
        _currentProfile = reconciledProfile;
        emit(
          AuthenticatedUserState.loaded(reconciledProfile, isUpdating: true),
        );
        _refreshProfileSilently(
          reconcile: (serverProfile) => serverProfile.copyWith(
            fullName: optimisticFullName,
            firstName: firstName,
            lastName: lastName,
            headline: headline,
            bio: bio,
            openTo: openTo,
            linkedin: linkedin,
            github: github,
            twitter: twitter,
            language: language,
          ),
        );
        return true;
      },
      failure: (error) {
        _currentProfile = previousProfile;
        emit(
          AuthenticatedUserState.error(error.message, profile: previousProfile),
        );
        return false;
      },
    );
  }

  Future<bool> uploadAvatar(File file) async {
    if (_currentProfile != null) {
      emit(AuthenticatedUserState.loaded(_currentProfile!, isUpdating: true));
    } else {
      emit(const AuthenticatedUserState.loading());
    }

    final uploadResult = await _uploadProfileImageUseCase(file);
    return uploadResult.when(
      success: (url) {
        if (_currentProfile != null) {
          _currentProfile = _currentProfile!.copyWith(
            userImage: url,
            profileImage: url,
          );
          emit(
            AuthenticatedUserState.loaded(_currentProfile!, isUpdating: true),
          );
          _refreshProfileSilently(
            reconcile: (serverProfile) =>
                serverProfile.copyWith(userImage: url, profileImage: url),
          );
        } else {
          fetchProfile();
        }
        return true;
      },
      failure: (error) {
        emit(
          AuthenticatedUserState.error(error.message, profile: _currentProfile),
        );
        return false;
      },
    );
  }
}
