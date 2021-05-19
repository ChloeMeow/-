import 'package:flutter/material.dart';
import 'package:jingdong_app/provider/counter.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/widget/listtileitem.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: ScreenAdapter.height(240),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/images/user_bg.png',
              ),
              fit: BoxFit.cover,
            )),
            child: Row(children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ClipOval(
                  child: Image.asset('assets/images/user.jpg',
                      width: ScreenAdapter.width(110),
                      height: ScreenAdapter.height(100),
                      fit: BoxFit.cover),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('登录/注册',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdapter.sp(32),
                      )),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Text(
              //         '用户名：1362789',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: ScreenAdapter.sp(32),
              //         ),
              //       ),
              //       Text(
              //         '普通会员',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: ScreenAdapter.sp(32),
              //         ),
              //       )
              //     ]
              //   ),
              // )
            ]),
          ),
          ListTileItem(
            icon: Icons.home,
            color: Colors.red,
            title: '全部订单',
          ),
          Divider(),
          ListTileItem(
            icon: Icons.payment,
            color: Colors.green,
            title: '待付款',
          ),
          Divider(),
          ListTileItem(
            icon: Icons.home,
            color: Colors.orange,
            title: '待收货',
          ),
          Divider(),
          Container(
            height: ScreenAdapter.height(20),
            width: double.infinity,
            color: Colors.black12,
          ),
          ListTileItem(
            icon: Icons.favorite,
            color: Colors.lightGreen,
            title: '我的收藏',
          ),
          Divider(),
          ListTileItem(
            icon: Icons.home,
            color: Colors.black54,
            title: '在线客服',
          ),
          Divider(),
        ],
      ),
    );
  }
}
