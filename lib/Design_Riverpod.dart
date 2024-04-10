import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

//usestateによってStateNotifierProviderやProviderScope不要に
//言わずもがなmydata.dartも不要に
void main() {
  runApp(
    MyApp()
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

    //useStateでスライダー値を管理(setState(再描画)の役割も果たす)
    final slidevalue = useState<double>(0.5);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          slidevalue.value.toStringAsFixed(2),
          style: const TextStyle(fontSize: 50),
        ),
        Slider(
          value: slidevalue.value,
          onChanged:(value)=>slidevalue.value = value
        )
      ]
    );
  } 
  
}
