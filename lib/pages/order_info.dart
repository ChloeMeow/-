import 'package:flutter/material.dart';
import 'package:jingdong_app/services/screen_adapter.dart';

class OrderInfoPage extends StatefulWidget {
  OrderInfoPage({Key key}) : super(key: key);

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            //收货地址
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(height:ScreenAdapter.height(10)),
                  ListTile(
                    leading: Icon(Icons.add_location),
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              '小礼 13256883523'),
                          SizedBox(
                            height: ScreenAdapter.height(10),
                          ),
                          Text('广东省佛山市禅城区'),
                        ]),
                  ),
                  SizedBox(height:ScreenAdapter.height(10)),
                ],
              ),
            ),
            SizedBox(height:ScreenAdapter.height(10)),
            //列表
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(165),
                        child: Image.network(
                          'http://gfs12.gomein.net.cn/T1PQbvBXx_1RCvBVdK.png',
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
                                    '洗衣机水龙头',
                                    maxLines: 2,
                                  ),
                                  Text(
                                    '水龙头',
                                    maxLines: 1,
                                  ),
                                  ListTile(
                                    leading: Text(
                                      '￥123',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    trailing: Text('*2'),
                                  )
                                ]),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            //详情信息
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('订单编号',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('13626067815839w'),
                      ]
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('下单日期',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('2021-03-16'),
                      ]
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('支付方式',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('支付宝支付'),
                      ]
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('配送方式',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('圆通'),
                      ]
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height:ScreenAdapter.height(10)),
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('总金额',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('￥321元',style: TextStyle(color: Colors.red)),
                      ]
                    ),
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
