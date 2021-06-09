import 'dart:convert';

import 'package:crypto/crypto.dart';

class SignServices {
  static getSign(json) {
    // Map addressListAttr = {
    //   'uid': '1',
    //   'age': '10',
    //   'salt': 'xxxxxxx' //私钥
    // };
    //var attrKeys = addressListAttr.keys.toList();
    var attrKeys = json.keys.toList();
    attrKeys.sort(); //排序 ASCII字符顺序进行升序排列

    print(attrKeys);

    String str = '';
    for (var i = 0; i < attrKeys.length; i++) {
      //str += '${attrKeys[i]}${addressListAttr[attrKeys[i]]}';
      str += '${attrKeys[i]}${json[attrKeys[i]]}';
    }
    print(str);
    //生成签名
    //print(md5.convert(utf8.encode(str)));
    //转换成字符串
    return md5.convert(utf8.encode(str)).toString();
  }
}
