import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState(locale: Locale('en')));

  void setLocale(Locale locale) {
    if (locale.languageCode != 'en' && locale.languageCode != 'ar') {
      return;
    }

    emit(LocaleState(locale: locale));
  }
}
