import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:isolate';

//負荷を軽くするためにisolete分離させて実行すること
//非同期とは違って完全分離なので、子スレッドに親からアクセスできない代わりに、負荷軽減にめっちゃ効果ある

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void childfunc(SendPort sendPort){
  int i = 0;
  //親スレッドにメッセージを送る
  Timer.periodic(const Duration(seconds: 1), (timer) => { sendPort.send(i++) });

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async{

    var receivePort = ReceivePort();
    var sendPort = receivePort.sendPort;
    late Capability capability;

    //子スレッドからメッセージを受け取る
    receivePort.listen((message){
      print('子から親へ ${message}');
    });

    //Isolate別スレッドを作成
    final childIsolate = await Isolate.spawn(childfunc, sendPort); 
    
    //一時停止
    Timer(const Duration(seconds: 5), (){
      print("一時停止");
      //子スレッドのイベント処理を一時停止
      capability = childIsolate.pause();
    });

    //再開
    Timer(const Duration(seconds: 5), (){
      print("へえreboot再始動/redume再開");
      //子スレッドのイベント処理を続行する
      childIsolate.resume(capability);
    });

    Timer(const Duration(seconds: 15), (){
      print("子スレッドを終了killする");
      receivePort.close();
      childIsolate.kill();
    });
    
    setState(() {
      _counter++;
    });
    print("親スレッド仕事終わり！");
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
