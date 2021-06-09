import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/services/eventbus.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/storage.dart';
import 'package:jingdong_app/widget/jdbutton.dart';
import 'package:jingdong_app/widget/jdtext.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //监听登录页面销毁的事件
  dispose() {
    super.dispose();
    eventBus.fire(UserEvent('登录成功……'));
  }

  String username = '';
  String password = '';
  doLogin() async {
    RegExp reg = RegExp(r"^1\d{10}$");
    if (!reg.hasMatch(this.username)) {
      Fluttertoast.showToast(
        msg: '手机号格式错误',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else if (password.length < 6) {
      Fluttertoast.showToast(
        msg: '密码错误',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      //发送验证码接口
      var api = '${Config.domain}api/doLogin';
      var response = await Dio().post(api,
          data: {'username': this.username, 'password': this.password});
      if (response.data['success']) {
        print(response.data); //演示期间服务器直接返回 给手机发送的验证码
        //保存用户信息，返回根
        Storage.setString('userInfo', json.encode(response.data['userinfo']));
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
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
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text('客服'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                height: ScreenAdapter.height(180),
                width: ScreenAdapter.width(180),
                child: Image.asset(
                  'assets/images/login.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(30),
            ),
            JdText(
              text: '请输入用户名',
              onChanged: (value) {
                //print(value);
                this.username = value;
              },
            ),
            SizedBox(
              height: ScreenAdapter.height(10),
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
              height: ScreenAdapter.height(20),
            ),
            Container(
              padding: EdgeInsets.all(ScreenAdapter.width(20)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '忘记密码',
                      style: TextStyle(
                          fontSize: ScreenAdapter.sp(32),
                          color: Colors.black54),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/registerfirst');
                      },
                      child: Text(
                        '新用户注册',
                        style: TextStyle(
                            fontSize: ScreenAdapter.sp(32),
                            color: Colors.black54),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: ScreenAdapter.height(30)),
            JdButton(
              height: 78,
              text: '登录',
              color: Colors.orangeAccent,
              cb: doLogin,
            ),
          ],
        ),
      ),
    );
  }
}
