import 'package:flutter/material.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:jingdong_app/widget/jdbutton.dart';

class PayPage extends StatefulWidget {
  PayPage({Key key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List payList = [
    {
      'title': '支付宝支付',
      'checked': true,
      'image': 'assets/images/zhifubao.jpeg',
    },
    {
      'title': '微信支付',
      'checked': false,
      'image': 'assets/images/weixin.jpeg',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('去支付'),
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: ScreenAdapter.height(400),
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                  itemCount: this.payList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                            leading:
                                Image.asset('${this.payList[index]['image']}'),
                            title: Text('${this.payList[index]['title']}'),
                            trailing: this.payList[index]['checked']
                                ? Icon(Icons.check)
                                : Text(''),
                            onTap: () {
                              //让payList里面的checked都等于false
                              setState(() {
                                for (var i = 0; i < this.payList.length; i++) {
                                  this.payList[i]['checked'] = false;
                                }
                                this.payList[index]['checked'] = true;
                              });
                            }),
                        Divider(),
                      ],
                    );
                  })),
          Divider(),
          SizedBox(height: ScreenAdapter.height(60)),
          JdButton(
            text: '支付',
            color: Colors.red,
            height: ScreenAdapter.height(120),
            cb: () {
              print("支付");
            },
          )
        ],
      ),
    );
  }
}
