import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String key = "isDarkMode";

  // Load theme mode from shared preferences
  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(key) ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  // Switch between dark and light theme
  Future<void> switchTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(key) ?? false;
    final newMode = !isDark;

    await prefs.setBool(key, newMode);
    Get.changeThemeMode(newMode ? ThemeMode.dark : ThemeMode.light);
  }
}
