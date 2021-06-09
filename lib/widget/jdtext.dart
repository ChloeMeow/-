import 'package:flutter/material.dart';
import 'package:jingdong_app/services/screen_adapter.dart';

class JdText extends StatelessWidget {
  final String text;
  final bool password;
  final Object onChanged;
  final int maxLength;
  final double height;
  JdText({Key key, this.text = '输入内容', this.password = false,this.onChanged =null,this.maxLength =1,this.height =68})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenAdapter.height(this.height),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1, 
              color: Colors.black12,
            )
          )
        ),
        child: TextField(
          maxLength: this.maxLength,
          obscureText: this.password,
          autofocus: false,
          decoration: InputDecoration(
              labelText: this.text,
              labelStyle: TextStyle(
                fontSize: ScreenAdapter.sp(32),
                color: Colors.black38,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              )),
          onChanged: this.onChanged,
        ));
  }
}
