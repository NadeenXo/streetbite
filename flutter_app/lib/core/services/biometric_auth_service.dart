import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  final LocalAuthentication _auth;

  BiometricAuthService(this._auth);

  Future<bool> authenticate() async {
    if (kIsWeb) return false;

    try {
      final available = await _auth.isDeviceSupported();
      final canCheck = await _auth.canCheckBiometrics;

      if (!available || !canCheck) {
        return false;
      }

      final biometrics = await _auth.getAvailableBiometrics();

      if (!biometrics.contains(BiometricType.fingerprint) &&
          !biometrics.contains(BiometricType.strong)) {
        return false;
      }

      return await _auth.authenticate(
        localizedReason:
            'Verify your fingerprint to open your StreetBite profile',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } catch (_) {
      return false;
    }
  }
}
