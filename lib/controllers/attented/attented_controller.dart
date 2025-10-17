import 'package:get/get.dart';
import 'package:shan_tea_mobile_2/models/attented_model.dart';

import '../../repository/user/attented_repository.dart';
import '../../routes/app_route_names.dart';
import '../../utils/utils.dart';

class AttentedController extends GetxController {
  final _repository = AttentedRepository();
  var isLoading = false.obs;
  var attentlists = <AttentedModel>[].obs;
  var userold = Rxn<dynamic>();

  void setUser(dynamic u) {
    userold.value = u;
  }

  Future<void> getAttentedLists(String userid) async {
    isLoading.value = true;
    await _repository
        .getAttented(userid)
        .then((response) {
          isLoading.value = false;
          if (response is List) {
            attentlists.value = response
                .map((item) => AttentedModel.jsonForm(item))
                .toList();
          } else {
            throw Exception("invalid_response_from_server".tr);
          }
        })
        .onError((error, StrackTrace) {
          isLoading.value = false;
        });
  }

  Future<void> addattented(String id, String date, bool is_leave) async {
    var data = {
      "date": date,
      "is_leave": is_leave,
      "paystatus": false,
      "user": id,
    };
    await _repository
        .createAttented(data)
        .then((response) {
          Utils.SnackBar("success".tr, "success".tr);
          Get.offAllNamed(AppRouteNames.main, arguments: 3);
        })
        .onError((error, StackTrace) {
          Utils.SnackBar("error".tr, "Failed to update profile: $error");
        });
  }
}
