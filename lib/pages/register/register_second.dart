import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/widget/jdbutton.dart';
import 'package:jingdong_app/widget/jdtext.dart';

class RegisterSecondPage extends StatefulWidget {
  Map arguments;
  RegisterSecondPage({Key key, this.arguments}) : super(key: key);

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  String tel;
  //重新发送开关
  bool setCodeBtn = false;
  //倒计时秒数
  int seconds = 10;
  String code;

  @override
  void initState() {
    this.tel = widget.arguments['tel'];
    super.initState();
    this._showTimer();
  }

  //倒计时
  _showTimer() {
    Timer t;
    t = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        this.seconds--;
      });
      if (this.seconds == 0) {
        t.cancel(); //清定时器
        this.setCodeBtn = true;
      }
    });
  }

  //重新发送验证码
  sendCode() async {
    setState(() {
      this.setCodeBtn = false;
      this.seconds = 10;
      this._showTimer();
    });
    //发送验证码接口
    var api = '${Config.domain}api/sendCode';
    var response = await Dio().post(api, data: {'tel': this.tel});
    if (response.data['success']) {
      print(response); //演示期间服务器直接返回 给手机发送的验证码
    } else {
      Fluttertoast.showToast(
        msg: '${response.data["message"]}',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  //验证验证码
  validateCode() async {
    //发送验证码接口
    var api = '${Config.domain}api/validateCode';
    var response = await Dio().post(api, data: {'tel': this.tel,'code': this.code});
    if (response.data['success']) {
      Navigator.pushNamed(context, '/registerthird');
    }else{
      Fluttertoast.showToast(
        msg: '${response.data["message"]}',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第二步'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: ScreenAdapter.height(50)),
            Container(
              padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
              child: Text('验证码已发送，请输入{$tel}手机号收到的验证码'),
            ),
            SizedBox(
              height: ScreenAdapter.height(20),
            ),
            Stack(
              children: <Widget>[
                JdText(
                  text: '请输入验证码',
                  onChanged: (value) {
                    //print(value);
                    this.code=value;
                  },
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: this.setCodeBtn
                      ? RaisedButton(
                          onPressed: sendCode,
                          child: Text('重新发送'),
                        )
                      : RaisedButton(
                          onPressed: () {},
                          child: Text('${this.seconds}秒后重发'),
                        ),
                )
              ],
            ),
            SizedBox(height: ScreenAdapter.height(50)),
            JdButton(
              height: 78,
              text: '下一步',
              color: Colors.orangeAccent,
              cd: this.validateCode,
            ),
          ],
        ),
      ),
    );
  }
}
