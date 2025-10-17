import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shan_tea_mobile_2/views/sale/edit_sale_page.dart';

import '../../controllers/sale/get_sale_controller.dart';

class SaleListPage extends StatefulWidget {
  const SaleListPage({super.key});

  @override
  State<SaleListPage> createState() => _SaleListPageState();
}

class _SaleListPageState extends State<SaleListPage> {
  final controller = Get.put(GetSaleController());
  @override
  void initState() {
    super.initState();
    controller.fetchSaleList();
  }

  @override
  void dispose() {
    if (Get.isRegistered<GetSaleController>()) {
      Get.delete<GetSaleController>();
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
        if (controller.saleLists.isEmpty) {
          return Center(child: Text("no_purchases_found".tr));
        }

        return ListView.builder(
          itemCount: controller.saleLists.length,
          itemBuilder: (context, index) {
            final sale = controller.saleLists[index];

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
                  sale.saleNo.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${'name'.tr}:${sale.name.isEmpty ? 'Unnamed' : sale.name} ",
                    ),
                    Text("${'amount'.tr}: ${sale.amount} ${'kg'.tr}"),
                    Text("${'price'.tr}: ${sale.price} ${'ks'.tr}"),
                    Text("${'total'.tr}: ${sale.totalPrice} ${'ks'.tr}"),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // IconButton(
                    //   icon: Icon(
                    //     sale.payStatus
                    //         ? Icons.check_circle
                    //         : Icons.not_interested,
                    //     color: sale.payStatus
                    //         ? Colors.green
                    //         : Colors.orange,
                    //   ),
                    //   onPressed: () {
                    //     if (sale.payStatus != true) {
                    //       controller.salePayment(data: sale);
                    //     } else {
                    //       Utils.snackBar("warrning".tr, "already_to_pay".tr);
                    //     }
                    //   },
                    //   tooltip: sale.payStatus ? "Paid" : "Pending",
                    // ),
                    IconButton(
                      icon: const Icon(Icons.print, color: Colors.blue),
                      onPressed: () {},
                      tooltip: "Print",
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () {
                        Get.to(() => EditSalePage(sale: sale));
                      },
                      tooltip: "Edit",
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.deleteSale(id: sale.id);
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
