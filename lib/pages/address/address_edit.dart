import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/services/eventbus.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/sign_services.dart';
import 'package:jingdong_app/services/user_services.dart';
import 'package:jingdong_app/widget/jdbutton.dart';
import 'package:jingdong_app/widget/jdtext.dart';

class AddressEditPage extends StatefulWidget {
  Map arguments;
  AddressEditPage({Key key, this.arguments}) : super(key: key);

  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  String area = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.arguments);
    nameController.text = widget.arguments['name'];
    phoneController.text = widget.arguments['phone'];
    addressController.text = widget.arguments['address'];
  }

  //监听地址页面销毁的事件
  dispose() {
    super.dispose();
    eventBus.fire(AddressEvent('增加成功……'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改收货地址'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(10)),
        child: ListView(children: <Widget>[
          SizedBox(height: ScreenAdapter.height(20)),
          JdText(
            controller: nameController,
            text: '收货人姓名',
            maxLength: 6,
            onChanged: (value) {
              nameController.text = value;
            },
          ),
          SizedBox(height: ScreenAdapter.height(20)),
          JdText(
              controller: phoneController,
              text: '收货人电话',
              maxLength: 11,
              onChanged: (value) {
                phoneController.text = value;
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
            controller: addressController,
            text: '详细地址',
            onChanged: (value) {
              addressController.text = value;
            },
            maxLength: 40,
            height: 200,
          ),
          SizedBox(height: ScreenAdapter.height(40)),
          JdButton(
            text: '修改',
            color: Colors.red,
            cb: () async {
              List userinfo = await UserServices.getUserInfo();
              print(userinfo);
              var tempJson = {
                'uid': userinfo[0]['_id'],
                'id': widget.arguments['id'],
                'name': nameController.text,
                'phone': phoneController.text,
                'address': addressController.text,
                'salt': userinfo[0]['salt'],
              };
              var sign = SignServices.getSign(tempJson);
              print(sign);
              var api = '${Config.domain}api/editAddress';
              var response = await Dio().post(api, data: {
                'uid': userinfo[0]['_id'],
                'id': widget.arguments['id'],
                'name': nameController.text,
                'phone': phoneController.text,
                'address': addressController.text,
                'sign': sign,
              });
              print(response);
              Navigator.pop(context);
            },
          )
        ]),
      ),
    );
  }
}
