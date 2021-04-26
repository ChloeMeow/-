import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingdong_app/pages/tabs/tabs.dart';
import 'package:jingdong_app/routers/router.dart';

void main() {
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
    return ScreenUtilInit(
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
    );
  }
}
