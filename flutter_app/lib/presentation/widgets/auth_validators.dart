import '../../../l10n/app_localizations.dart';

class AuthValidators {
  AuthValidators._();

  static String? name(String? value, AppLocalizations l10n) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return l10n.authRequiredName;
    // Check that the first alphabetical character is an uppercase Latin letter.
    // This matches the assignment's capital-first-letter requirement for English names.
    final first = text[0];
    if (!RegExp(r'^[A-Z]').hasMatch(first)) return l10n.authCapitalName;
    return null;
  }

  static String? email(String? value, AppLocalizations l10n) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return l10n.authRequiredEmail;
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(text)) {
      return l10n.authInvalidEmail;
    }
    return null;
  }

  static String? password(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.authRequiredPassword;
    if (value.length < 6) return l10n.authShortPassword;
    return null;
  }

  static String? confirm(
    String? value,
    String password,
    AppLocalizations l10n,
  ) {
    if (value == null || value.isEmpty) return l10n.authConfirmRequired;
    if (value != password) return l10n.authPasswordsMismatch;
    return null;
  }
}
