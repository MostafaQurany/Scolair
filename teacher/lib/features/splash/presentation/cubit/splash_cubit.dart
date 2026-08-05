import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/storage/app_secure_storage.dart';
import '../../../../core/storage/app_shared_preferences.dart';
import '../../../auth/domain/usecases/refresh_token_usecase.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._prefs, this._secureStorage, this._refreshTokenUseCase)
    : super(const SplashState.initial());

  final AppSharedPreferences _prefs;
  final AppSecureStorage _secureStorage;
  final RefreshTokenUseCase _refreshTokenUseCase;

  Future<void> start() async {
    emit(const SplashState.loading());
    await Future<void>.delayed(const Duration(seconds: 2));

    final isFirstTime = _prefs.isFirstTime;
    if (isFirstTime) {
      emit(const SplashState.navigate(AppRouteNames.onboarding));
      return;
    }

    final refreshToken = await _secureStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      emit(const SplashState.navigate(AppRouteNames.login));
      return;
    }

    final result = await _refreshTokenUseCase(refreshToken);
    result.when(
      success: (_) {
        final destination = _prefs.biometricEnabled
            ? AppRouteNames.biometricUnlock
            : AppRouteNames.homeLayout;
        emit(SplashState.navigate(destination));
      },
      failure: (_) {
        _secureStorage.clearAll();
        emit(const SplashState.navigate(AppRouteNames.login));
      },
    );
  }
}
