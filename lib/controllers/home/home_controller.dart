// import 'dart:async';

// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class HomeController extends GetxController {
//   var greeting = ''.obs;
//   var time = ''.obs;
//   Timer? _timer;

//   @override
//   void onInit() {
//     super.onInit();
//     _updateGreeting();
//     _updateTime();

//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       _updateGreeting();
//       _updateTime();
//     });
//   }

//   @override
//   void onClose() {
//     _timer?.cancel();
//     super.onClose();
//   }

//   void _updateGreeting() {
//     final hour = DateTime.now().hour;
//     if (hour < 12) {
//       greeting.value = "good_morning";
//     } else if (hour < 17) {
//       greeting.value = "good_afternoon";
//     } else {
//       greeting.value = "good_evening";
//     }
//   }

//   void _updateTime() {
//     time.value = DateFormat('hh:mm:ss a').format(DateTime.now());
//   }
// }
