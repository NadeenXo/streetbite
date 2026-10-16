import '../../../core/errors/failures.dart';
import '../../../l10n/app_localizations.dart';

class AuthFailureMessage {
  AuthFailureMessage._();

  static String forFailure(Failure failure, AppLocalizations l10n) {
    if (failure is NetworkFailure) return l10n.authNetworkError;
    if (failure is AuthFailure) {
      switch (failure.code) {
        case 'email-already-in-use':
          return l10n.authEmailInUse;
        case 'invalid-email':
          return l10n.authInvalidEmail;
        case 'weak-password':
          return l10n.authWeakPassword;
        case 'invalid-credential':
        case 'wrong-password':
        case 'user-not-found':
          return l10n.authInvalidCredentials;
        case 'profile-not-found':
          return l10n.authMissingProfile;
        case 'permission-denied':
          return l10n.authPermissionError;
        case 'network-request-failed':
          return l10n.authNetworkError;
        default:
          return l10n.authGenericError;
      }
    }
    return l10n.authGenericError;
  }
}
