import 'package:amazonclone/global/global.dart';
import 'package:flutter/material.dart';

class CartItemCounter extends ChangeNotifier {
  int cartListItemCounter =
      sharedPreferences!.getStringList("userCard")!.length - 1;

  int get count => cartListItemCounter;
  Future<void> showCartListItemNumber() async {
    cartListItemCounter =
        sharedPreferences!.getStringList("userCard")!.length - 1;

    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
