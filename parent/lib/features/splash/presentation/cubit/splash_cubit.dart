import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/storage/app_shared_preferences.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.prefs) : super(const SplashState.initial());

  final AppSharedPreferences prefs;

  Future<void> start() async {
    emit(const SplashState.loading());
    await Future.delayed(const Duration(seconds: 2));
    final isFirstTime = prefs.isFirstTime;
    if (isFirstTime) {
      emit(SplashState.navigate(AppRouteNames.onboarding));
    } else {
      //TODO:- if he already login (from token expired or not and use refresh to get new token) go to home else go to login screen
      emit(SplashState.navigate(AppRouteNames.login));
    }
  }
}
