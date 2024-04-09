import 'package:flutter/material.dart';
import 'dart:async';

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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  //Stream: 非同期に連続したデータの受け渡しができる（いちいちメソッドを呼ぶ必要がなくなる）
  final _counterStream = StreamController<int>();

  @override
  void initState(){
    super.initState();
    //受け取る側のクラスにstreamを
    Consumer(_counterStream);
  }

  //終了時にstreamを開放する
  @override
  void dispose(){
    super.dispose();
    _counterStream.close();

  }

  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
    //Streamにカウンター値を流す
    _counterStream.sink.add(_counter);
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

class Consumer{
    //パラメータでStreamを受け取る
    Consumer(StreamController<int> consumeStream){
      //Streamをlisten(見張る)してデータがきたら表示
      consumeStream.stream.listen((data) async{
        print("$dataを拾いましたよ");
      });
    }
  }
