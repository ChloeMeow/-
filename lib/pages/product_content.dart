import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/model/productcontentmodel.dart';
import 'package:jingdong_app/pages/productcontent/commodity.dart';
import 'package:jingdong_app/pages/productcontent/evaluation.dart';
import 'package:jingdong_app/pages/productcontent/productdetails.dart';
import 'package:jingdong_app/provider/cartprovider.dart';
import 'package:jingdong_app/services/cart_services.dart';
import 'package:jingdong_app/services/eventbus.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/widget/jdbutton.dart';
import 'package:jingdong_app/widget/loadingwidget.dart';
import 'package:provider/provider.dart';
//广播

class ProductContentPage extends StatefulWidget {
  final Map arguments;
  ProductContentPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  List _productContentList = [];

  @override
  void initState() {
    super.initState();

    this._getContentData();
  }

  _getContentData() async {
    var api = '${Config.domain}api/pcontent?id=${widget.arguments['id']}';
    print(api);
    var result = await Dio().get(api);
    var productContent = ProductContentModel.fromJson(result.data);
    print(productContent.result);
    setState(() {
      this._productContentList.add(productContent.result);
    });
  }

  final List<Tab> _tabs = <Tab>[
    Tab(
      text: "商品",
    ),
    Tab(text: "详情"),
    Tab(text: "评价"),
  ];

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: ScreenAdapter.width(400),
                  child: TabBar(
                    indicatorColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: _tabs,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            ScreenAdapter.width(500),
                            ScreenAdapter.height(76),
                            ScreenAdapter.width(10),
                            0),
                        items: [
                          PopupMenuItem(
                              child: Row(
                            children: [
                              Icon(
                                Icons.home,
                              ),
                              Text('首页'),
                            ],
                          )),
                          PopupMenuItem(
                              child: Row(
                            children: [
                              Icon(
                                Icons.search,
                              ),
                              Text('搜索'),
                            ],
                          )),
                        ]);
                  })
            ],
          ),
          body: this._productContentList.length > 0
              ? Stack(
                  children: [
                    TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Commodity(this._productContentList),
                        ProductDetails(this._productContentList),
                        Evaluation(this._productContentList),
                      ],
                    ),
                    Positioned(
                        width: ScreenAdapter.width(750),
                        height: ScreenAdapter.height(80),
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              )),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: ScreenAdapter.height(5)),
                                width: ScreenAdapter.width(120),
                                height: ScreenAdapter.width(100),
                                child: Column(children: <Widget>[
                                  Icon(Icons.shopping_cart),
                                  Text("购物车"),
                                ]),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: JdButton(
                                    color: Color.fromRGBO(255, 1, 0, 0.9),
                                    text: "加入购物车",
                                    cd: () async {
                                      if (this
                                              ._productContentList[0]
                                              .attr
                                              .length >
                                          0) {
                                        //广播弹出筛选
                                        eventBus
                                            .fire(ProductContentEvent('加入购物车'));
                                      } else {
                                        //等待数据加入购物车以后再通知其他页面更新数据
                                        // print("加入购物车");
                                        await CartServices.addCart(
                                            this._productContentList[0]);
                                        //调用Provider更新数据
                                        cartProvider.updateCartList();
                                      }
                                    },
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: JdButton(
                                    color: Color.fromRGBO(255, 165, 0, 0.9),
                                    text: "立即购买",
                                    cd: () {
                                      if (this
                                              ._productContentList[0]
                                              .attr
                                              .length >
                                          0) {
                                        //广播弹出筛选
                                        eventBus
                                            .fire(ProductContentEvent('立即购买'));
                                      } else {
                                        print("立即购买");
                                      }
                                    },
                                  )),
                            ],
                          ),
                        ))
                  ],
                )
              : LoadingWidget(),
        ));
  }
}
