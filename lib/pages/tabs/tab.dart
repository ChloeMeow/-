import 'package:flutter/material.dart';
import 'package:jingdong_app/pages/tabs/cart.dart';
import 'package:jingdong_app/pages/tabs/category.dart';
import 'package:jingdong_app/pages/tabs/home.dart';
import 'package:jingdong_app/pages/tabs/user.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 1;
  List _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("京东"),
      ),
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "分类",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "购物车",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "我的",
          ),
        ],
      ),
    );
  }
}
