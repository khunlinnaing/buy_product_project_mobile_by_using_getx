class SaleModel {
  final int id;
  final User user;
  final String amount;
  final String price;
  final String totalPrice;
  final String companyName;
  final String name;
  final String saleNo;
  final bool payStatus;
  final int type;
  final DateTime createDate;

  SaleModel({
    required this.id,
    required this.user,
    required this.amount,
    required this.price,
    required this.totalPrice,
    required this.companyName,
    required this.name,
    required this.saleNo,
    required this.payStatus,
    required this.type,
    required this.createDate,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['id'],
      user: User.fromJson(json['user']),
      amount: json['amount'],
      price: json['price'],
      totalPrice: json['total_price'],
      companyName: json['company_name'],
      name: json['name'],
      saleNo: json['sale_no'],
      payStatus: json['pay_status'],
      type: json['type'],
      createDate: DateTime.parse(json['create_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'amount': amount,
      'price': price,
      'total_price': totalPrice,
      'company_name': companyName,
      'name': name,
      'sale_no': saleNo,
      'pay_status': payStatus,
      'type': type,
      'create_date': createDate.toIso8601String(),
    };
  }
}

class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}
