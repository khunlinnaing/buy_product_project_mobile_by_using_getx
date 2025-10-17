import 'package:get/get.dart';
import 'package:shan_tea_mobile_2/models/user_model.dart';
import 'package:shan_tea_mobile_2/repository/user/user_repostory.dart';

import '../../utils/utils.dart';

class UserController {
  final _repository = UserRepostory();
  var isLoading = false.obs;
  var userLists = <UserModel>[].obs;
  Future<void> getUserLists() async {
    isLoading.value = true;
    await _repository
        .userApi()
        .then((response) {
          isLoading.value = false;
          if (response is List) {
            userLists.value = response
                .map((item) => UserModel.jsonForm(item))
                .toList();
          } else {
            throw Exception("invalid_response_from_server".tr);
          }
        })
        .onError((error, StackTrace) {
          print(error);
          isLoading.value = false;
          Utils.SnackBar("Error", "Failed to update profile: $error");
        });
  }
}
