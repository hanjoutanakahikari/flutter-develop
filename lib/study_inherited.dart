import 'package:flutter/material.dart';
import 'my_widget.dart';
import 'my_inherited_widget.dart';

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
    print(_counter);
  }

  @override
  Widget build(BuildContext context) {
    
    return MyInheritedWidget(
      counter: _counter,
      message: "InheritedWidgetとは子から祖先に素早くアクセスできるwidgetである",
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title),),
        //ここのconst 超大事！！！無いとupdateShouldNotify効かなくなる
        body: const Center(child: MyWidget()),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ) 
    );
  }
}
