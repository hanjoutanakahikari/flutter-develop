import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  FlutterTts flutterTts = FlutterTts();
  final String _readText = "なんだ〜もう 朝…かと…ひとり‥ごつ…焼けたパンにバタァ ぬり…ぬり…やんだ〜雨はなんか‥しめって…なま…がわぁ…き‥";

  Future<void> _read() async{
    //言語
    await flutterTts.setLanguage("ja-JP");
    //速度
    await flutterTts.setSpeechRate(1.0);
    //音量
    await flutterTts.setVolume(1.0);
    //ピッチ
    await flutterTts.setPitch(1.0);

    //読み上げ
    await flutterTts.speak(_readText);
  }

  //停止用
  Future<void> _stop() async{
    await flutterTts.stop();
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
            Text(_readText, style: Theme.of(context).textTheme.headlineMedium,),
          ],
        ),
      ),
      floatingActionButton: 
      Row(mainAxisAlignment: MainAxisAlignment.end,
      children:[
        FloatingActionButton(
          onPressed: _read,
          tooltip: '読み上げ',
          child: const Icon(Icons.play_arrow),
        ),
        FloatingActionButton(
          onPressed: _stop,
          tooltip: '停止',
          child: const Icon(Icons.stop),
        ) ,  
      ])
      
    );
  }
}
