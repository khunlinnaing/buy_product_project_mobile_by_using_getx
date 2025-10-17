import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/auth_model.dart';
import '../../repository/auth/login_repository.dart';
import '../../routes/app_route_names.dart';
import '../../shared_prefrences/token_services_shareprefrence/token_services_shareprefrence.dart';
import '../../utils/utils.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  var obscureText = true.obs;
  final _repository = LoginRepository();

  Future<void> loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Utils.SnackBar("error".tr, "please_fill_all_fields".tr);
      return;
    }

    try {
      isLoading.value = true;

      final response = await _repository.loginApi({
        "identifier": emailController.text,
        "password": passwordController.text,
      });

      final authModel = AuthModel.fromJson(response);

      if (authModel.success == true) {
        final tokenData = TokenModel(
          token: authModel.token,
          isLogin: authModel.success,
          userId: authModel.userid,
        );

        await TokenServicesShareprefrence.saveToken(tokenData);
        Utils.SnackBar("success".tr, "login_success".tr);
        Get.offAllNamed(AppRouteNames.main);
      } else {
        Utils.SnackBar("error".tr, "invalid_credentials".tr);
      }
    } catch (e) {
      Utils.SnackBar("error".tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
