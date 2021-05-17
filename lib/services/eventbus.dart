import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = new EventBus();

class ProductContentEvent{
  String str;
  ProductContentEvent(String str){
    this.str = str;
  }
}
