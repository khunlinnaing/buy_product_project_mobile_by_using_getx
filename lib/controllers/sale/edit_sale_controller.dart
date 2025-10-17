import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shan_tea_mobile_2/repository/sale/sale_repository.dart';
import 'package:shan_tea_mobile_2/routes/app_route_names.dart';
import '../../utils/utils.dart';

class EditSaleController extends GetxController {
  final SaleRepository _repository = SaleRepository();

  final companyController = TextEditingController();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final priceController = TextEditingController();

  var total = 0.0.obs;
  var selectedTypeKey = ''.obs;
  var amountError = RxnString();
  var priceError = RxnString();

  final Map<String, String> types = {"1": "wet", "2": "dry", "3": "leave"};

  @override
  void onInit() {
    super.onInit();
    selectedTypeKey.value = types.keys.first;
    amountController.addListener(calculateTotal);
    priceController.addListener(calculateTotal);
  }

  @override
  void onClose() {
    companyController.dispose();
    nameController.dispose();
    amountController.dispose();
    priceController.dispose();
    super.onClose();
  }

  void calculateTotal() {
    double amount = double.tryParse(amountController.text) ?? 0.0;
    double price = double.tryParse(priceController.text) ?? 0.0;
    total.value = amount * price;
  }

  String get formattedTotal {
    final formatter = NumberFormat("#,##0.##", "en_US");
    return formatter.format(total.value);
  }

  bool validateInputs() {
    bool isValid = true;
    amountError.value = null;
    priceError.value = null;

    if (amountController.text.trim().isEmpty) {
      amountError.value = "please_enter_amount".tr;
      isValid = false;
    } else if (double.tryParse(amountController.text) == null) {
      amountError.value = "amount_must_be_a_number".tr;
      isValid = false;
    }

    if (priceController.text.trim().isEmpty) {
      priceError.value = "please_enter_price".tr;
      isValid = false;
    } else if (double.tryParse(priceController.text) == null) {
      priceError.value = "amount_must_be_a_number".tr;
      isValid = false;
    }

    return isValid;
  }

  Future<void> editPurchase({int? editId}) async {
    if (!validateInputs()) return;

    final purchaseData = {
      "id": editId,
      "company_name": companyController.text.isEmpty
          ? 'default'
          : nameController.text,
      "name": nameController.text.isEmpty ? "default" : nameController.text,
      "amount": amountController.text,
      "price": priceController.text,
      "total_price": total.value,
      "type": selectedTypeKey.value,
      "pay_status": true,
    };

    try {
      await _repository.updateSale(purchaseData);

      // Safe Snackbar (after frame)
      Future.delayed(const Duration(milliseconds: 300), () {
        if (Get.context != null && !Get.isSnackbarOpen) {
          Utils.SnackBar("success".tr, "purchase_saved_successfully".tr);
        }
      });

      Get.offAllNamed(AppRouteNames.main, arguments: 1);
    } catch (e) {
      if (Get.context != null && !Get.isSnackbarOpen) {
        Utils.SnackBar("error".tr, e.toString());
      }
    }
  }
}
