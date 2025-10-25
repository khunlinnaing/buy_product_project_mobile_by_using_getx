import 'package:flutter/material.dart';

class CheckProvider extends ChangeNotifier {
  bool _check = false;
  double _sum = 0.0;
  Map<int, bool> _checkedItems = {};
  bool get check => _check;
  double get sum => _sum;
  Map<int, bool> get checkedItems => _checkedItems;
  void changecheck(bool ischeck) {
    _check = !ischeck;
    if (!_check) {
      _checkedItems = {};
      _sum = 0.0;
    }
    notifyListeners();
  }

  void priceValue(int index, double price) {
    bool currentState = _checkedItems[index] ?? false;

    if (!currentState) {
      // Checkbox checked -> add price
      _sum += price;
    } else {
      // Checkbox unchecked -> subtract price
      _sum -= price;
    }

    // toggle checkbox state
    _checkedItems[index] = !currentState;

    notifyListeners();
  }
}
