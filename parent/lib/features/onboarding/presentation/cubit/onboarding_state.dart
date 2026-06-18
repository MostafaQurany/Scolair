import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

@freezed
sealed class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial(int pageIndex) = _Initial;
  const factory OnboardingState.navigate(String route) = _Navigate;
}
