import 'package:flutter/material.dart';
import 'package:jingdong_app/provider/counter.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    var counterProvider = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("用户中心"),
        actions: [
          IconButton(
            icon: Icon(Icons.launch), 
            onPressed: (){}
          )
        ],
      ),
      body: Text('${counterProvider.count}'),
    );
  }
}
