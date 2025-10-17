import 'package:get/get.dart';
import '../../routes/app_route_names.dart';
import '/models/purchase_model.dart';
import '/repository/purchase/purchase_repository.dart';
import '/utils/utils.dart';

class PurchaseController extends GetxController {
  final PurchaseRepository _repository = PurchaseRepository();

  var purchaseList = <PurchaseModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // @override
  // void onReady() {
  //   super.onReady();
  //   fetchPurchaseList();
  // }

  Future<void> fetchPurchaseList() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _repository.getPurchases();

      if (response is List) {
        purchaseList.value = response
            .map((item) => PurchaseModel.fromJson(item))
            .toList();
      } else {
        throw Exception("invalid_response_from_server".tr);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      if (Get.context != null && !Get.isSnackbarOpen) {
        Utils.SnackBar("error".tr, e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> purchasePayment({dynamic data}) async {
    final purchaseData = {
      "id": data.id,
      "name": data.name,
      "amount": data.amount,
      "price": data.price,
      "total_price": data.totalPrice,
      "type": data.type,
      "pay_status": "true",
    };

    try {
      await _repository.updatePurchase(purchaseData);
      await fetchPurchaseList();
      Future.delayed(const Duration(milliseconds: 300), () {
        if (Get.context != null && !Get.isSnackbarOpen) {
          Utils.SnackBar("success".tr, "purchase_saved_successfully".tr);
        }
      });

      Get.offNamed(AppRouteNames.main, arguments: 1);
    } catch (e) {
      if (Get.context != null && !Get.isSnackbarOpen) {
        Utils.SnackBar("error".tr, e.toString());
      }
    }
  }

  Future<void> deletePurchase({required int id}) async {
    try {
      await _repository.deletePurchase(id);
      await fetchPurchaseList();

      // Safe Snackbar (after frame)
      Future.delayed(const Duration(milliseconds: 300), () {
        if (Get.context != null && !Get.isSnackbarOpen) {
          Utils.SnackBar("success".tr, "purchase_delete_successfully".tr);
        }
      });

      Get.offNamed(AppRouteNames.main, arguments: 1);
    } catch (e) {
      if (Get.context != null && !Get.isSnackbarOpen) {
        Utils.SnackBar("error".tr, e.toString());
      }
    }
  }
}
