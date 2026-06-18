import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/storage/app_shared_preferences.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._prefs) : super(const OnboardingState.initial(0));

  final AppSharedPreferences _prefs;

  void changePage(int index) => emit(OnboardingState.initial(index));

  Future<void> finish() async {
    await _prefs.setFirstTime(false);
    emit(const OnboardingState.navigate(AppRouteNames.home));
  }
}
