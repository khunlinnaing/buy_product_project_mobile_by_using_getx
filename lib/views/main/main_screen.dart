// lib/views/main/main_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared_prefrences/languages/language_service.dart';
import '../../shared_prefrences/token_services_shareprefrence/token_services_shareprefrence.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../purchases/sale_and_purchase_list_tag_screen.dart';
import '../purchases/sale_and_purchase_tag_screen.dart';
import '../manage_user/manage_employ_screen.dart';
import '/routes/app_route_names.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 2;
  @override
  void initState() {
    super.initState();
    currentIndex = Get.arguments ?? currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: Icon(Icons.person),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.language),
            onSelected: (value) {
              LanguageService.changeLanguage(value.toString());
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: Locale('en'), child: Text("eng".tr)),
              PopupMenuItem(value: Locale('my'), child: Text("my".tr)),
            ],
          ),
          IconButton(
            onPressed: () async {
              await TokenServicesShareprefrence.clearToken();
              Get.offAllNamed(AppRouteNames.login);
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Center(child: _buildScreen(currentIndex)),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blueAccent, // selected tab indicator
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(
                // color: themeProvider.isDarkMode ? Colors.black : Colors.white,
              ); // selected → white
            }
            return IconThemeData(
              // color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ); // unselected → black
          }),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon: Icon(Icons.shopping_cart),
              label: 'sale_purchase'.tr,
            ),
            NavigationDestination(
              icon: Icon(Icons.list_alt_outlined),
              selectedIcon: Icon(Icons.list_alt),
              label: 'list'.tr,
            ),
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'home'.tr,
            ),
            NavigationDestination(
              icon: Icon(Icons.manage_accounts_sharp),
              selectedIcon: Icon(Icons.manage_accounts_sharp),
              label: 'attented'.tr,
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'profile'.tr,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return SaleAndPurchaseTagScreen();
      case 1:
        return SaleAndPurchaseListTagScreen();
      case 2:
        return HomeScreen();
      case 3:
        return ManageEmployScreen();
      case 4:
        return const ProfileScreen();
      default:
        return HomeScreen();
    }
  }
}
