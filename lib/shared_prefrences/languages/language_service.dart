import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _key = 'language_code';

  /// Save selected language
  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, languageCode);
  }

  /// Get saved language, default to 'en' if not found
  static Future<Locale> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'en';
    switch (code) {
      case 'my':
        return const Locale('my', 'MM');
      case 'en':
      default:
        return const Locale('en', 'US');
    }
  }

  /// Change language dynamically
  static Future<void> changeLanguage(String languageCode) async {
    Locale locale;
    switch (languageCode) {
      case 'my':
        locale = const Locale('my', 'MM');
        break;
      case 'en':
      default:
        locale = const Locale('en', 'US');
    }
    Get.updateLocale(locale);
    await saveLanguage(languageCode);
  }
}
