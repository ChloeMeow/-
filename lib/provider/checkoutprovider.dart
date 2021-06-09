import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jingdong_app/services/storage.dart';

class CheckOutProvider with ChangeNotifier {
  List _checkOutListData = []; //结算页面数据

  List get checkOutListData => this._checkOutListData;

  changeCheckOutListData(data) {
    this._checkOutListData = data;
    notifyListeners();
  }
}
