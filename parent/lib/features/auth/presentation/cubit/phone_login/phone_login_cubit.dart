import 'package:flutter_bloc/flutter_bloc.dart';

import 'phone_login_state.dart';

// Phone login flow is not part of the current API integration.
// This cubit is kept as a no-op stub to preserve the existing screen.
class PhoneLoginCubit extends Cubit<PhoneLoginState> {
  PhoneLoginCubit() : super(const PhoneLoginState.initial());

  Future<void> sendOtp(String countryCode, String phone) async {
    emit(const PhoneLoginState.loading());
    emit(const PhoneLoginState.error('Phone login is not supported'));
  }
}
