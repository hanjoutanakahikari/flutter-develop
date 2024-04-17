import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'ReMydata.dart';

//RiverPodをImmutable化
final _mydataProvider = StateNotifierProvider<MyDataStateNotifier, MyData>((ref) => MyDataStateNotifier());

void main() {
  runApp(
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

    double slidevalue = ref.watch(_mydataProvider).value;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          slidevalue.toStringAsFixed(2),
          style: const TextStyle(fontSize: 50),
        ),
        Slider(
          value: slidevalue,
          onChanged:(value)=>ref.read(_mydataProvider.notifier).changeState(value)
        )
      ]
    );
  } 
  
}
