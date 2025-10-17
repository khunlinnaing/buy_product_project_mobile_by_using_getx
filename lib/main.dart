import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'routes/app_route_names.dart';
import 'shared_prefrences/languages/language_service.dart';
import 'translations/app_translateions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final locale = await LanguageService.getLocale();

  runApp(MyApp(initialLocale: locale));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shan Tea Mobile',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: initialLocale,
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AppRouteNames.splash,
      getPages: AppPages.routes,
    );
  }
}
