import 'package:get/get.dart';
import 'package:shan_tea_mobile_2/models/sale_model.dart';
import 'package:shan_tea_mobile_2/repository/sale/sale_repository.dart';
import '../../routes/app_route_names.dart';
import '/utils/utils.dart';

class GetSaleController extends GetxController {
  final SaleRepository _repository = SaleRepository();

  var saleLists = <SaleModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchSaleList() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _repository.getSales();
      if (response is List) {
        saleLists.value = response
            .map((item) => SaleModel.fromJson(item))
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

  Future<void> salePayment({dynamic data}) async {
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
      await _repository.updateSale(purchaseData);
      await fetchSaleList();

      // Safe Snackbar (after frame)
      Future.delayed(const Duration(milliseconds: 100), () {
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

  Future<void> deleteSale({required int id}) async {
    try {
      await _repository.deleteSale(id);
      await fetchSaleList();

      // Safe Snackbar (after frame)
      Future.delayed(const Duration(milliseconds: 100), () {
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
