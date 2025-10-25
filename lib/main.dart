import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shan_tea_mobile_2/provider/check_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes/app_pages.dart';
import 'routes/app_route_names.dart';
import 'shared_prefrences/languages/language_service.dart';
import 'shared_prefrences/theme/theme_service.dart';
import 'translations/app_translateions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final locale = await LanguageService.getLocale();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool(ThemeService.key) ?? false;
  final themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

  runApp(
    ChangeNotifierProvider(
      create: (context) => CheckProvider(),
      child: MyApp(initialLocale: locale, themeMode: themeMode),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  final ThemeMode themeMode;
  const MyApp({
    super.key,
    required this.initialLocale,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shan Tea Mobile',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: initialLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      initialRoute: AppRouteNames.splash,
      getPages: AppPages.routes,
    );
  }
}
