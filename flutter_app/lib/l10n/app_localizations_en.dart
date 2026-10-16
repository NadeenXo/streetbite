// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'StreetBite';

  @override
  String get homeTitle => 'StreetBite Home';

  @override
  String get counterMessage => 'You have pushed the button this many times:';

  @override
  String get increment => 'Increment';

  @override
  String get settings => 'Settings';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get authLogin => 'Log in';

  @override
  String get authSignUp => 'Sign up';

  @override
  String get authWelcome => 'Welcome to StreetBite';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authFullName => 'Full name';

  @override
  String get authConfirmPassword => 'Confirm password';

  @override
  String get authShowPassword => 'Show password';

  @override
  String get authHidePassword => 'Hide password';

  @override
  String get authCreateAccount => 'Create an account';

  @override
  String get authLogout => 'Log out';

  @override
  String get authTryAgain => 'Try again';

  @override
  String authSignedInAs(String name) {
    return 'Welcome, $name';
  }

  @override
  String get authRequiredName => 'Please enter your full name.';

  @override
  String get authCapitalName =>
      'Start your name with a capital English letter.';

  @override
  String get authRequiredEmail => 'Please enter your email.';

  @override
  String get authInvalidEmail => 'Please enter a valid email.';

  @override
  String get authRequiredPassword => 'Please enter your password.';

  @override
  String get authShortPassword => 'Password must be at least 6 characters.';

  @override
  String get authConfirmRequired => 'Please confirm your password.';

  @override
  String get authPasswordsMismatch => 'Passwords do not match.';

  @override
  String get authNetworkError =>
      'Check your internet connection and try again.';

  @override
  String get authEmailInUse => 'This email is already registered.';

  @override
  String get authWeakPassword => 'Choose a stronger password.';

  @override
  String get authInvalidCredentials => 'Incorrect email or password.';

  @override
  String get authMissingProfile =>
      'Your account exists, but your profile could not be loaded. Please contact support.';

  @override
  String get authPermissionError => 'Unable to access your profile.';

  @override
  String get authGenericError => 'Something went wrong. Please try again.';

  @override
  String get featuredMeals => 'Featured Meals';

  @override
  String get hotOffers => 'Hot Offers';

  @override
  String get exploreMeals => 'Explore Meals';

  @override
  String get noMealsAvailable => 'No meals available';

  @override
  String get retry => 'Try Again';

  @override
  String get mealLoadError => 'Unable to load meals. Please try again.';

  @override
  String get checkInternet => 'Check your internet connection and try again.';

  @override
  String get mealCategoryUnknown => 'Other';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get addToCart => 'Add to Cart';
}
