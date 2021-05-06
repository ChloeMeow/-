import 'package:flutter/material.dart';
import 'package:jingdong_app/provider/cartprovider.dart';
import 'package:jingdong_app/services/screen_adapter.dart';
import 'package:provider/provider.dart';

class CartNum extends StatefulWidget {
  CartNum({Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {

  //左侧按钮
  Widget _leftBtn(){
    return InkWell(
      onTap: (){
        
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('-'),
      ),
    );
  }
  //右侧按钮
  Widget _rightBtn(){
    return InkWell(
      onTap: (){

      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('+'),
      ),
    );
  }
  //中间区域
  Widget _centerArea(){
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 1,
            color: Colors.black12
          ),
          right: BorderSide(
            width: 1,
            color: Colors.black12
          ),
        )
      ),
      width: ScreenAdapter.width(65),
      height: ScreenAdapter.height(45),
      child: Text('1'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(160),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12
        )
      ),
      child: Row(
        children: [
          _leftBtn(),
          _centerArea(),
          _rightBtn(),
        ],
      ),
    );
  }
}
