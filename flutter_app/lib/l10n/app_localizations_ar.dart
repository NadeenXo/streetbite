// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ستريت بايت';

  @override
  String get homeTitle => 'الرئيسية';

  @override
  String get counterMessage => 'لقد ضغطت على الزر هذا العدد من المرات:';

  @override
  String get increment => 'زيادة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get authLogin => 'تسجيل الدخول';

  @override
  String get authSignUp => 'إنشاء حساب';

  @override
  String get authWelcome => 'مرحبًا بك في ستريت بايت';

  @override
  String get authEmail => 'البريد الإلكتروني';

  @override
  String get authPassword => 'كلمة المرور';

  @override
  String get authFullName => 'الاسم الكامل';

  @override
  String get authConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get authShowPassword => 'إظهار كلمة المرور';

  @override
  String get authHidePassword => 'إخفاء كلمة المرور';

  @override
  String get authCreateAccount => 'إنشاء حساب جديد';

  @override
  String get authLogout => 'تسجيل الخروج';

  @override
  String get authTryAgain => 'حاول مجددًا';

  @override
  String authSignedInAs(String name) {
    return 'مرحبًا، $name';
  }

  @override
  String get authRequiredName => 'يرجى إدخال الاسم الكامل.';

  @override
  String get authCapitalName => 'يجب أن يبدأ الاسم بحرف إنجليزي كبير.';

  @override
  String get authRequiredEmail => 'يرجى إدخال البريد الإلكتروني.';

  @override
  String get authInvalidEmail => 'يرجى إدخال بريد إلكتروني صحيح.';

  @override
  String get authRequiredPassword => 'يرجى إدخال كلمة المرور.';

  @override
  String get authShortPassword => 'يجب ألا تقل كلمة المرور عن ٦ أحرف.';

  @override
  String get authConfirmRequired => 'يرجى تأكيد كلمة المرور.';

  @override
  String get authPasswordsMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get authNetworkError => 'تحقق من الاتصال بالإنترنت وحاول مجددًا.';

  @override
  String get authEmailInUse => 'هذا البريد الإلكتروني مسجل بالفعل.';

  @override
  String get authWeakPassword => 'يرجى اختيار كلمة مرور أقوى.';

  @override
  String get authInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get authMissingProfile =>
      'الحساب موجود لكن تعذر تحميل الملف الشخصي. يرجى التواصل مع الدعم.';

  @override
  String get authPermissionError => 'تعذر الوصول إلى ملفك الشخصي.';

  @override
  String get authGenericError => 'حدث خطأ ما. يرجى المحاولة مجددًا.';

  @override
  String get featuredMeals => 'وجبات مميزة';

  @override
  String get hotOffers => 'عروض مميزة';

  @override
  String get exploreMeals => 'استكشف الوجبات';

  @override
  String get noMealsAvailable => 'لا توجد وجبات متاحة';

  @override
  String get retry => 'حاول مرة أخرى';

  @override
  String get mealLoadError => 'تعذر تحميل الوجبات. يرجى المحاولة مرة أخرى.';

  @override
  String get checkInternet => 'تحقق من اتصال الإنترنت وحاول مرة أخرى.';

  @override
  String get mealCategoryUnknown => 'أخرى';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String get addedToCart => 'تمت إضافة الوجبة إلى السلة';

  @override
  String get cart => 'السلة';

  @override
  String get cartEmpty => 'سلة التسوق فارغة';

  @override
  String get total => 'الإجمالي';

  @override
  String get currencyEgp => 'ج.م';

  @override
  String get increaseQuantity => 'زيادة الكمية';

  @override
  String get decreaseQuantity => 'تقليل الكمية';

  @override
  String get remove => 'إزالة العنصر';
}
