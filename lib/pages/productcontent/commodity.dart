import 'package:flutter/material.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/model/productcontentmodel.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/widget/jdbutton.dart';

class Commodity extends StatefulWidget {
  final List _productContentList;
  Commodity(this._productContentList, {Key key}) : super(key: key);

  @override
  _CommodityState createState() => _CommodityState();
}

class _CommodityState extends State<Commodity>
    with AutomaticKeepAliveClientMixin {
  ProductContentitem _productContent;
  bool get wantKeepAlive => true;
  List _attr = [];
  String _selectedValue;
  @override
  void initState() {
    super.initState();
    //把上一层对象数据赋值给它
    this._productContent = widget._productContentList[0];
    this._attr = this._productContent.attr;
    print(this._attr);
    _initAttr();
  }

  //初始化Attr 格式化数据
  //把list:["",""]转换为list:[{}{}],最后把它赋值给了另一个属性
  _initAttr() {
    var attr = this._attr;
    print('-------------111111-------------');
    //print(attr);
    for (var i = 0; i < attr.length; i++) {
      //print(attr[i].cate);
      //print(attr[i].list);
      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].attrList.add({
            "title": attr[i].list[j],
            "checked": true,
          });
        } else {
          attr[i].attrList.add({
            "title": attr[i].list[j],
            "checked": false,
          });
        }
      }
      // print(attr[0].attrList);
      // print(attr[0].cate);
      // print(attr[0].list);
    }
    _getSelectedAttrValue();
  }

  //改变属性值
  _changeAttr(cate, title, setBottomState) {
    var attr = this._attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrList.length; j++) {
          attr[i].attrList[j]['checked'] = false;
          if (title == attr[i].attrList[j]['title']) {
            attr[i].attrList[j]['checked'] = true;
          }
        }
      }
    }
    setBottomState(() {
      //注意，改变showModelBottomSheet里面的数据，来源于StatefulBuilder
      this._attr = attr;
    });
    _getSelectedAttrValue();
  }

  //获取选中的值
  _getSelectedAttrValue() {
    var _list = this._attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].attrList.length; j++) {
        if (_list[i].attrList[j]['checked'] == true) {
          tempArr.add(_list[i].attrList[j]['title']);
        }
      }
    }
    setState(() {
      //把数组转换为字符串
      this._selectedValue = tempArr.join(',');
    });
  }

  //封装一个组件，渲染attr
  List<Widget> _getAttrWidget(setBottomState) {
    List<Widget> attrList = [];
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(100),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(22)),
              child: Text("${attrItem.cate} ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: ScreenAdapter.width(610),
            child: Wrap(
              children: _getAttrItemWidget(attrItem, setBottomState),
            ),
          ),
        ],
      ));
    });
    return attrList;
  }

  //attr每一项选项
  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    attrItem.attrList.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            //分类，名称
            _changeAttr(attrItem.cate, item['title'], setBottomState);
          },
          child: Chip(
            label: Text("${item['title']}"),
            padding: EdgeInsets.all(10),
            backgroundColor: item['checked'] ? Colors.red : Colors.black26,
          ),
        ),
      ));
    });
    return attrItemList;
  }

  //底部弹出框
  _attrBotomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          //StatefulBuilder更新 Flutter showDialog 、 showModalBottomSheet 中的状态
          return StatefulBuilder(
            builder: (BuildContext context, setBottomState) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                //解决点击消失的问题
                onTap: () {
                  return false;
                  //点击收回
                  //Navigator.of(context).pop();
                },
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(20)),
                      child: ListView(
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //存入底部状态
                              children: _getAttrWidget(setBottomState))
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      width: ScreenAdapter.width(750),
                      height: ScreenAdapter.height(76),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    ScreenAdapter.width(10),
                                    0,
                                    ScreenAdapter.width(10),
                                    0),
                                child: JdButton(
                                  color: Color.fromRGBO(255, 1, 0, 0.9),
                                  text: "加入购物车",
                                  cd: () {
                                    print("加入购物车");
                                  },
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    ScreenAdapter.width(10),
                                    0,
                                    ScreenAdapter.width(10),
                                    0),
                                child: JdButton(
                                  color: Color.fromRGBO(255, 165, 0, 0.9),
                                  text: "立即购买",
                                  cd: () {
                                    print("加入购物车");
                                  },
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //处理图片
    String pic = this._productContent.pic;
    //网址斜杠转换
    pic = Config.domain + pic.replaceAll('\\', '/');
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Image.network('${pic}', fit: BoxFit.cover),
          ),
          //主标题
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${this._productContent.title}',
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: ScreenAdapter.sp(36),
                  fontWeight: FontWeight.bold),
            ),
          ),
          //副标题
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${this._productContent.subTitle}',
              style: TextStyle(
                color: Colors.black45,
                fontSize: ScreenAdapter.sp(36),
              ),
            ),
          ),
          //价格
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text("特价"),
                        Text("￥${this._productContent.price}",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenAdapter.sp(46),
                            )),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("原价"),
                        Text("￥${this._productContent.oldPrice}",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: ScreenAdapter.sp(46),
                                decoration: TextDecoration.lineThrough)),
                      ],
                    )),
              ],
            ),
          ),
          //判断分类长度
          this._attr.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: ScreenAdapter.height(10)),
                  height: ScreenAdapter.height(80),
                  child: InkWell(
                    onTap: () {
                      _attrBotomSheet();
                    },
                    child: Row(
                      children: [
                        Text(
                          "已选",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${this._selectedValue}")
                      ],
                    ),
                  ),
                )
              : Text(''),
          Divider(),
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: [
                Text(
                  "运费",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("免运费")
              ],
            ),
          )
        ],
      ),
    );
  }
}
