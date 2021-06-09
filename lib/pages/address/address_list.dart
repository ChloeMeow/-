import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/services/eventbus.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/sign_services.dart';
import 'package:jingdong_app/services/user_services.dart';

class AddressListPage extends StatefulWidget {
  AddressListPage({Key key}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List addressList = [];
  @override
  void initState() {
    super.initState();
    this._getAddressList();
    //监听增加收货地址的广播
    eventBus.on<AddressEvent>().listen((event) {
      print(event.str);
      //重新获取登录信息
      this._getAddressList();
    });
  }

  _getAddressList() async {
    //请求接口
    List userinfo = await UserServices.getUserInfo();
    //要签名的字段
    var tempJson = {
      'uid': userinfo[0]['_id'],
      'salt': userinfo[0]['salt'],
    };
    var sign = SignServices.getSign(tempJson);
    var api =
        '${Config.domain}api/addressList?uid=${userinfo[0]['_id']}&sign=${sign}';
    var response = await Dio().get(api);
    //print(response.data['result']);
    setState(() {
      this.addressList = response.data['result'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址列表'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            SizedBox(height: ScreenAdapter.height(20)),
            ListView.builder(
              itemBuilder: (context, index) {
                if (this.addressList[index]['name']['default_address'] == 1) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: ScreenAdapter.height(20),
                      ),
                      ListTile(
                        leading: Icon(Icons.check, color: Colors.red),
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  '${this.addressList[index]['name']} ${this.addressList[index]['phone']}'),
                              SizedBox(
                                height: ScreenAdapter.height(18),
                              ),
                              Text('${this.addressList[index]['address']}'),
                            ]),
                        trailing: Icon(Icons.edit, color: Colors.blue),
                      ),
                      Divider(
                        height: ScreenAdapter.height(20),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: ScreenAdapter.height(20),
                      ),
                      ListTile(
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  '${this.addressList[index]['name']} ${this.addressList[index]['phone']}'),
                              SizedBox(
                                height: ScreenAdapter.height(18),
                              ),
                              Text('${this.addressList[index]['address']}'),
                            ]),
                        trailing: Icon(Icons.edit, color: Colors.blue),
                      ),
                      Divider(
                        height: ScreenAdapter.height(20),
                      ),
                    ],
                  );
                }
              },
              itemCount: this.addressList.length,
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
                        color: Colors.red,
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black38))),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/addressAdd');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.add, color: Colors.white),
                          Text(
                            '增加收货地址',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
