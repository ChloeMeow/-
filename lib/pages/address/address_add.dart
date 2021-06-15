import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/model/focusmodel.dart';
import 'package:jingdong_app/services/eventbus.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/sign_services.dart';
import 'package:jingdong_app/services/user_services.dart';
import 'package:jingdong_app/widget/jdbutton.dart';
import 'package:jingdong_app/widget/jdtext.dart';
import 'package:city_pickers/city_pickers.dart';

class AddressAddPage extends StatefulWidget {
  AddressAddPage({Key key}) : super(key: key);

  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';
  String name = '';
  String phone = '';
  String address = '';

  //监听地址页面销毁的事件
  dispose() {
    super.dispose();
    eventBus.fire(AddressEvent('增加成功……'));
    eventBus.fire(CheckOutEvent('修改收货地址成功'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('增加收货地址'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(10)),
        child: ListView(children: <Widget>[
          SizedBox(height: ScreenAdapter.height(20)),
          JdText(
            text: '收货人姓名',
            maxLength: 6,
            onChanged: (value) {
              this.name = value;
            },
          ),
          SizedBox(height: ScreenAdapter.height(20)),
          JdText(
              text: '收货人电话',
              maxLength: 11,
              onChanged: (value) {
                this.phone = value;
              }),
          SizedBox(height: ScreenAdapter.height(10)),
          Container(
              padding: EdgeInsets.only(left: ScreenAdapter.width(10)),
              height: ScreenAdapter.height(68),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 1,
                color: Colors.black12,
              ))),
              child: InkWell(
                onTap: () async {
                  Result result = await CityPickers.showCityPicker(
                    context: context,
                    locationCode: '110100',
                    cancelWidget: Text('取消',
                        style: TextStyle(
                          color: Colors.blue,
                        )),
                    confirmWidget: Text('确定',
                        style: TextStyle(
                          color: Colors.blue,
                        )),
                  );
                  print(result);
                  setState(() {
                    this.area =
                        "${result.provinceName}/${result.cityName}/${result.areaName}";
                  });
                },
                child: Row(children: <Widget>[
                  Icon(Icons.add_location),
                  this.area.length > 0
                      ? Text(
                          '${this.area}',
                          style: TextStyle(color: Colors.black54),
                        )
                      : Text(
                          '省/市/区',
                          style: TextStyle(color: Colors.black54),
                        ),
                ]),
              )),
          SizedBox(height: ScreenAdapter.height(10)),
          JdText(
            text: '详细地址',
            onChanged: (value) {
              this.address = '${this.area} ${value}}';
            },
            maxLength: 4,
            height: 200,
          ),
          SizedBox(height: ScreenAdapter.height(40)),
          JdButton(
            text: '增加',
            color: Colors.red,
            cb: () async {
              List userinfo = await UserServices.getUserInfo();
              print(userinfo);
              var tempJson = {
                'uid': userinfo[0]['_id'],
                'name': this.name,
                'phone': this.phone,
                'address': this.address,
                'salt': userinfo[0]['salt'],
              };
              var sign = SignServices.getSign(tempJson);
              print(sign);
              var api = '${Config.domain}api/addAddress';
              var result = await Dio().post(api, data: {
                'uid': userinfo[0]['_id'],
                'name': this.name,
                'phone': this.phone,
                'address': this.address,
                'sign': sign,
              });
              print(result);
              if (result.data['success']) {
                Navigator.pop(context);
              }

              // var focusList = FocusModel.fromJson(result.data);
            },
          )
        ]),
      ),
    );
  }
}
