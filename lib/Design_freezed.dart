import 'user.dart';
import 'dart:convert';

void main(){
  //ユーザー作成
  User user1 = User('web015', 32);
  User user2 = User('web016', 28);
  User user3 = User('web015', 32); 

  //表示(toStringが不要)
  print(user1);

  //比較
  //値が全て一緒じゃないと同じとはみなされない
  if(user1 == user2) print("同一人物です");
  if(user1 == user3) print("同一人物です");

  //複製して新しいインスタンスを作る
  User user4 = user1.copyWith(name: "権兵衛さん"); //ageはuser1のまま
  print(user4);

  //代入
  user2 = user3;
  print(user2);
  //↑上はできても↓下はエラー
  //user1.name = "お前は誰だ";

  //JSON文字列→Map→JSON文字列
  String jsonString  = '{"name":"金曜日のあの人", "age":13}';
  User fromJsonUser = User.fromJson(json.decode(jsonString));
  print(fromJsonUser);

  //Userクラス→Map→JSON文字列
  User toJsonUser = User('Json', 64);
  Map<String, dynamic> jsonData = toJsonUser.toJson();
  print(jsonData);
}