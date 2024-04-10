import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mydata.dart';
import 'myslider.dart';

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
    setState(() {
      
      _counter++;
    });
    print("$_counter");
  }

  @override
  Widget build(BuildContext context) {
    //MyDataを持つ
    return ChangeNotifierProvider(
      create: (BuildContext context) => MyData(),
      child: Scaffold(
        appBar: AppBar(
          
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          
          title: Text(widget.title),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //MyDataの変更を検知
              Consumer<MyData>(
                builder: (context, mydata, _) => Text(
                  //mydata.value.toStringAsFixed(2),
                  //もはやproviderにすら頼らないでcontextの拡張メソッドで対応
                  //context.selectで値の変更を検知
                  context.select((MyData mydata) => mydata.value.toStringAsFixed(2)),
                  style: const TextStyle(fontSize: 100),
              )
              ),
              const MySlider()
            ]
        )
      )
    );
  }
}
