import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              CircleAvatar(
                radius: mediaWidth * 0.2,
                backgroundImage: AssetImage("assets/images/icon.png"),
              ),
              const SizedBox(height: 40),
              Text(
                "login".tr,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email field
                    TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        labelText: "email".tr,
                        hintText: "please_enter_email".tr,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please_enter_email".tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password field (reactive)
                    Obx(
                      () => TextFormField(
                        controller: controller.passwordController,
                        obscureText: controller.obscureText.value,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          labelText: "password".tr,
                          hintText: "please_enter_password".tr,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.obscureText.toggle();
                            },
                            icon: Icon(
                              controller.obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please_enter_password".tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Login button (reactive)
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.loginUser();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "login".tr,
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("dont_have_account".tr),
              //     Text("forget_password".tr),
              //   ],
              // ),
              // const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
