import 'package:flutter/material.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/widget/jdbutton.dart';
import 'package:jingdong_app/widget/jdtext.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                print(value);
              },
            ),
            SizedBox(
              height: ScreenAdapter.height(10),
            ),
            JdText(
              text: '请输入密码',
              password: true,
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(height: ScreenAdapter.height(20),),
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
                        color: Colors.black54
                      ),
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
                          color: Colors.black54
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(30)
            ),
            JdButton(
              height: 78,
              text: '登录',
              color: Colors.orangeAccent,
              cb: (){},
            ),
          ],
        ),
      ),
    );
  }
}
