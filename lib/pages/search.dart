import 'package:flutter/material.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/services/search_services.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keywords;
  List _historyListData = [];
  @override
  void initState() {
    super.initState();
    this._getHistoryData();
  }

  _showAlertDialog(keywords) async {
    var result = showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("提示信息!"),
            content: Text("您确定要删除吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  print("取消");
                  Navigator.pop(context, 'Cancle');
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  //注意异步
                  await SearchServices.removeHistoryData(keywords);
                  //重新渲染
                  this._getHistoryData();
                  Navigator.pop(context, "Ok");
                },
              )
            ],
          );
        });
  }

  //从本地存储获取数据赋值给历史记录列表
  _getHistoryData() async {
    var _historyListData = await SearchServices.getHistoryList();
    setState(() {
      this._historyListData = _historyListData;
    });
  }

  Widget _historyListWidget() {
    if (_historyListData.length > 0) {
      return Column(children: <Widget>[
        Container(
          child: Text(
            '历史记录',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: this._historyListData.map((value) {
            return Column(
              children: <Widget>[
                ListTile(
                  onLongPress: () {
                    _showAlertDialog("${value}");
                  },
                  title: Text("${value}"),
                ),
                Divider(),
              ],
            );
          }).toList(),
        ),
        SizedBox(
          height: ScreenAdapter.height(100),
        ),
        InkWell(
          onTap: () {
            SearchServices.clearHistoryList();
            this._getHistoryData();
          },
          child: Container(
            width: ScreenAdapter.width(400),
            height: ScreenAdapter.height(64),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black26,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete),
                Text("清空历史记录"),
              ],
            ),
          ),
        )
      ]);
    } else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              )),
              onChanged: (value) {
                this._keywords = value;
              },
            )),
        actions: [
          InkWell(
            onTap: () {
              //把搜索关键词保存到本地存储
              SearchServices.setHistoryData(this._keywords);
              //路由替换名
              Navigator.pushReplacementNamed(context, '/productList',
                  arguments: {
                    "keywords": this._keywords,
                  });
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
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              child: Text(
                '热搜',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Divider(),
            Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("女装"),
                ),
              ],
            ),
            SizedBox(
              height: ScreenAdapter.height(10),
            ),
            //历史记录
            _historyListWidget(),
          ],
        ),
      ),
    );
  }
}
