import 'package:flutter/material.dart';

class TotalAmount extends ChangeNotifier {
  double totalAmountOfCartItem = 0.0;
  double get tAmount => totalAmountOfCartItem;
  showTotalAmountOfCartItem(double totalAmount) async {
    totalAmountOfCartItem = totalAmount;
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
