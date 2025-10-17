import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shan_tea_mobile_2/controllers/users/user_controller.dart';
import 'package:shan_tea_mobile_2/routes/app_route_names.dart';

class ManageEmployScreen extends StatefulWidget {
  const ManageEmployScreen({super.key});

  @override
  State<ManageEmployScreen> createState() => _ManageEmployScreenState();
}

class _ManageEmployScreenState extends State<ManageEmployScreen> {
  final controller = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    controller.getUserLists();
  }

  @override
  void dispose() {
    if (Get.isRegistered<UserController>()) {
      Get.delete<UserController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.userLists.isEmpty) {
          return Center(child: Text("no_user".tr));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.85,
            ),
            itemCount: controller.userLists.length,
            itemBuilder: (context, index) {
              final user = controller.userLists[index];
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Get.toNamed(AppRouteNames.checkin, arguments: user);
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      user.profile.profile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                user.profile.profile.toString(),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.person, size: 100),
                              ),
                            )
                          : const Icon(Icons.person, size: 100),
                      Text("${user.first_name} ${user.last_name}"),
                      Text("${user.email}"),
                      Text("${user.profile.phone}"),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
