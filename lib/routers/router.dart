import 'package:flutter/material.dart';
import 'package:jingdong_app/pages/address/address_add.dart';
import 'package:jingdong_app/pages/address/address_edit.dart';
import 'package:jingdong_app/pages/address/address_list.dart';
import 'package:jingdong_app/pages/checkout.dart';
import 'package:jingdong_app/pages/login.dart';
import 'package:jingdong_app/pages/order.dart';
import 'package:jingdong_app/pages/order_info.dart';
import 'package:jingdong_app/pages/pay.dart';
import 'package:jingdong_app/pages/product_content.dart';
import 'package:jingdong_app/pages/product_list.dart';
import 'package:jingdong_app/pages/register/register_first.dart';
import 'package:jingdong_app/pages/register/register_second.dart';
import 'package:jingdong_app/pages/register/register_third.dart';
import 'package:jingdong_app/pages/search.dart';
import 'package:jingdong_app/pages/tabs/cart.dart';
import 'package:jingdong_app/pages/tabs/tabs.dart'; 

//配置路由 
final routes={ 
  '/':(context)=>Tabs(), 
  '/search':(context)=> SearchPage(),
  '/cart':(context)=> CartPage(),
  '/login':(context)=> LoginPage(),
  '/registerfirst':(context)=> RegisterFirstPage(),
  '/checkout':(context)=> CheckOutPage(),
  '/registersecond':(context,{arguments})=> RegisterSecondPage(arguments:arguments),
  '/registerthird':(context,{arguments})=> RegisterThirdPage(arguments:arguments),
        //要传入分类ID,通过构造函数给这个类传值
  '/productList':(context,{arguments})=> ProductListPage(arguments:arguments),
  '/productContent':(context,{arguments})=> ProductContentPage(arguments:arguments),
  '/addressAdd':(context)=> AddressAddPage(),
  '/addressEdit':(context,{arguments})=> AddressEditPage(arguments:arguments),
  '/addressList':(context)=> AddressListPage(),
  '/pay':(context)=> PayPage(),
   '/order':(context)=> OrderPage(),
   '/orderinfo':(context)=> OrderInfoPage(),
};
//固定写法 
var onGenerateRoute=(RouteSettings settings) { 
  // 统一处理 
  final String name = settings.name; 
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) { 
    if (settings.arguments != null) { 
      final Route route = MaterialPageRoute( 
        builder: (context) => pageContentBuilder(
          context, 
          arguments: settings.arguments
        )
      );
    return route; 
    }else{
      final Route route = MaterialPageRoute( 
        builder: (context) => pageContentBuilder(context)
      ); return route; 
    } 
  } 
};