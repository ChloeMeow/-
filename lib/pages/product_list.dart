import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/model/productmodel.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/search_services.dart';
import 'package:jingdong_app/widget/loadingwidget.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;
  ProductListPage({Key key, this.arguments}) : super(key: key);
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  //Scaffold key通过点击事件打开侧边栏
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  //用于上拉分页
  ScrollController _scrollController = ScrollController(); //listview控制器

  //分页
  int _page = 1;
  //每一页有多少条数据
  int _pageSize = 8;
  //数据
  List _productList = [];

  //排序
  /*
  排序：价格升序 sort=price_1 价格降序 sort=price_-1 销量升序 sort=salecount_1 销量降序 sort=salecount_-1
   */
  String _sort = "";
  //解决重复请求的问题
  bool flag = true;
  //是否有数据
  bool _hasMore = true;
  //是否有搜索的数据
  bool _hasData = true;

  /*二级导航数据*/
  List _subHeaderList = [
    {
      'id': 1,
      'title': '综合',
      'fileds': 'all',
      'sort': -1, //排序：升序：price_1 {price:1} 降序：price_-1 {price_-1}
    },
    {
      'id': 2,
      'title': '销量',
      'fileds': 'salecount',
      'sort':
          -1, //排序：升序：salecount_1 {salecount:1} 降序：salecount_-1 {salecount_-1}
    },
    {
      'id': 3,
      'title': '价格',
      'fileds': 'price',
      'sort': -1,
    },
    {
      'id': 4,
      'title': '筛选',
    },
  ];
  int _selectedHeaderId = 1;

  //配置search搜索框的值
  var _initKeywordsController = TextEditingController();

  //cid
  var _cid;
  //keywords
  var _keywords;

  @override
  void initState() {
    super.initState();
    this._cid = widget.arguments['cid'];
    this._keywords = widget.arguments['keywords'];
    //给search框赋值
    this._initKeywordsController.text = this._keywords;
    //keywords值空就返回空，否则就返回传过来的值
    // widget.arguments['keywords'] == null
    //     ? this._initKeywordsController.text = ""
    //     : this._initKeywordsController.text = widget.arguments['keywords'];
    _getProductListData();
    //监听滚动条滚动事件
    _scrollController.addListener(() {
      //_scrollController.position.pixels;//获取滚动条滚动的高度
      //_scrollController.position.maxScrollExtent;//获取页面高度
      //下拉高度大于页面高度减20，就执行上拉加载更多
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (this.flag && this._hasMore) {
          _getProductListData();
        }
      }
    });
  }

  //获取商品列表的数据
  _getProductListData() async {
    setState(() {
      this.flag = false;
    });
    var api;
    //keywords等于空，代表从商品分类列表跳转过来
    if (this._keywords == null) {
      api =
          '${Config.domain}api/plist?cid=${this._cid}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}';
    } else {
      //否则是从搜索页面跳转过来
      api =
          '${Config.domain}api/plist?search=${this._keywords}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}';
    }

    //print(api);
    var result = await Dio().get(api);
    var productList = ProductModel.fromJson(result.data);
    //判断是否有搜索值
    if (productList.result.length == 0 && this._page == 1) {
      setState(() {
        this._hasData = false;
      });
    } else {
      this._hasData = true;
    }
    print(productList.result.length);
    //判断最后一页有没有数据
    if (productList.result.length < this._pageSize) {
      setState(() {
        //this._productList = productList.result;
        //把新的数据和以前数据拼接，下拉就会加载更多
        this._productList.addAll(productList.result);
        this._hasMore = false;
        this.flag = true;
      });
    } else {
      setState(() {
        //this._productList = productList.result;
        //把新的数据和以前数据拼接，下拉就会加载更多
        this._productList.addAll(productList.result);
        //页面增加
        this._page++;
        this.flag = true;
      });
    }
  }

  Widget _showMore(index) {
    if (this._hasMore) {
      return (index == this._productList.length - 1)
          ? LoadingWidget()
          : Text("");
    } else {
      return (index == this._productList.length - 1)
          ? Text("---我是有底线的---")
          : Text("");
    }
    //每次渲染数据加旋转圈圈
  }

  //商品列表
  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            //处理图片
            String pic = this._productList[index].pic;
            //网址斜杠转换
            pic = Config.domain + pic.replaceAll('\\', '/');
            //每一个元素
            return Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: ScreenAdapter.height(180),
                    width: ScreenAdapter.width(180),
                    child: Image.network(
                      '${pic}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          height: ScreenAdapter.height(180),
                          margin:
                              EdgeInsets.only(left: ScreenAdapter.width(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${this._productList[index].title}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(children: <Widget>[
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: EdgeInsets.only(
                                      right: ScreenAdapter.width(10)),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          Color.fromRGBO(230, 230, 230, 0.9)),
                                  child: Text('4g'),
                                ),
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: EdgeInsets.only(
                                      right: ScreenAdapter.width(10)),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          Color.fromRGBO(230, 230, 230, 0.9)),
                                  child: Text('126'),
                                ),
                              ]),
                              Text(
                                '${this._productList[index].price}',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: ScreenAdapter.sp(18),
                                ),
                              )
                            ],
                          ))),
                ],
              ),
              Divider(height: 20),
              _showMore(index),
            ]);
          },
          itemCount: this._productList.length,
        ),
      );
    } else {
      return LoadingWidget();
    }
  }

  //导航改变的时候触发
  //选中的id等于点击ID
  _subHeaderChange(id) {
    if (id == 4) {
      //通过点击事件打开侧边栏
      _scaffoldKey.currentState.openEndDrawer();
      setState(() {
        this._selectedHeaderId = id;
      });
    } else {
      setState(() {
        this._selectedHeaderId = id;
        this._sort =
            "${this._subHeaderList[id - 1]["fileds"]}_${this._subHeaderList[id - 1]["sort"]}";
        //重置分页
        this._page = 1;
        //重置数据
        this._productList = [];
        this._subHeaderList[id - 1]['sort'] =
            this._subHeaderList[id - 1]['sort'] * -1;
        //回到顶部
        _scrollController.jumpTo(0);
        //重置_hasMore
        this._hasMore = true;
        //重新请求
        this._getProductListData();
      });
    }
  }

  //显示header Icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (this._subHeaderList[id - 1]['sort'] == 1) {
        return Icon(Icons.arrow_drop_down);
      } else {
        return Icon(Icons.arrow_drop_up);
      }
    }
    return Text("");
  }

  //筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
      top: ScreenAdapter.height(0),
      height: ScreenAdapter.height(80),
      width: ScreenAdapter.width(750),
      child: Container(
          height: ScreenAdapter.height(80),
          width: ScreenAdapter.width(750),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            width: 1,
            color: Color.fromRGBO(233, 233, 233, 0.9),
          ))),
          child: Row(
            children: this._subHeaderList.map((value) {
              return Expanded(
                child: InkWell(
                  onTap: () {
                    _subHeaderChange(value['id']);
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(20), 0,
                        ScreenAdapter.height(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${value['title']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: (this._selectedHeaderId == value['id'])
                                  ? Colors.red
                                  : Colors.black54,
                            )),
                        _showIcon(value['id']),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Container(
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: this._initKeywordsController,
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              )),
              onChanged: (value) {
                setState(() {
                  this._keywords = value;
                });
              },
            )),
        actions: [
          InkWell(
            onTap: () {
              this._subHeaderChange(1);
              SearchServices.setHistoryData(this._keywords);
            },
            child: Container(
                height: ScreenAdapter.height(70),
                width: ScreenAdapter.width(80),
                child: Row(
                  children: <Widget>[
                    Text('搜索'),
                  ],
                )),
          )
        ],
      ),
      //通过点击事件打开侧边栏
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: Container(
          child: Text(
            "实现筛选功能",
            style: TextStyle(color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      //body: Text("${widget.arguments}"),
      body: _hasData
          ? Stack(children: <Widget>[
              _productListWidget(),
              _subHeaderWidget(),
            ])
          : Center(
              child: Text("没有您要搜索的数据"),
            ),
    );
  }
}
