import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../core/storage/app_shared_preferences.dart';
import 'biometric_request_state.dart';

class BiometricRequestCubit extends Cubit<BiometricRequestState> {
  BiometricRequestCubit(this._prefs)
      : super(const BiometricRequestState.initial());

  final AppSharedPreferences _prefs;
  final _auth = LocalAuthentication();

  Future<void> enableBiometric({required bool dontShowAgain}) async {
    emit(const BiometricRequestState.loading());

    final canAuth =
        await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    if (!canAuth) {
      emit(const BiometricRequestState.unavailable());
      return;
    }

    try {
      final ok = await _auth.authenticate(
        localizedReason: 'Enable biometric login for your account',
      );
      if (ok) {
        await _prefs.setBiometricEnabled(true);
        if (dontShowAgain) await _prefs.setBiometricDontShow(true);
        emit(const BiometricRequestState.enabled());
      } else {
        emit(const BiometricRequestState.failed('cancelled'));
      }
    } on Object catch (e) {
      emit(BiometricRequestState.failed(e.toString()));
    }
  }

  Future<void> dismiss({required bool dontShowAgain}) async {
    if (dontShowAgain) await _prefs.setBiometricDontShow(true);
    emit(const BiometricRequestState.dismissed());
  }
}
