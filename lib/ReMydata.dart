//mydataをRiverpod用に変更

import 'package:riverpod/riverpod.dart';
//ChangeNotifierではなくStateNotifierを継承するクラス
class MyData extends StateNotifier<double> {

  //getter/setter/notifyListeners全部不要

  //初期値よな
  MyData(): super(0.5);
  void changeState(state) => this.state = state;

}