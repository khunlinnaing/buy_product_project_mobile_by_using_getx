import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/purchases/get_purchases_controller.dart';
import 'package:shan_tea_mobile_2/views/purchases/edit_purchase_screen.dart';

class PurchaseListScreen extends StatefulWidget {
  const PurchaseListScreen({super.key});

  @override
  State<PurchaseListScreen> createState() => _PurchaseListScreenState();
}

class _PurchaseListScreenState extends State<PurchaseListScreen> {
  final controller = Get.put(PurchaseController());

  @override
  void initState() {
    super.initState();
    controller.fetchPurchaseList();
  }

  @override
  void dispose() {
    if (Get.isRegistered<PurchaseController>()) {
      Get.delete<PurchaseController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.purchaseList.isEmpty) {
          return Center(child: Text("no_purchases_found".tr));
        }

        return ListView.builder(
          itemCount: controller.purchaseList.length,
          itemBuilder: (context, index) {
            final purchase = controller.purchaseList[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text((index + 1).toString()),
                ),
                title: Text(
                  "${purchase.purchaseNo}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${'name'.tr}:${purchase.name == null || purchase.name!.isEmpty ? 'Unnamed' : purchase.name} ",
                    ),
                    Text("${'amount'.tr}: ${purchase.amount} ${'kg'.tr}"),
                    Text("${'price'.tr}: ${purchase.price} ${'ks'.tr}"),
                    Text("${'total'.tr}: ${purchase.totalPrice} ${'ks'.tr}"),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.print, color: Colors.blue),
                      onPressed: () {},
                      tooltip: "Print",
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () {
                        Get.to(() => EditPurchaseScreen(purchase: purchase));
                      },
                      tooltip: "Edit",
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.deletePurchase(id: purchase.id);
                      },
                      tooltip: "Delete",
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
