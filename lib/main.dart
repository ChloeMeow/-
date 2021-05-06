
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingdong_app/pages/tabs/tabs.dart';
import 'package:jingdong_app/provider/cartprovider.dart';
import 'package:jingdong_app/provider/counter.dart';
import 'package:jingdong_app/routers/router.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_)=>Counter()),
         ChangeNotifierProvider(create: (_)=>CartProvider()),
      ],
      child: ScreenUtilInit(
        designSize: Size(750, 1334),
        allowFontScaling: false,
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          //home: Tabs(),
          initialRoute: '/',
          onGenerateRoute: onGenerateRoute,
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
