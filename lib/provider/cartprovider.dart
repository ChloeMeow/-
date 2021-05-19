import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jingdong_app/services/storage.dart';

class CartProvider with ChangeNotifier {
  List _cartList = []; //公务车数据
  bool _isCheckedAll = false; //全选
  //int _cartNum = 0;
  double _allPrice = 0; //总价

  List get cartList => this._cartList;
  bool get isCheckedAll => this._isCheckedAll;
  double get allPrice => this._allPrice;
  // int get cartNum => this._cartList.length;

  // addData(value) {
  //   this._cartList.add(value);
  //   notifyListeners();
  // }
  // deleteData(value) {
  //   this._cartList.remove(value);
  //   notifyListeners();
  // }
  CartProvider() {
    this.init();
  }
  //初始化时候回去购物车数据
  init() async {
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      this._cartList = cartListData;
    } catch (e) {
      this._cartList = [];
    }
    //获取全选的状态
    this._isCheckedAll = this.isCheckAll();
    //计算总价
    this.computeAllPrice();
    notifyListeners();
  }

  updateCartList() {
    this.init();
  }

  //通知Provider保存购物车加减数据，更新数据
  itemCountchange() {
    Storage.setString('cartList', json.encode(this._cartList));
    //计算总价
    this.computeAllPrice();
    notifyListeners();
  }

  //全选反选的方法
  chenckAll(value) {
    for (var i = 0; i < this._cartList.length; i++) {
      this._cartList[i]['checked'] = value;
    }
    this._isCheckedAll = value;
    //计算总价
    this.computeAllPrice();
    Storage.setString('cartList', json.encode(this._cartList));
    notifyListeners();
  }

  //判断是否全选
  bool isCheckAll() {
    if (this._cartList.length > 0) {
      for (var i = 0; i < this._cartList.length; i++) {
        //假如选择有一个等于false,就返回false
        if (this._cartList[i]['checked'] == false) {
          return false;
        }
      }
      //循环完成没有返回false就返回true
      return true;
    }
    return false;
  }

  //监听每一项的选中事件
  itemChage() {
    if (this.isCheckAll() == true) {
      this._isCheckedAll = true;
    } else {
      this._isCheckedAll = false;
    }
    //计算总价
    this.computeAllPrice();
    Storage.setString('cartList', json.encode(this._cartList));
    notifyListeners();
  }

  //计算总价
  computeAllPrice() {
    double tempAllPrice = 0;
    for (var i = 0; i < this._cartList.length; i++) {
      //假如选择有一个等于false,就返回false
      if (this._cartList[i]['checked'] == true) {
        tempAllPrice += this._cartList[i]['price'] * this._cartList[i]['count'];
      }
    }
    this._allPrice = tempAllPrice;
    notifyListeners();
  }

  //删除数据
  removeItem() {
    //错误都写法
    // for (var i = 0; i < this._cartList.length; i++) {
    //   //假如选择有一个等于false,就返回false
    //   if (this._cartList[i]['checked'] == true) {
    //     this._cartList.remove(i);
    //   }
    // }
    List tempList = [];
    for (var i = 0; i < this._cartList.length; i++) {
      if (this._cartList[i]['checked'] == false) {
        //获取到没有勾选的数据
        tempList.add(this._cartList[i]);
      }
    }
    this._cartList = tempList;
    //计算总价
    this.computeAllPrice();
    Storage.setString('cartList', json.encode(this._cartList));
    notifyListeners();
  }
}
