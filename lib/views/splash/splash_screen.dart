import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared_prefrences/token_services_shareprefrence/token_services_shareprefrence.dart';
import '/routes/app_route_names.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // Delay for splash effect
    await Future.delayed(const Duration(seconds: 2));

    // Get token from SharedPreferences
    final tokenData = await TokenServicesShareprefrence.getToken();

    if (tokenData != null && tokenData.isLogin) {
      Get.offAllNamed(AppRouteNames.main);
    } else {
      Get.offAllNamed(AppRouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'app_name'.tr,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
