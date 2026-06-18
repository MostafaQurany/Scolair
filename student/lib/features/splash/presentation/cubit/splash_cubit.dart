import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_route_names.dart';
import '../../../../core/storage/app_shared_preferences.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AppSharedPreferences prefs;

  SplashCubit(this.prefs) : super(SplashInitial());

  Future<void> start() async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 2));

    final isFirstTime = prefs.isFirstTime;

    if (isFirstTime) {
      emit(SplashNavigate(AppRouteNames.onboarding));
    } else {
      emit(SplashNavigate(AppRouteNames.home));
    }
  }
}