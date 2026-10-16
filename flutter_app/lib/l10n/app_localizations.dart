import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'StreetBite'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'StreetBite Home'**
  String get homeTitle;

  /// No description provided for @counterMessage.
  ///
  /// In en, this message translates to:
  /// **'You have pushed the button this many times:'**
  String get counterMessage;

  /// No description provided for @increment.
  ///
  /// In en, this message translates to:
  /// **'Increment'**
  String get increment;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @authLogin.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get authLogin;

  /// No description provided for @authSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get authSignUp;

  /// No description provided for @authWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to StreetBite'**
  String get authWelcome;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get authFullName;

  /// No description provided for @authConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get authConfirmPassword;

  /// No description provided for @authShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get authShowPassword;

  /// No description provided for @authHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get authHidePassword;

  /// No description provided for @authCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get authCreateAccount;

  /// No description provided for @authLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get authLogout;

  /// No description provided for @authTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get authTryAgain;

  /// No description provided for @authSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String authSignedInAs(String name);

  /// No description provided for @authRequiredName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name.'**
  String get authRequiredName;

  /// No description provided for @authCapitalName.
  ///
  /// In en, this message translates to:
  /// **'Start your name with a capital English letter.'**
  String get authCapitalName;

  /// No description provided for @authRequiredEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get authRequiredEmail;

  /// No description provided for @authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email.'**
  String get authInvalidEmail;

  /// No description provided for @authRequiredPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password.'**
  String get authRequiredPassword;

  /// No description provided for @authShortPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get authShortPassword;

  /// No description provided for @authConfirmRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password.'**
  String get authConfirmRequired;

  /// No description provided for @authPasswordsMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get authPasswordsMismatch;

  /// No description provided for @authNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try again.'**
  String get authNetworkError;

  /// No description provided for @authEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered.'**
  String get authEmailInUse;

  /// No description provided for @authWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Choose a stronger password.'**
  String get authWeakPassword;

  /// No description provided for @authInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get authInvalidCredentials;

  /// No description provided for @authMissingProfile.
  ///
  /// In en, this message translates to:
  /// **'Your account exists, but your profile could not be loaded. Please contact support.'**
  String get authMissingProfile;

  /// No description provided for @authPermissionError.
  ///
  /// In en, this message translates to:
  /// **'Unable to access your profile.'**
  String get authPermissionError;

  /// No description provided for @authGenericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authGenericError;

  /// No description provided for @featuredMeals.
  ///
  /// In en, this message translates to:
  /// **'Featured Meals'**
  String get featuredMeals;

  /// No description provided for @hotOffers.
  ///
  /// In en, this message translates to:
  /// **'Hot Offers'**
  String get hotOffers;

  /// No description provided for @exploreMeals.
  ///
  /// In en, this message translates to:
  /// **'Explore Meals'**
  String get exploreMeals;

  /// No description provided for @noMealsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No meals available'**
  String get noMealsAvailable;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get retry;

  /// No description provided for @mealLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load meals. Please try again.'**
  String get mealLoadError;

  /// No description provided for @checkInternet.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try again.'**
  String get checkInternet;

  /// No description provided for @mealCategoryUnknown.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get mealCategoryUnknown;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Meal added to cart'**
  String get addedToCart;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmpty;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @currencyEgp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get currencyEgp;

  /// No description provided for @increaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Increase quantity'**
  String get increaseQuantity;

  /// No description provided for @decreaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Decrease quantity'**
  String get decreaseQuantity;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove item'**
  String get remove;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites;

  /// No description provided for @noFavourites.
  ///
  /// In en, this message translates to:
  /// **'No favourite meals yet'**
  String get noFavourites;

  /// No description provided for @favouritesError.
  ///
  /// In en, this message translates to:
  /// **'Could not load favourites'**
  String get favouritesError;

  /// No description provided for @addFavourite.
  ///
  /// In en, this message translates to:
  /// **'Add to favourites'**
  String get addFavourite;

  /// No description provided for @removeFavourite.
  ///
  /// In en, this message translates to:
  /// **'Remove from favourites'**
  String get removeFavourite;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Cuisine'**
  String get area;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructions;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// No description provided for @demoCard.
  ///
  /// In en, this message translates to:
  /// **'Demo Card Payment'**
  String get demoCard;

  /// No description provided for @demoPaymentNotice.
  ///
  /// In en, this message translates to:
  /// **'Simulation only. No real money will be charged.'**
  String get demoPaymentNotice;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @orderSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your order was placed successfully!'**
  String get orderSuccess;

  /// No description provided for @orderError.
  ///
  /// In en, this message translates to:
  /// **'Unable to process your order. Please try again.'**
  String get orderError;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @noOrders.
  ///
  /// In en, this message translates to:
  /// **'You have no orders yet'**
  String get noOrders;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get orderNumber;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get orderStatus;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @nearbyVendors.
  ///
  /// In en, this message translates to:
  /// **'Nearby Vendors'**
  String get nearbyVendors;

  /// No description provided for @fingerprintRequired.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint authentication is required to open your profile'**
  String get fingerprintRequired;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
