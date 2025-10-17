// lib/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:shan_tea_mobile_2/views/manage_user/checkin_screen.dart';
import '../views/home/home_screen.dart';
import '../views/main/main_screen.dart';
import '../views/splash/splash_screen.dart';
import '../views/auth/login_screen.dart';
import 'app_route_names.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRouteNames.splash, page: () => const SplashScreen()),
    GetPage(name: AppRouteNames.login, page: () => LoginScreen()),
    GetPage(name: AppRouteNames.main, page: () => const MainScreen()),
    GetPage(name: AppRouteNames.home, page: () => HomeScreen()),
    GetPage(name: AppRouteNames.checkin, page: () => CheckinScreen()),
  ];
}
