import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = 'en';


  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    languageCode = prefs.getString('language') ?? 'en';
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode newMode) async {
    if (themeMode == newMode) return;
    themeMode = newMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', newMode == ThemeMode.dark);
  }

  Future<void> changeLanguage(String newCode) async {
    if (languageCode == newCode) return;
    languageCode = newCode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newCode);
  }
}