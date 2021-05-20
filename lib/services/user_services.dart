import 'dart:convert';

import 'package:jingdong_app/services/storage.dart';

class UserServices {
  static getUserInfo() async {
    List userinfo;
    try {
      if (){

      }else{
        List userInfoData = json.decode(await Storage.getString('userInfo'));
        userinfo = userInfoData;
      }
    } catch (e) {
      userinfo = [];
    }
    return userinfo;
  }

  static getUserLoginState() async {
    var userInfo = await UserServices.getUserInfo();
    if (userInfo.length  > 0 && userInfo[0]['username'] != "") {
      return true;
    }
    return false;
  }

  static loginOut() {
    Storage.remove('userInfo');
  }
}
