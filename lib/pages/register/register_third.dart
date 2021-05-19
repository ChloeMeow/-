import 'package:flutter/material.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/widget/jdbutton.dart';
import 'package:jingdong_app/widget/jdtext.dart';

class RegisterThirdPage extends StatefulWidget {
  RegisterThirdPage({Key key}) : super(key: key);

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第三步'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: ScreenAdapter.height(50),
            ),
            JdText(
              text: '请输入密码',
              password: true,
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(
              height: ScreenAdapter.height(10),
            ),
            JdText(
              text: '再次确认密码',
              password: true,
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(
              height: ScreenAdapter.height(30)
            ),
            JdButton(
              height: 78,
              text: '登录',
              color: Colors.orangeAccent,
              cd: (){},
            ),
          ]
        ),
      )
    );
  }
}
