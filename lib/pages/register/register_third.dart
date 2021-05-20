import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/pages/tabs/tabs.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/storage.dart';
import 'package:jingdong_app/widget/jdbutton.dart';
import 'package:jingdong_app/widget/jdtext.dart';

class RegisterThirdPage extends StatefulWidget {
  Map arguments;
  RegisterThirdPage({Key key, this.arguments}) : super(key: key);

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  String tel;
  String code;
  String password = '';
  String rpassword = '';

  @override
  void initState() {
    super.initState();
    this.tel = widget.arguments['tel'];
    this.code = widget.arguments['code'];
  }

  //注册
  doRegister() async {
    if (password.length < 6) {
      Fluttertoast.showToast(
        msg: '密码长度不能少于6位数',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else if (rpassword != password) {
      Fluttertoast.showToast(
        msg: '两次输入密码不一致',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      var api = '${Config.domain}api/register';
      var response = await Dio().post(api, data: {
        'tel': this.tel,
        'code': this.code,
        'password': this.password
      });
      if (response.data['success']) {
        //保存用户信息，返回根
        Storage.setString('userInfo', json.encode(response.data['userInfo']));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Tabs()),
            (route) => route == null);
      } else {
        Fluttertoast.showToast(
          msg: '${response.data['message']}',
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('用户注册-第三步'),
        ),
        body: Container(
          padding: EdgeInsets.all(ScreenAdapter.width(20)),
          child: ListView(children: <Widget>[
            SizedBox(
              height: ScreenAdapter.height(50),
            ),
            JdText(
              text: '请输入密码',
              password: true,
              onChanged: (value) {
                //print(value);
                this.password = value;
              },
            ),
            SizedBox(
              height: ScreenAdapter.height(10),
            ),
            JdText(
              text: '再次确认密码',
              password: true,
              onChanged: (value) {
                //print(value);
                this.rpassword = value;
              },
            ),
            SizedBox(height: ScreenAdapter.height(30)),
            JdButton(
              height: 78,
              text: '注册',
              color: Colors.orangeAccent,
              cb: doRegister,
            ),
          ]),
        ));
  }
}
