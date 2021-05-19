import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  const ListTileItem({Key key, this.icon, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,color: color),
      title:Text(title),
    );
  }
}