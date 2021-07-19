import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/model/ordermodel.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/sign_services.dart';
import 'package:jingdong_app/services/user_services.dart';
//订单列表数据模型

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List _orderList = [];

  @override
  void initState() {
    super.initState();
    this._getListData();
  }

  //void表示这个方法需要返回
  void _getListData() async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {'uid': userinfo[0]['_id'], 'salt': userinfo[0]['salt']};
    var sign = SignServices.getSign(tempJson);
    var api =
        '${Config.domain}api/orderList?uid=${userinfo[0]['_id']}&sign=${sign}';
    print(api);
    var response = await Dio().get(api);
    print(response.data is Map);
    setState(() {
      //this._orderList = OrderModel.fromJson(response.data).result;
      var orderModel = OrderModel.fromJson(response.data);
      this._orderList = orderModel.result;
      print(this._orderList[0].name);
    });
  }

  //自定义商品列表组件
  List<Widget> _orderItemWidget(orderItems) {
    List<Widget> tempList = [];
    for (var i = 0; i < orderItems.length; i++) {
      tempList.add(
        Column(
          children: <Widget>[
            SizedBox(height: 10),
            ListTile(
                leading: Container(
                  width: ScreenAdapter.width(130),
                  height: ScreenAdapter.height(130),
                  child: Image.network(
                    '${orderItems[i].productImg}',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('${orderItems[i].productTitle}'),
                trailing: Text('${orderItems[i].productCount}'),
                onTap: () {
                  Navigator.pushNamed(context, '/orderinfo');
                }),
          ],
        ),
      );
      return tempList;
    }
  }

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
              children: this._orderList.map((value) {
                return Card(
                  child: Column(children: <Widget>[
                    ListTile(
                      title: Text(
                        '订单编号:${value.sId}',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Divider(),
                    Column(
                      children: this._orderItemWidget(value.orderItem),
                    ),
                    SizedBox(
                      height: ScreenAdapter.height(20),
                    ),
                    ListTile(
                      title: Text('合计：￥${value.allPrice}'),
                      trailing: FlatButton(
                        onPressed: () {},
                        child: Text('申请售后'),
                        color: Colors.grey[100],
                      ),
                    )
                  ]),
                );
              }).toList(),
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
