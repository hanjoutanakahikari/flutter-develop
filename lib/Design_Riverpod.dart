import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'ReMydata.dart';

//グローバル変数にproviderを定義(上位にInheritedWidgetやproviderを挟む必要がなくなる)
final _mydataProvider = StateNotifierProvider<MyData, double>((ref) => MyData());

void main() {
  runApp(
    //providerScopeを設定
    const ProviderScope(child: MyApp())
  );
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
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: const MyContents());
  }
}

//HookComsumerWidgetを継承するため切り出し
class MyContents extends HookConsumerWidget {
  const MyContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){

    //ref.watchでプロバイダーにアクセスしスライダー値を管理
    double slidevalue = ref.watch(_mydataProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //consumerは不要
        Text(
          slidevalue.toStringAsFixed(2),
          style: const TextStyle(fontSize: 50),
        ),
        Slider(
          value: slidevalue,
          onChanged:(value) {ref.read(_mydataProvider.notifier).changeState(value);},
        )
      ]
    );
  } 
  
}
