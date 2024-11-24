import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {

  ThemeMode _themeMode = ThemeMode.light;
  String _language = 'ar';

  ThemeMode get themeMode => _themeMode;
  String get language => _language;

  bool get isDark => _themeMode == ThemeMode.dark;

  void changeThemeMode(ThemeMode selectedThemeMode) {
    _themeMode = selectedThemeMode;
    notifyListeners();
  }

  void changeLanguage(String selectedLanguage) {
    _language = selectedLanguage;
    notifyListeners();
  }
}
