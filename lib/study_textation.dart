import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

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
  String noPermisttion = "";
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  stt.SpeechToText speech = stt.SpeechToText();


  Future<void> _speak() async{
    bool available = await speech.initialize(
      onError: errorListener,
      onStatus: statusListner
    );
    if(available){
      speech.listen(onResult: resultListener);
    }else{
      noPermisttion = "権限ないですよ";
    }
  }

  //音声入力禁止
  Future<void> _stop() async{
    speech.stop();
  }

  //音声が文字化された結果のリスナー
  void resultListener(SpeechRecognitionResult result){
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  //音声が文字化された時のエラー
  void errorListener(SpeechRecognitionError error){
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  //ステータス
  void statusListner(String status){
    setState(() {
      lastStatus = status;
    });
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
            Text(noPermisttion),
            Text(
              '変換文字: $lastWords',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'ステータス: $lastStatus',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: 
      Row(mainAxisAlignment: MainAxisAlignment.end,
      children:[
        FloatingActionButton(
          onPressed: _speak,
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
