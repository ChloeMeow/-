import 'package:flutter/material.dart';
import 'package:jingdong_app/pages/cart/cartitem.dart';
import 'package:jingdong_app/pages/cart/cartnum.dart';
import 'package:jingdong_app/provider/cartprovider.dart';
import 'package:jingdong_app/provider/counter.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // var counterProvider = Provider.of<Counter>(context);
    //var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        actions: [IconButton(icon: Icon(Icons.launch), onPressed: () {})],
      ),
      body: Stack(children: <Widget>[
        ListView(children: <Widget>[
          CartItem(),
        ]),
        Positioned(
            bottom: 0,
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(78),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.black12))),
              child: Stack(children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(children: <Widget>[
                    Container(
                      width: ScreenAdapter.width(60),
                      child: Checkbox(
                          value: true,
                          activeColor: Colors.pink,
                          onChanged: (value) {}),
                    ),
                    Text('全选')
                  ]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.red,
                      child: Text('结算',
                          style: TextStyle(
                              fontSize: ScreenAdapter.sp(28),
                              color: Colors.white)),
                    ),
                  ),
                )
              ]),
            ))
      ]),
    );
  }
}
