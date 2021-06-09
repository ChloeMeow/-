import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong_app/pages/cart/cartitem.dart';
import 'package:jingdong_app/pages/cart/cartnum.dart';
import 'package:jingdong_app/provider/cartprovider.dart';
import 'package:jingdong_app/provider/checkoutprovider.dart';

import 'package:jingdong_app/provider/counter.dart';
import 'package:jingdong_app/services/cart_services.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/user_services.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //结算/取消选择开关
  bool _isEdit = false;
  var checkOutProvider;
  @override
  void initState() {
    super.initState();
  }

  //去结算
  doCheckOut() async {
    //1，获取购物车选中的数据
    List checkOutData = await CartServices.getCheckOutData();
    print(checkOutData);
    //2，保存购物车选中的数据
    this.checkOutProvider.changeCheckOutListData(checkOutData);
    //3，购物车有没有选中的数据
    if (checkOutData.length > 0) {
      //4，判断用户是否登录
      var loginState = await UserServices.getUserLoginState();
      if(loginState){
        Navigator.popAndPushNamed(context, '/checkout');
      }else{
        Fluttertoast.showToast(
        msg: '您还没有登录,请登录以后再结算',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
         Navigator.popAndPushNamed(context, '/login');
      }
    } else {
      Fluttertoast.showToast(
        msg: '购物车没有商品',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
    }

    
  }

  @override
  Widget build(BuildContext context) {
    // var counterProvider = Provider.of<Counter>(context);
    var cartProvider = Provider.of<CartProvider>(context);
    checkOutProvider = Provider.of<CheckOutProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        actions: <Widget>[
          FlatButton(
              child: Text('管理'),
              onPressed: () {
                setState(() {
                  //取反
                  this._isEdit = !this._isEdit;
                });
              })
        ],
      ),
      body: cartProvider.cartList.length > 0
          ? Stack(children: <Widget>[
              ListView(
                children: <Widget>[
                  Column(
                      children: cartProvider.cartList.map((value) {
                    return CartItem(value);
                  }).toList()),
                  SizedBox(height: ScreenAdapter.height(100))
                ],
              ),
              Positioned(
                  bottom: 0,
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(78),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black12))),
                    child: Stack(children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(children: <Widget>[
                          Container(
                            width: ScreenAdapter.width(60),
                            child: Checkbox(
                                value: cartProvider.isCheckedAll,
                                activeColor: Colors.pink,
                                onChanged: (value) {
                                  //实现全选或反选
                                  cartProvider.chenckAll(value);
                                }),
                          ),
                          Text('全选'),
                          SizedBox(width: 20),
                          this._isEdit == false ? Text('合计：') : Text(''),
                          this._isEdit == false
                              ? Text(
                                  '${cartProvider.allPrice}',
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.sp(28),
                                      color: Colors.red),
                                )
                              : Text('')
                        ]),
                      ),
                      this._isEdit == false
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {},
                                child: RaisedButton(
                                  onPressed: doCheckOut,
                                  color: Colors.red,
                                  child: Text('结算',
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.sp(28),
                                          color: Colors.white)),
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {},
                                child: RaisedButton(
                                  onPressed: () {
                                    cartProvider.removeItem();
                                  },
                                  color: Colors.red,
                                  child: Text('删除',
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.sp(28),
                                          color: Colors.white)),
                                ),
                              ),
                            )
                    ]),
                  ))
            ])
          : Center(
              child: Text('购物车空空的……'),
            ),
    );
  }
}
