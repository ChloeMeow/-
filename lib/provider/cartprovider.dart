import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List _cartList = [];
  //int _cartNum = 0;

  List get cartList => this._cartList;
  int get cartNum => this._cartList.length;

  addData(value) {
    this._cartList.add(value);
    notifyListeners();
  }
  deleteData(value) {
    this._cartList.remove(value);
    notifyListeners();
  }
}
