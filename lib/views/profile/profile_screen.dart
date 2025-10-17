import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shan_tea_mobile_2/controllers/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: Text('profile'.tr), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text('${'error'.tr}: ${controller.errorMessage.value}'),
          );
        }

        if (controller.profileData.isEmpty) {
          return Center(child: Text('no_profile_data_found'.tr));
        }

        final profile = controller.profileData;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  profile['profile']['profile'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            profile['profile']['profile'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 100),
                          ),
                        )
                      : const Icon(Icons.person, size: 100),
                  const SizedBox(height: 20),

                  // Username
                  controller.isEditing.value
                      ? TextFormField(
                          controller: controller.usernameController,
                          decoration: InputDecoration(labelText: 'account'.tr),
                          validator: (value) => value!.isEmpty
                              ? "this_field_is_required".tr
                              : null,
                        )
                      : Text("${'account'.tr}: ${profile['username']}"),
                  const SizedBox(height: 8),

                  // First Name
                  controller.isEditing.value
                      ? TextFormField(
                          controller: controller.firstNameController,
                          decoration: InputDecoration(
                            labelText: 'first_name'.tr,
                          ),
                          validator: (value) => value!.isEmpty
                              ? "this_field_is_required".tr
                              : null,
                        )
                      : Text(
                          "${'name'.tr} : ${profile['first_name'] ?? ''} ${profile['last_name'] ?? ''}",
                        ),
                  const SizedBox(height: 8),

                  // Last Name
                  controller.isEditing.value
                      ? TextFormField(
                          controller: controller.lastNameController,
                          decoration: InputDecoration(
                            labelText: 'last_name'.tr,
                          ),
                          validator: (value) => value!.isEmpty
                              ? "this_field_is_required".tr
                              : null,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 8),

                  // Email
                  controller.isEditing.value
                      ? TextFormField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            labelText: 'email_user'.tr,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this_field_is_required".tr;
                            }
                            final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            );
                            if (!emailRegex.hasMatch(value)) {
                              return 'enter_a_valid_email_address'.tr;
                            }
                            return null;
                          },
                        )
                      : Text("${'email_user'.tr}: ${profile['email'] ?? ''}"),
                  const SizedBox(height: 8),

                  // Phone
                  controller.isEditing.value
                      ? TextFormField(
                          controller: controller.phoneController,
                          decoration: InputDecoration(
                            labelText: 'phone_12_digits'.tr,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "this_field_is_required".tr;
                            }
                            final digitsOnly = value.replaceAll(
                              RegExp(r'\D'),
                              '',
                            );
                            if (digitsOnly.length != 12) {
                              return 'phone_number_must_be_exactly_12_digits'
                                  .tr;
                            }
                            return null;
                          },
                        )
                      : Text(
                          "${'phone'.tr}: ${profile['profile']['phone'] ?? ''}",
                        ),

                  const SizedBox(height: 20),

                  // Save / Update Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.isEditing.value) {
                          if (formKey.currentState!.validate()) {
                            controller.updateProfile();
                          }
                        } else {
                          controller.toggleEdit();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isEditing.value
                            ? Colors.blue
                            : Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        controller.isEditing.value ? "Save" : "Update",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
