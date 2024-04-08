import 'package:flutter/material.dart';
import 'dart:math';


class StatefulTile extends StatefulWidget {

  StatefulTile({Key? key}) : super(key: key);
  @override
  _StatefulTileState createState() => _StatefulTileState();

}

class _StatefulTileState extends State<StatefulTile>{

 Color _color = Colors.black;
 final _random = Random();

 //色を設定
 @override
 void initState() {
  super.initState();
  _color = Color.fromRGBO(_random.nextInt(256), _random.nextInt(256), _random.nextInt(256), 1);
 }

  @override
  Widget build(BuildContext context) {
    
    print("build");
    return Container(color: _color, height: 100, width:100);
  }
}
