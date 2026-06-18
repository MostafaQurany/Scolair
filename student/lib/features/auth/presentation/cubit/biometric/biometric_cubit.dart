import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import 'biometric_state.dart';

class BiometricCubit extends Cubit<BiometricState> {
  BiometricCubit() : super(const BiometricState.initial());

  final _auth = LocalAuthentication();

  Future<void> checkAndAuthenticate(String localizedReason) async {
    emit(const BiometricState.checking());
    final canAuthenticate =
        await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

    if (!canAuthenticate) {
      emit(const BiometricState.unavailable());
      return;
    }

    try {
      final ok = await _auth.authenticate(localizedReason: localizedReason);
      emit(
        ok
            ? const BiometricState.authenticated()
            : const BiometricState.failed('cancelled'),
      );
    } on Object catch (error) {
      emit(BiometricState.failed(error.toString()));
    }
  }
}
