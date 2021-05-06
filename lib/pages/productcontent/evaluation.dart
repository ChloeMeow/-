import 'package:flutter/material.dart';
class Evaluation extends StatefulWidget {
  final List _productContentList;
  Evaluation(this._productContentList,{Key key}) : super(key: key);

  @override
  _EvaluationState createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> with AutomaticKeepAliveClientMixin{
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("评价"),
    );
  }
}