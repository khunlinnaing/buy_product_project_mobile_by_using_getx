import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/purchases/edit_purchase_controller.dart';
import '../../models/purchase_model.dart';

class EditPurchaseScreen extends StatelessWidget {
  final PurchaseModel purchase;
  final EditPurchaseController controller = Get.put(EditPurchaseController());

  EditPurchaseScreen({super.key, required this.purchase});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Initialize controller values
    controller.nameController.text = purchase.name ?? '';
    controller.amountController.text = purchase.amount.toString();
    controller.priceController.text = purchase.price.toString();
    controller.selectedTypeKey.value = purchase.type.toString();
    controller.calculateTotal();

    return Scaffold(
      appBar: AppBar(title: Text("edit_purchase".tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: "name_optional".tr,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Amount
              Obx(
                () => TextFormField(
                  controller: controller.amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: "amount".tr,
                    border: const OutlineInputBorder(),
                    errorText: controller.amountError.value,
                  ),
                  onChanged: (_) => controller.calculateTotal(),
                ),
              ),
              const SizedBox(height: 16),

              // Price
              Obx(
                () => TextFormField(
                  controller: controller.priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: "price".tr,
                    border: const OutlineInputBorder(),
                    errorText: controller.priceError.value,
                  ),
                  onChanged: (_) => controller.calculateTotal(),
                ),
              ),
              const SizedBox(height: 16),

              // Type Dropdown
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.selectedTypeKey.value,
                  decoration: InputDecoration(
                    labelText: "type".tr,
                    border: OutlineInputBorder(),
                  ),
                  items: controller.types.entries
                      .map(
                        (entry) => DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value.tr),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => controller.selectedTypeKey.value =
                      value ?? controller.types.keys.first,
                ),
              ),
              const SizedBox(height: 16),

              // Total Display
              Obx(
                () => Text(
                  "${'total'.tr}: ${NumberFormat("#,##0.##").format(controller.total.value)} ${'ks'.tr}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.editPurchase(editId: purchase.id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "save_purchase".tr,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
