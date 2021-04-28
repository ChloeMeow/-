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

class _CommodityState extends State<Commodity> {
  ProductContentitem _productContent;
  List _attr = [];
  @override
  void initState() {
    super.initState();
    //把上一层对象数据赋值给它
    this._productContent = widget._productContentList[0];
    this._attr = this._productContent.attr;
    print(this._attr);
  }

  //封装一个组件，渲染attr
  List<Widget> _getAttrWidget() {
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
              children: _getAttrItemWidget(attrItem),
            ),
          ),
        ],
      ));
    });
    return attrList;
  }

  //attr每一项选项
  List<Widget> _getAttrItemWidget(attrItem) {
    List<Widget> attrItemList = [];
    attrItem.list.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(5),
        child: Chip(
          label: Text("${item}"),
          padding: EdgeInsets.all(10),
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
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            //解决点击消失的问题
            onTap: () {
              //点击收回
              Navigator.of(context).pop();
            },
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: ListView(
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _getAttrWidget())
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
                            margin: EdgeInsets.fromLTRB(ScreenAdapter.width(10),
                                0, ScreenAdapter.width(10), 0),
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
                            margin: EdgeInsets.fromLTRB(ScreenAdapter.width(10),
                                0, ScreenAdapter.width(10), 0),
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
          Column(
            children: [
              Container(
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
                      Text("115,黑色，xxl,一件")
                    ],
                  ),
                ),
              ),
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
