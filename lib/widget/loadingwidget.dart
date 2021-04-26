import 'package:flutter/material.dart';
import 'package:jingdong_app/services/screen_adapter.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "加载中……",
                style: TextStyle(
                  fontSize: ScreenAdapter.sp(16),
                ),
              ),
              //循环进度指示器(冲程宽度：1，)
              CircularProgressIndicator(
                strokeWidth: 1,
              )
            ],
          )),
    );
  }
}
