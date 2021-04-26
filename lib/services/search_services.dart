import 'dart:convert';

import 'package:jingdong_app/services/Storage.dart';

class SearchServices {
  static setHistoryData(keywords) async {
    /*
          1、获取本地存储里面的数据  (searchList)

          2、判断本地存储是否有数据

              2.1、如果有数据 

                    1、读取本地存储的数据
                    2、判断本地存储中有没有当前数据，
                        如果有不做操作、
                        如果没有当前数据,本地存储的数据和当前数据拼接后重新写入           


              2.2、如果没有数据

                    直接把当前数据放在数组中写入到本地存储
      
      
      */
    try {
      //把获取数据转换成Map类型对象
      var searchListData = json.decode(await Storage.getString('searchList'));
      print(searchListData);
      //如果数组里面有value值就返回true，
      var hasData = searchListData.any((v) {
        return v == keywords;
      });
      if (!hasData) {
        searchListData.add(keywords);
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } catch (e) {
      //print(e);
      List tempList = [];
      //直接把当前数据放在数组中写入到本地存储
      tempList.add(keywords);
      await Storage.setString('searchList', json.encode(tempList));
    }
  }

  //得到历史记录
  static getHistoryList() async {
    try {
      //把获取数据转换成Map类型对象
      List searchListData = json.decode(await Storage.getString('searchList'));
      return searchListData;
    } catch (e) {
      return [];
    }
  }

  //清空历史记录
  static clearHistoryList() async {
    await Storage.remove('searchList');
  }

  //
  static removeHistoryData(keywords) async {
    //把获取数据转换成Map类型对象
    List searchListData = json.decode(await Storage.getString('searchList'));
    print(searchListData);
    searchListData.remove(keywords);
    print(searchListData);
    //重新写入本地存储
    await Storage.setString('searchList', json.encode(searchListData));
  }
}
