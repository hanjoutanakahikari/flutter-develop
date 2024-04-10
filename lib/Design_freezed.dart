import 'user.dart';

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
}