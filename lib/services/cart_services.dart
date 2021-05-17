import 'dart:convert';

import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/services/storage.dart';

class CartServices {
  static addCart(item) async {
    //把对象转换成Map类型的数据
    item = CartServices.formatCartData(item);
    print(item);

    /*
    1、获取本地存储里面的数据  (cartList)

    2、判断本地存储的cartList是否有数据

      2.1、如果有数据 

        1、判断购物车有没有当前数据：
          有当前数据
            1.让购物车中的当前数据数量 等于以前的数量+现在的数量
            2.重新写入本地存储
        2、没有当前数据
            1.把购物车cartList的数据和当前数据拼接，拼接后重新写入本地存储           

      2.2、如果没有数据
        1.把当前商品数据以及属性数据放在数组中然后写入本地存储·


    */

    try {
      //把获取数据转换成Map类型对象
      List cartListData = json.decode(await Storage.getString('cartList'));
      //循环判断购物车有没有当前数据
      bool hasData = cartListData.any((value) {
        return value['_id'] == item['_id'] &&value['selectedAttr'] == item['selectedAttr'];
      });
      if (hasData) {
        for (var i = 0; i < cartListData.length; i++) {
          if (cartListData[i]['_id'] == item['id'] &&
              cartListData[i]['selectedAttr'] == item['selectedAttr']) {
            cartListData[i]['count'] = cartListData[i]['count'] + 1;
          }
        }
        await Storage.setString('cartList', json.encode(cartListData));
      } else {
        //如果没有数据重新写入
        cartListData.add(item);
        await Storage.setString('cartList', json.encode(cartListData));
      }
    } catch (e) {
      //本地存储没有数据
      List tempList = [];
      tempList.add(item);
      //数据重新写入
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  //过滤数据
  static formatCartData(item) {
     //处理图片
    String pic = item.pic;
    //网址斜杠转换
    pic = Config.domain + pic.replaceAll('\\', '/');
    final Map data = Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    //处理String和int类型的价格
    if(item.price is int || item.price is double){
      data['price'] = item.price;
    }else{
      data['price'] = double.parse(item.price);
    }
    //data['price'] = item.price;
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = pic;
    //是否选中
    data['checked'] = true;
    return data;
  }
}
