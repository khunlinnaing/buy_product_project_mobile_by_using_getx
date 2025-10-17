// {"id":7,"date":"2025-10-16","is_leave":false,"paystatus":true,"performance_amount":"32000.00","user":14}
class AttentedModel {
  int id, user;
  String date;
  String? performance_amount;
  bool is_leave, paystatus;
  AttentedModel({
    required this.id,
    required this.user,
    required this.date,
    this.performance_amount,
    required this.is_leave,
    required this.paystatus,
  });
  factory AttentedModel.jsonForm(dynamic data) {
    return AttentedModel(
      id: data['id'],
      user: data['user'],
      date: data['date'],
      performance_amount: data['performance_amount'],
      is_leave: data['is_leave'],
      paystatus: data['paystatus'],
    );
  }
}
