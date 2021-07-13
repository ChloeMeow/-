
//计算总价
import 'dart:convert';

import 'package:jingdong_app/services/storage.dart';

class CheckOutServices {
  //计算总价
                    //计算商品数据
  static getAllPrice(checkOutListData) {
    var tempAllPrice = 0.0;
    for (var i = 0; i < checkOutListData.length; i++) {
      if (checkOutListData[i]['checked'] == true) {
        tempAllPrice +=
            checkOutListData[i]['price'] * checkOutListData[i]['count'];
      }
    }
    return tempAllPrice;
  }
  //删除数据
  static removeUnSelectedCartItem() async {
    List _cartList = [];
    List _tempList = [];
    //获取购物车数据
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      _cartList = cartListData;
    } catch (e) {
      _cartList = [];
    }
    
    //循环时把未选中的放进_tempList
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]['checked'] == false) {
        //获取到没有勾选的数据
        _tempList.add(_cartList[i]);
      }
    }
    //把_tempList本地存储
    Storage.setString('cartList', json.encode(_tempList));
  
  }
}
