import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jingdong_app/config/config.dart';
//轮播图类模型
import 'package:jingdong_app/model/focusmodel.dart';
import 'package:jingdong_app/model/productmodel.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/search_services.dart';
import 'dart:convert';

import 'package:jingdong_app/widget/loadingwidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//部分页面需要保持状态方法,自动保持活着的客户端混合
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List _foucusData = [];
  List _hotProductList = [];
  List _bestProductList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();

    //  // var mapData = {"name": "张三", "age": "20"}; //Json 字符串转化成 Map 类型
    //   var strData = '{"name":"张三","age":"20"}';
    //   var result = json.decode(strData); //Map 转换成 Json 字符串

    //  //类型安全，自动补全和最重要的编译时异常
    //   print(result['name']);
    //   //print(json.decode(strData));

    // var strData =
    //     '{"_id":"59f6ef443ce1fb0fb02c7a43","title":"笔记本电脑 ","status":"1","pic":"public\\upload\\UObZahqPYzFvx_C9CQjU8KiX.png"," url":"12" }';
    // var data = FocusModel.fromJson(json.decode(strData));
    // print(data.sId);
  }

  //获取轮播图数据
  _getFocusData() async {
    var api = '${Config.domain}api/focus';
    var result = await Dio().get(api);
    //print(foucusData.data is Map);
    var focusList = FocusModel.fromJson(result.data);

    // focusList.result.forEach((value) {
    //   print(value.title);
    //   print(value.pic);

    // });
    setState(() {
      this._foucusData = focusList.result;
    });
  }

  //获取猜你喜欢数据
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    var hotProductList = ProductModel.fromJson(result.data);
    setState(() {
      this._hotProductList = hotProductList.result;
    });
  }

  //获取热门推荐数据
  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);
    print(bestProductList.result);
    setState(() {
      this._bestProductList = bestProductList.result;
    });
  }

  Widget _swiperWidget() {
    // List<Map> imgList = [
    //   {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
    //   {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
    //   {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    // ];
    if (this._foucusData.length > 0) {
      return Container(
        //纵横比
        child: AspectRatio(
          //宽高比
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String pic = this._foucusData[index].pic;
              //网址斜杠转换
              pic = Config.domain + pic.replaceAll('\\', '/');
              return Image.network(
                '${pic}',
                fit: BoxFit.fill,
              );
            },
            itemCount: this._foucusData.length,
            pagination: SwiperPagination(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return LoadingWidget();
    }
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdapter.height(46),
      margin: EdgeInsets.only(
        left: ScreenAdapter.width(20),
      ),
      padding: EdgeInsets.only(
        left: ScreenAdapter.width(20),
      ),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: ScreenAdapter.width(10),
      ))),
      child: Text(
        value,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  //推荐商品
  Widget _hotProductListWidget() {
    if (this._hotProductList.length > 0) {
      return Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        height: ScreenAdapter.height(240),
        //width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            //处理图片
            String sPic = this._hotProductList[index].sPic;
            //网址斜杠转换
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                  height: ScreenAdapter.height(160),
                  width: ScreenAdapter.width(180),
                  child: Image.network(
                    sPic,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                    height: ScreenAdapter.height(40),
                    child: Text(
                      "￥${this._hotProductList[index].price}",
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            );
          },
          itemCount: _hotProductList.length,
        ),
      );
    } else {
      return LoadingWidget();
    }
  }

  //热门商品
  Widget _recProductListWidget() {
    var itemWidth = (ScreenAdapter.screenwidth() - 30) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: this._bestProductList.map((value) {
          //处理图片
          String sPic = value.sPic;
          //网址斜杠转换
          sPic = Config.domain + sPic.replaceAll('\\', '/');
          return Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.black12,
              width: 1,
            )),
            width: itemWidth,
            child: Column(children: <Widget>[
              Container(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1 / 1, //防止服务器返回的图片大小不一致导致高度不一致问题
                    child: Image.network(
                      "${sPic}",
                      fit: BoxFit.cover,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                child: Text(
                  "${value.title}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "￥${value.price}",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreenAdapter.sp(28),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "￥${value.oldPrice}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScreenAdapter.sp(28),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: ScreenAdapter.height(20)),
        _titleWidget("猜你喜欢"),
        _hotProductListWidget(),
        SizedBox(height: ScreenAdapter.height(20)),
        _titleWidget("热门推荐"),
        _recProductListWidget(),
      ],
    );
  }
}
