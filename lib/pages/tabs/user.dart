import 'package:flutter/material.dart';
import 'package:jingdong_app/provider/counter.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/user_services.dart';
import 'package:jingdong_app/widget/jdbutton.dart';
import 'package:jingdong_app/widget/listtileitem.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLogin = false;
  List userInfo = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getUserinfo();
  }

  _getUserinfo() async {
    var isLogin = await UserServices.getUserLoginState();
    var userInfo = await UserServices.getUserInfo();

    setState(() {
      this.userInfo = userInfo;
      this.isLogin = isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("用户中心"),
        // ),
        body: ListView(
      children: <Widget>[
        Container(
          height: ScreenAdapter.height(220),
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/user_bg.png'),
                  fit: BoxFit.cover)),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/user.jpg',
                    fit: BoxFit.cover,
                    width: ScreenAdapter.width(100),
                    height: ScreenAdapter.width(100),
                  ),
                ),
              ),
              !this.isLogin
                  ? Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text("登录/注册",
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("用户名：${this.userInfo[0]["username"]}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenAdapter.sp(32))),
                          Text("普通会员",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenAdapter.sp(24))),
                        ],
                      ),
                    )
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.assignment, color: Colors.red),
          title: Text("全部订单"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment, color: Colors.green),
          title: Text("待付款"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.local_car_wash, color: Colors.orange),
          title: Text("待收货"),
        ),
        Container(
            width: double.infinity,
            height: 10,
            color: Color.fromRGBO(242, 242, 242, 0.9)),
        ListTile(
          leading: Icon(Icons.favorite, color: Colors.lightGreen),
          title: Text("我的收藏"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.people, color: Colors.black54),
          title: Text("在线客服"),
        ),
        Divider(),
        JdButton(
          text: "退出登录",
          cb: () {
            UserServices.loginOut();
            this._getUserinfo();
          },
        )
      ],
    ));
  }
}
