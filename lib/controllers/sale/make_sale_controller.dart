import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/repository/sale/sale_repository.dart';
import '/utils/utils.dart';
// import 'get_sale_controller.dart';

class MakeSaleController extends GetxController {
  final SaleRepository _repository = SaleRepository();
  // final saleController = Get.find<GetSaleController>();

  final companyController = TextEditingController();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final priceController = TextEditingController();

  var total = 0.0.obs;
  var selectedTypeKey = ''.obs;

  // Validation messages
  var amountError = RxnString();
  var priceError = RxnString();

  // Dropdown type options
  final Map<String, String> types = {"1": "wet", "2": "dry", "3": "leave"};

  @override
  void onInit() {
    super.onInit();
    selectedTypeKey.value = types.keys.first; // Default selection
  }

  /// Calculates total (amount * price)
  void calculateTotal() {
    final amount = double.tryParse(amountController.text) ?? 0.0;
    final price = double.tryParse(priceController.text) ?? 0.0;
    total.value = amount * price;
  }

  /// Returns formatted total (e.g., 1,000)
  String get formattedTotal {
    final formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(total.value);
  }

  /// Validates amount and price fields
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
      priceError.value = "price_must_be_a_number".tr;
      isValid = false;
    }

    return isValid;
  }

  Future<void> saveSale() async {
    if (!validateInputs()) return;

    final data = {
      "company_name": companyController.text.isEmpty
          ? "company"
          : companyController.text,
      "name": nameController.text.isEmpty ? "default" : nameController.text,
      "amount": amountController.text,
      "price": priceController.text,
      "total_price": total.value,
      "type": selectedTypeKey.value,
      "pay_status": "true",
    };

    try {
      Utils.showLoading();
      final response = await _repository.saveSale(data);
      Utils.hideLoading();
      if (response.isNotEmpty &&
          (response['success'] == true || response['id'] != null)) {
        // await saleController.fetchSaleList();
        Utils.SnackBar("success".tr, "sale_saved_successfully".tr);
        clearForm();
      } else {
        Utils.SnackBar("error".tr, "");
      }
    } catch (error) {
      Utils.hideLoading();
      Utils.SnackBar("error".tr, error.toString());
    }
  }

  void clearForm() {
    nameController.clear();
    amountController.clear();
    priceController.clear();
    total.value = 0.0;
    selectedTypeKey.value = types.keys.first;
  }

  @override
  void onClose() {
    nameController.dispose();
    amountController.dispose();
    priceController.dispose();
    super.onClose();
  }
}
