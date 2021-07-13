import 'package:flutter/material.dart';
import 'package:jingdong_app/services/screen_adapter.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的订单'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(80), 0, 0),
            padding: EdgeInsets.all(ScreenAdapter.width(16)),
            child: ListView(
              children: <Widget>[
                Card(
                  child: Column(children: <Widget>[
                    ListTile(
                      title: Text('订单编号'),
                    ),
                    SizedBox(
                      height: ScreenAdapter.height(20),
                    ),
                    ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(130),
                          height: ScreenAdapter.height(130),
                          child: Image.network(
                            'https://img0.baidu.com/it/u=3101694723,748884042&fm=26&fmt=auto&gp=0.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text('ffffffffff'),
                        trailing: Text('*1'),
                        onTap: () {
                          Navigator.pushNamed(context, '/orderinfo');
                        }),
                    SizedBox(
                      height: ScreenAdapter.height(20),
                    ),
                    ListTile(
                      title: Text('合计：￥46'),
                      trailing: FlatButton(
                        onPressed: () {},
                        child: Text('申请售后'),
                        color: Colors.grey[100],
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
          Positioned(
              top: 0,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(76),
              child: Container(
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(76),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        '全部',
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        '待付款',
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        '待收货',
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        '已完成',
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        '已取消',
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ))),
        ],
      ),
    );
  }
}
