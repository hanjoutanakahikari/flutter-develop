import 'package:flutter/material.dart';

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

  void _incrementCounter() {

    //ofメソッドの役割：親を辿る
    print(Theme.of(context));
    print(Theme.of(context).primaryColor);
    print(Theme.of(context).brightness);
    //scaffoldはMyHomePageよりも子供なので、親やその上を辿るofからは参照できない→エラーになります
    print(Scaffold.of(context));  




    setState(() {
      
      _counter++;
    });
  }

  @override
  //contextは子供scaffoldに向かって辿っていく
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      //Builderによって起点を変える→親がMyHomePageからBuilderになる
      body: Builder(builder: (BuildContext context2){
        return Center(
          child: ElevatedButton(
            child: const Text('バーテンダーさん、toastとは違うやつを見せてよ！'),
            onPressed: () {
              print(context.widget);
              print(context2.widget);
              //contextの親はMyHomepageなのでScaffoldが見つからない→エラーになる
              print(Scaffold.of(context));
              //context2の親はBuilderなのでScaffoldが見つかる
              print(Scaffold.of(context2));
              //ScaffoldMessenger： 通知を管理するwidget。SnackBarを出せる
              print(ScaffoldMessenger.of(context));
              print(ScaffoldMessenger.of(context2));
              //showSnackBar:ユーザーが動作することによって表示されるポップアップ
              ScaffoldMessenger.of(context2).showSnackBar(const SnackBar(content: Text('あいよ'),));
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add
        ),
      ), 
    );
  }
}
