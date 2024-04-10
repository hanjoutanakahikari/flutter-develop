import 'package:flutter/foundation.dart';
//notifyListenersを使えるようにChangeNotifier
class MyData with ChangeNotifier {

  double _value = 0.5;

  //getter
  double get value => _value;
  //setterで値を変更
  set value(double value){
    _value = value;
    //通知する
    notifyListeners();
  } 

}