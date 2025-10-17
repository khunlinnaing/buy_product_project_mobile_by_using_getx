class PurchaseModel {
  final int id;
  final String? name;
  final double amount;
  final double price;
  final double totalPrice;
  final String purchaseNo;
  final bool payStatus;
  final int type;
  final String createDate;
  final String userName;

  PurchaseModel({
    required this.id,
    this.name,
    required this.amount,
    required this.price,
    required this.totalPrice,
    required this.purchaseNo,
    required this.payStatus,
    required this.type,
    required this.createDate,
    required this.userName,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      id: json['id'],
      name: json['name'],
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      purchaseNo: json['purchase_no'],
      payStatus: json['pay_status'] ?? false,
      type: json['type'] ?? 0,
      createDate: json['create_date'] ?? '',
      userName: json['user']?['username'] ?? '',
    );
  }
}
