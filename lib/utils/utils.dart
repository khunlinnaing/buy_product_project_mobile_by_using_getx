// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Utils {
//   static void snackBar(String title, String message) {
//     Get.snackbar(
//       title,
//       message,
//       backgroundColor: Colors.black87,
//       colorText: Colors.white,
//       snackPosition: SnackPosition.TOP,
//       margin: const EdgeInsets.all(12),
//       duration: const Duration(seconds: 2),
//     );
//   }

//   static void showLoading() {
//     Get.dialog(
//       const Center(child: CircularProgressIndicator()),
//       barrierDismissible: false,
//     );
//   }

// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static void fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode nextFocus,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void showLoading() {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  static SnackBar(String title, String message) {
    Get.snackbar(title, message);
  }

  static void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
