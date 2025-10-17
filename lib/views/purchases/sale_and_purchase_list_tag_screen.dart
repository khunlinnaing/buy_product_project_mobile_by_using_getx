import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sale/sale_list_page.dart';
import 'purchase_list_screen.dart';

class SaleAndPurchaseListTagScreen extends StatefulWidget {
  const SaleAndPurchaseListTagScreen({super.key});

  @override
  State<SaleAndPurchaseListTagScreen> createState() =>
      _SaleAndPurchaseListTagScreenState();
}

class _SaleAndPurchaseListTagScreenState
    extends State<SaleAndPurchaseListTagScreen>
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
                Tab(icon: Icon(Icons.shopping_cart), text: "purchase_list".tr),
                Tab(icon: Icon(Icons.sell), text: "sale_list".tr),
              ],
            ),
          ),

          // ✅ TabBarView under TabBar
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [PurchaseListScreen(), SaleListPage()],
            ),
          ),
        ],
      ),
    );
  }
}
