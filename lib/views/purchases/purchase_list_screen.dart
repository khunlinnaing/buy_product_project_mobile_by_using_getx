import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../controllers/purchases/get_purchases_controller.dart';
import '/views/purchases/edit_purchase_screen.dart';
import '../../provider/check_provider.dart';

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
    return ChangeNotifierProvider(
      create: (_) => CheckProvider(),
      child: Consumer<CheckProvider>(
        builder: (context, checkProvider, _) {
          return Scaffold(
            body: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.purchaseList.isEmpty) {
                return Center(child: Text("no_purchases_found".tr));
              }

              return Column(
                children: [
                  // ✅ Combine button row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                checkProvider.changecheck(checkProvider.check);
                              },
                              child: Text(
                                "combine_and_print".tr,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            if (checkProvider.check)
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.print),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (checkProvider.check)
                          Text(
                            '${'total_price'.tr}: ${checkProvider.sum.toStringAsFixed(2)} ${'ks'.tr}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.purchaseList.length,
                      itemBuilder: (context, index) {
                        final purchase = controller.purchaseList[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            // leading: CircleAvatar(
                            //   backgroundColor: Colors.green,
                            //   child: Text((index + 1).toString()),
                            // ),
                            title: Text(
                              "${purchase.purchaseNo}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${'name'.tr}: ${purchase.name == null || purchase.name!.isEmpty ? 'Unnamed' : purchase.name}",
                                ),
                                Text(
                                  "${'amount'.tr}: ${purchase.amount} ${'kg'.tr}",
                                ),
                                Text(
                                  "${'price'.tr}: ${purchase.price} ${'ks'.tr}",
                                ),
                                Text(
                                  "${'total'.tr}: ${purchase.totalPrice} ${'ks'.tr}",
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.print,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {},
                                  tooltip: "Print",
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () {
                                    Get.to(
                                      () => EditPurchaseScreen(
                                        purchase: purchase,
                                      ),
                                    );
                                  },
                                  tooltip: "Edit",
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    controller.deletePurchase(id: purchase.id);
                                  },
                                  tooltip: "Delete",
                                ),
                                // ✅ Show Radio only when check mode = true
                                if (checkProvider.check)
                                  Checkbox(
                                    value:
                                        checkProvider.checkedItems[index] ??
                                        false,
                                    onChanged: (value) {
                                      checkProvider.priceValue(
                                        index,
                                        purchase.totalPrice,
                                      );
                                      // checkProvider.selectItem(value!);
                                    },
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}
