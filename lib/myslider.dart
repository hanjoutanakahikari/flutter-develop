import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mydata.dart';

class MySlider extends StatefulWidget {

  const MySlider({Key? key}) :super(key: key);

  @override
  createState() => _MySliderState();

}

class _MySliderState extends State<MySlider>{

  @override
  Widget build(BuildContext context){

    //MyDataにアクセスして値を取得して設定
    //final mydata = Provider.of<MyData>(context);
    
    return Slider(
      //value: mydata.value,
      //変更後の値をmydataに設定＝setterからnotifyListnerで通知
      //onChanged: (value) => mydata.value = value
    
      //もはやproviderにすら頼らないでcontextの拡張メソッドで対応
      //context.selectで値の変更を検知
      value: context.select((MyData mydata) => mydata.value),
      onChanged:(value) => context.read<MyData>().value = value,
    
    );
  }


}

