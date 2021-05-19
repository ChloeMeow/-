import 'package:flutter/material.dart';
import 'package:jingdong_app/pages/cart/cartnum.dart';
import 'package:jingdong_app/provider/cartprovider.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  Map _itemData;

  CartItem(this._itemData, {Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map _itemData;
 

  @override
  Widget build(BuildContext context) {
    //给属性赋值
    this._itemData = widget._itemData;
    var cartProvider = Provider.of<CartProvider>(context);
    return Container(
      height: ScreenAdapter.height(220),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(60),
            child: Checkbox(
              value: _itemData['checked'],
              onChanged: (value) {
                setState(() {
                  //取反
                  _itemData['checked'] = !_itemData['checked'];
                });

                cartProvider.itemChage();
              },
              activeColor: Colors.pink,
            ),
          ),
          Container(
            width: ScreenAdapter.width(165),
            child: Image.network(
              '${_itemData['pic']}',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${_itemData['title']}',
                        maxLines: 2,
                      ),
                      Text(
                        '${_itemData['selectedAttr']}',
                        maxLines: 1,
                      ),
                      Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '￥${_itemData['price']}',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CartNum(_itemData),
                        )
                      ])
                    ]),
              ))
        ],
      ),
    );
  }
}
