import 'package:local_auth/local_auth.dart';

/// Whether the device has biometric hardware available, regardless of
/// whether the user has enrolled a fingerprint/face yet.
Future<bool> isBiometricAvailable(LocalAuthentication auth) async =>
    await auth.canCheckBiometrics || await auth.isDeviceSupported();
