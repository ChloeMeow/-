import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = new EventBus();

//商品详情广播数据
class ProductContentEvent{
  String str;
  ProductContentEvent(String str){
    this.str = str;
  }
}

//用户中心广播
class UserEvent{
  String str;
  UserEvent(String str){
    this.str = str;
  }
}

//地址页面广播
class AddressEvent{
  String str;
  AddressEvent(String str){
    this.str = str;
  }
}