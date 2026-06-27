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
    await Future.delayed(const Duration(seconds: 2));

    final isFirstTime = _prefs.isFirstTime;
    if (isFirstTime) {
      emit(SplashState.navigate(AppRouteNames.onboarding));
      return;
    }

    final refreshToken = await _secureStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      emit(SplashState.navigate(AppRouteNames.login));
      return;
    }

    final result = await _refreshTokenUseCase(refreshToken);
    result.when(
      success: (_) => emit(SplashState.navigate(AppRouteNames.homeLayout)),
      failure: (_) {
        _secureStorage.clearAll();
        emit(SplashState.navigate(AppRouteNames.login));
      },
    );
  }
}
