//mydataをRiverpod用に変更

import 'package:riverpod/riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ReMydata.freezed.dart';

@freezed
//スライダーの値を保持するmydataをfreezedで作成
class MyData with _$MyData{
  const factory MyData({@Default(0.5) double value}) = _MyData;
}

//ChangeNotifierではなくStateNotifierを継承するクラス
class MyDataStateNotifier extends StateNotifier<MyData> {

  //getter/setter/notifyListeners全部不要

  //初期値よな
  MyDataStateNotifier(): super(const MyData());
  //値の書き換えは、copywithで別インスタンスにする
  changeState(newValue){
    //下記はImmutableのためエラー
     //state.value = newValue;

     //だからcopywithで別インスタンスにする
     state = state.copyWith(value: newValue);

     //確認(stateのhashcodeが同じだと同じインスタンス)
     print("stateのvalue:${state.value}, stateのhashCode:${state.hashCode}");

  } 

}