import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:shan_tea_mobile_2/views/sale/make_sale_page.dart';

import 'make_purchase_page.dart';

class SaleAndPurchaseTagScreen extends StatefulWidget {
  const SaleAndPurchaseTagScreen({super.key});

  @override
  State<SaleAndPurchaseTagScreen> createState() =>
      _SaleAndPurchaseTagScreenState();
}

class _SaleAndPurchaseTagScreenState extends State<SaleAndPurchaseTagScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.deepPurpleAccent,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: [
                Tab(icon: Icon(Icons.shopping_cart), text: "purchase".tr),
                Tab(icon: Icon(Icons.sell), text: "sale".tr),
              ],
            ),
          ),

          // ✅ TabBarView under TabBar
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [MakePurchasePage(), MakeSalePage()],
            ),
          ),
        ],
      ),
    );
  }
}
