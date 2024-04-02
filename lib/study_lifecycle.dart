import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dummy_page.dart';

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
  State<MyHomePage> createState(){ 
    print("createState statefulを構築します");
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose(){
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    print("アプリは今 $state です");
    
    switch(state){
      case AppLifecycleState.inactive:
      print("非アクティブです");
      break;

      case AppLifecycleState.paused:
      print("停止されました");
      break;

      case AppLifecycleState.resumed:
      print("再開されました");
      break;

      case AppLifecycleState.detached:
      print("破棄されました");
      break;

      case AppLifecycleState.hidden:
      print("表示されません");
      break;
    }
  }
  
  
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      print("setState 状態が変わりました");   
      _counter++;
    });
    //nextpage();
  }

  void nextpage() async{
    //画面遷移
    await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return DummyPage();
    }));
  }

  /*
  @override
  void initState(){
    super.initState();
    print("initState　stateを初期化します");
  }
  */

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    print("didChangeDependencies　stateオブジェクトの依存関係が変更されました。");
  }

  @override
  Widget build(BuildContext context) {
    print("build　画面を構築します");
    
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

  @override
  void deactivate(){
    super.deactivate();
    print("deactivate stateがツリーから削除されます");
  }

  /*
  @override
  void dispose(){
    super.dispose();
    print("dispose stateは削除され二度とビルドされません");
  }
  */
}
