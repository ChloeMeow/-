import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/widget/jdbutton.dart';
import 'package:jingdong_app/widget/jdtext.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key key}) : super(key: key);

  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  //定义手机号
  String tel;
  sendCode() async {
    //验证手机号是否正确,正则表达式，以1开头后面有10位数字
    RegExp reg = RegExp(r"^1\d{10}$");
    if (reg.hasMatch(this.tel)) {
      //发送验证码接口
      var api = '${Config.domain}api/sendCode';
      var response = await Dio().post(api, data: {'tel': this.tel});
      if (response.data['success']) {
        print(response);//演示期间服务器直接返回 给手机发送的验证码
        Navigator.pushNamed(context, '/registersecond',arguments:{
          'tel': this.tel,
        });
      } else {
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
        );
      }
      //print('正确');
    } else {
      Fluttertoast.showToast(
        msg: '手机号格式错误',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第一步'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: ScreenAdapter.height(30)),
            JdText(
              text: '请输入手机号',
              onChanged: (value) {
                this.tel = value;
                //print(value);
              },
            ),
            SizedBox(height: ScreenAdapter.height(50)),
            JdButton(
              height: 78,
              text: '下一步',
              color: Colors.orangeAccent,
              cd: sendCode,
            ),
          ],
        ),
      ),
    );
  }
}
