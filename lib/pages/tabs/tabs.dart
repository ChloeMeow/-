import 'package:flutter/material.dart';
import 'package:jingdong_app/pages/tabs/cart.dart';
import 'package:jingdong_app/pages/tabs/category.dart';
import 'package:jingdong_app/pages/tabs/home.dart';
import 'package:jingdong_app/pages/tabs/user.dart';
import 'package:jingdong_app/services/screen_adapter.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  //创建页面控制器
  var _pageController;
  @override
  void initState() {
    //页面控制器初始化
    _pageController = PageController(initialPage: this._currentIndex);
    super.initState();
  }

  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    //索引不等于3
    return Scaffold(
      appBar: _currentIndex!=3?AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.center_focus_weak,
            size: 28,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
        title: InkWell(
          child: Container(
              height: ScreenAdapter.height(68),
              decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.only(left: ScreenAdapter.width(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.search),
                  Text(
                    "笔记本",
                    style: TextStyle(fontSize: ScreenAdapter.sp(28)),
                  ),
                ],
              )),
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.message,
                size: 28,
                color: Colors.black87,
              ),
              onPressed: () {}),
        ],
      ):AppBar(
        title: Text("用户中心"),
      ),
      //body: this._pageList[this._currentIndex],

      //切换页面状态,所有页面都保持状态方法
      // body: IndexedStack(
      //   index: this._currentIndex,
      //   children: _pageList,
      // ),

      //部分页面需要保持状态方法,必须用PageView加载不同的页面
      body: PageView(
        controller: _pageController,
        children: this._pageList,
        onPageChanged: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(), //禁止Pageview滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            //this._currentIndex = index;
            //部分页面需要保持状态方法,页面控制器进行跳转
            _pageController.jumpToPage(index);
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
