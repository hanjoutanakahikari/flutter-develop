import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatelessWidget {

  const MyWidget({Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context){
    //providerによってInheritedWidgetを継承したクラスを自作しなくて済む
    //↓こういうやつ
    //MyInheritedWidget myInheritedWidget = MyInheritedWidget.of(context);
    int count = Provider.of<int>(context);
    String message = Provider.of<String>(context);
    return Text("$message\nカウント数は $count", style: Theme.of(context).textTheme.headlineMedium);
  }

  

}