import 'package:flutter/material.dart';
import 'package:jingdong_app/pages/cart/cartnum.dart';
import 'package:jingdong_app/provider/cartprovider.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  CartItem({Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(200),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(60),
            child: Checkbox(
              value: true,
              onChanged: (value) {},
              activeColor: Colors.pink,
            ),
          ),
          Container(
            width: ScreenAdapter.width(165),
            child: Image.network(
              'https://www.itying.com/images/flutter/list3.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                        maxLines: 2,
                      ),
                      Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '￥12',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CartNum(),
                        )
                      ])
                    ]),
              ))
        ],
      ),
    );
  }
}
