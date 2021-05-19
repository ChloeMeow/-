import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  //传入时会把int转换为double
  static height(double value) {
    return ScreenUtil().setHeight(value);
  }

  static width(double value) {
    return ScreenUtil().setWidth(value);
  }
  static sp(double value) {
    return ScreenUtil().setSp(value);
  }
  static screenwidth() {
    return ScreenUtil().screenWidth;
  }
  static screenHeight() {
    return ScreenUtil().screenHeight;
  }


  static void init(BuildContext context) {}
}
