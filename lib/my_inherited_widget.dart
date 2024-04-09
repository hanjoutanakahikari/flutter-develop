import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {

  int counter;
  final String message;

  //パラメーターでプロパティと子のwidgetを受け取る
  MyInheritedWidget( //ここは初期化
    {Key? key,
    required this.counter,
    required this.message,
    required Widget child
    }):super(key: key, child:child);//スーパークラスにkeyを渡している。続けて書いてあるけどやっていることはちょっと違う

  static MyInheritedWidget of(BuildContext context) =>
    //dependOnInheritedWidgetOfExactType：　一番近くの親のInheritedWidget（つまりMyInheritedWidget）を探す
    // Widgetに変更があった時に下位ツリーを再構築する
    context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>() as MyInheritedWidget;

  @override
  //最終的に再構築するか否かをここで決定
  bool updateShouldNotify(MyInheritedWidget oldWidget) => oldWidget.counter != counter && counter.isEven;

}