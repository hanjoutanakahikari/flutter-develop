import "dart:math" as math;
import "dart:async";

//BLoC：処理を別々の箇所で非同期に同時に行える

//データの生成を担当するクラス
class Generator {
  Generator(StreamController<int> intStream){
    //Streamに流す
    Timer.periodic(
      const Duration(seconds: 10), 
      (timer) {
        int data = math.Random().nextInt(100);
        print("$dataを生成しました");
        //stremに流す
        intStream.sink.add(data);
       });
  }
}

//データの加工を担当するクラス
class Coodinator {
  //引数からintとStringのStreamを受け取る
  Coodinator(StreamController<int> intStream, StreamController<String> stringStream){
    //listenして加工
    intStream.stream.listen((data) async{
      String newData = data.toString();
      print("$dataから$newDataに加工しました");
      //stringStreamに流す
      stringStream.sink.add(newData);
    });
  }
}

//データを利用するクラス
class Consumer{
  //引数でStreamを受け取る
  Consumer(StreamController<String> stringStream){
    //listenして表示
    stringStream.stream.listen((data) async{
      print("$dataを使いました");
    });
  }
}