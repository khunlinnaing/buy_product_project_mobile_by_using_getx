import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/controllers/sale/make_sale_controller.dart';

class MakeSalePage extends StatelessWidget {
  MakeSalePage({super.key});

  final MakeSaleController controller = Get.put(MakeSaleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _inputField("company_optional".tr, controller.companyController),
              const SizedBox(height: 16),
              _inputField("name_optional".tr, controller.nameController),
              const SizedBox(height: 16),

              Obx(
                () => _validatedField(
                  label: "amount".tr,
                  controller: controller.amountController,
                  errorText: controller.amountError.value,
                  onChanged: (_) => controller.calculateTotal(),
                ),
              ),
              const SizedBox(height: 16),

              Obx(
                () => _validatedField(
                  label: "price".tr,
                  controller: controller.priceController,
                  errorText: controller.priceError.value,
                  onChanged: (_) => controller.calculateTotal(),
                ),
              ),
              const SizedBox(height: 16),

              Text("type".tr, style: labelStyle),
              const SizedBox(height: 8),

              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedTypeKey.value,
                  decoration: inputDecoration(),
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
                );
              }),

              const SizedBox(height: 20),

              Text("total", style: labelStyle),
              const SizedBox(height: 8),

              Obx(
                () => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                    color: Colors.grey[100],
                  ),
                  child: Text(
                    "${controller.formattedTotal} ${'ks'.tr}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.saveSale,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "save_sale".tr,
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

  Widget _inputField(
    String label,
    TextEditingController controller, {
    TextInputType inputType = TextInputType.text,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: inputType,
          onChanged: onChanged,
          decoration: inputDecoration(),
        ),
      ],
    );
  }

  Widget _validatedField({
    required String label,
    required TextEditingController controller,
    required String? errorText,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          decoration: inputDecoration().copyWith(errorText: errorText),
        ),
      ],
    );
  }

  InputDecoration inputDecoration() => InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.green),
    ),
    filled: true,
    fillColor: Colors.white,
  );

  TextStyle get labelStyle =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
}
