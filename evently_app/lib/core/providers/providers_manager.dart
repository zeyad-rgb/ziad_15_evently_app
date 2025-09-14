import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/core/cashing/cashing.dart';
import 'package:flutter/material.dart';

class ProvidersManager extends ChangeNotifier {
  bool isDark = Cashing.getTheme();
  Locale _locale = Locale('en');

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  Locale get locale => _locale;

  void toggleTheme(bool value) {
    isDark = value;
    Cashing.saveTheme(value);
    notifyListeners();
  }

  void changeLanguage(Locale newLocale, BuildContext context) {
    _locale = newLocale;
    context.setLocale(newLocale);
    notifyListeners();
  }
}
