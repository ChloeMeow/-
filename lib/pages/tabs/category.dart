import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingdong_app/config/config.dart';
import 'package:jingdong_app/model/catemodel.dart';
import 'package:jingdong_app/services/screen_adapter.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  _getLeftCateData() async {
    var api = '${Config.domain}api/pcate';
    var result = await Dio().get(api);
    var leftCateList = CateModel.fromJson(result.data);
    //print(leftCateList.result);
    setState(() {
      this._leftCateList = leftCateList.result;
    });
    //左侧加载完，把左侧第一条id传到
    _getRightCateData(leftCateList.result[0].sId);
  }

  _getRightCateData(pid) async {
    //等于左侧传过来的pid,
    var api = '${Config.domain}api//pcate?pid=${pid}';
    var result = await Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    //print(leftCateList.result);
    setState(() {
      this._rightCateList = rightCateList.result;
    });
  }

  Widget _leftCateWidget(leftWidth) {
    if (this._leftCateList.length > 0) {
      return Container(
        width: leftWidth,
        //自适应屏幕高度
        height: double.infinity,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Column(children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    _selectIndex = index;
                    //把对应类目ID传入，调用接口
                    this._getRightCateData(this._leftCateList[index].sId);
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(84),
                  padding: EdgeInsets.only(
                    top: ScreenAdapter.height(24),
                  ),
                  child: Text(
                    "${this._leftCateList[index].title}",
                    textAlign: TextAlign.center,
                  ),
                  color: _selectIndex == index
                      ? Color.fromRGBO(240, 246, 246, 0.9)
                      : Colors.white,
                ),
              ),
              Divider(height: 1),
            ]);
          },
          itemCount: this._leftCateList.length,
        ),
      );
    } else {
      //防止错位，返回空容器
      return Container(
        width: leftWidth,
        //自适应屏幕高度
        height: double.infinity,
      );
    }
  }

  Widget _rightCateWidget(rightItemWidth, rightItemHeigh) {
    if (_rightCateList.length > 0) {
      return Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            color: Color.fromRGBO(240, 246, 246, 0.9),
            height: double.infinity,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: rightItemWidth / rightItemHeigh,
              ),
              itemBuilder: (BuildContext context, int index) {
                //处理图片
                String pic = this._rightCateList[index].pic;
                //网址斜杠转换
                pic = Config.domain + pic.replaceAll('\\', '/');
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/productList',arguments: {
                      "cid":this._rightCateList[index].sId,
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                            "${pic}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: ScreenAdapter.height(28),
                          child: Text("${this._rightCateList[index].title}"),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: _rightCateList.length,
            ),
          ));
    } else {
      return Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            color: Color.fromRGBO(240, 246, 246, 0.9),
            height: double.infinity,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    //注意用ScreenAdapter必须得在build方法里面初始化
    //ScreenAdapter.init(context);
    //计算左侧Listvew宽度
    var leftWidth = ScreenAdapter.screenwidth() / 4;
    //计算右侧GridView宽高比
    //屏幕宽度-左侧宽度-Gridview外侧原生左右的Padding值-Gridview中间间距
    var rightItemWidth = (ScreenAdapter.screenwidth() - leftWidth - 20 - 20) / 3;

    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    //右侧每一项高度等于计算后的值+文本的值
    var rightItemHeigh = rightItemWidth + ScreenAdapter.height(28);
    return Row(
      children: <Widget>[
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeigh),
      ],
    );
  }
}
