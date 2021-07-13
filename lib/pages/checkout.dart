import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/provider/cartprovider.dart';
import 'package:jingdong_app/provider/checkoutprovider.dart';
import 'package:jingdong_app/services/eventbus.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/sign_services.dart';
import 'package:jingdong_app/services/user_services.dart';
import 'package:jingdong_app/services/checkout_services.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List addressList = [];
  @override
  void initState() {
    super.initState();
    this._getDefaultAddress();

    //监听增加收货地址的广播
    eventBus.on<CheckOutEvent>().listen((event) {
      print(event.str);
      this._getDefaultAddress();
    });
  }

  //获取用户收货地址
  _getDefaultAddress() async {
    List userinfo = await UserServices.getUserInfo();
    print(userinfo);
    var tempJson = {
      //需要签名字段
      'uid': userinfo[0]['_id'],
      'salt': userinfo[0]['salt'],
    };
    var sign = SignServices.getSign(tempJson);
    print(sign);
    var api =
        '${Config.domain}api/oneAddressList?uid=${userinfo[0]['_id']}&sign=${sign}';
    var response = await Dio().get(api);
    print(response);
    //异步方法所以要赋值
    setState(() {
      this.addressList = response.data["result"];
    });
  }

  Widget _checkOutItem(item) {
    return Row(
      children: <Widget>[
        Container(
          width: ScreenAdapter.width(165),
          child: Image.network(
            '${item['pic']}',
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
                      '${item['title']}',
                      maxLines: 2,
                    ),
                    Text(
                      '${item['selectedAttr']}',
                      maxLines: 1,
                    ),
                    Stack(children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '￥${item['price']}',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('X${item['count']}'),
                      )
                    ])
                  ]),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var checkOutProvider = Provider.of<CheckOutProvider>(context);
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            }),
        title: Text('结算'),
      ),
      body: Stack(
        children: [
          ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: ScreenAdapter.height(10),
                    bottom: ScreenAdapter.height(10)),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    this.addressList.length > 0
                        ? ListTile(
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      '${this.addressList[0]['name']} ${this.addressList[0]['phone']}'),
                                  SizedBox(
                                    height: ScreenAdapter.height(18),
                                  ),
                                  Text('${this.addressList[0]['address']}'),
                                ]),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () {
                              Navigator.pushNamed(context, '/addressList');
                            })
                        : ListTile(
                            leading: Icon(Icons.add_location),
                            title: Center(child: Text('请添加收货地址')),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () {
                              Navigator.pushNamed(context, '/addressAdd');
                            }),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenAdapter.height(20),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                  children: checkOutProvider.checkOutListData.map((value) {
                    return Column(children: <Widget>[
                      _checkOutItem(value),
                      Divider(),
                    ]);
                  }).toList(),
                ),
              ),
              SizedBox(
                height: ScreenAdapter.height(20),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('商品总价'),
                      Divider(),
                      Text('uuu'),
                      Divider(),
                      Text('运费')
                    ]),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              // width: ScreenAdapter.width(750),
              // height: ScreenAdapter.height(100),
              child: Container(
                padding: EdgeInsets.all(ScreenAdapter.width(10)),
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(100),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black38))),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('总价￥160',
                          style: TextStyle(
                            color: Colors.red,
                          )),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          onPressed: () async {
                            print("111");
                            if(this.addressList.length>0){
                              List userinfo = await UserServices.getUserInfo();
                              //商品数据
                              //商品总价保留一位小数
                              var allPrice = CheckOutServices.getAllPrice(
                                      //转换为String类型并保留一位小数
                                      checkOutProvider.checkOutListData)
                                  .toStringAsFixed(1);
                              //获取签名
                              var sign = SignServices.getSign({
                                'uid': userinfo[0]['_id'],
                                'phone': this.addressList[0]['phone'],
                                'address': this.addressList[0]['address'],
                                'name': this.addressList[0]['name'],
                                'all_price': allPrice,
                                //把list数据转换为js字符串
                                'products': json
                                    .encode(checkOutProvider.checkOutListData),
                                'salt': userinfo[0]['salt'],
                              });

                              //请求接口
                              var api = '${Config.domain}api/doOrder';
                              var response = await Dio().post(api, data: {
                                'uid': userinfo[0]['_id'],
                                'phone': this.addressList[0]['phone'],
                                'address': this.addressList[0]['address'],
                                'name': this.addressList[0]['name'],
                                'all_price': allPrice,
                                //把list数据转换为js字符串
                                'products': json
                                    .encode(checkOutProvider.checkOutListData),
                                'sign': sign
                              });
                              print(response);
                              if (response.data['success']) {
                                //print('提交订单成功，跳转支付页面');
                                //加上await把异步改成同步
                                //删除购物车选中的商品数据
                                await CheckOutServices.removeUnSelectedCartItem();

                                //调用CartProvider更新购物车数据
                                cartProvider.updateCartList();
                                //跳转到支付页面
                                Navigator.pushNamed(context, '/pay');
                              }
                            }else{
                              Fluttertoast.showToast(
                                msg: '请填写收货地址',
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_SHORT,
                              );
                            }

                          },
                          child: Text('立即下单',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          color: Colors.orangeAccent,
                        ))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
