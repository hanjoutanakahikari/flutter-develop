import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';


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

//列挙型のclass(PageState内には入れられない)
enum Season {
  spring,
  summer,
  autumn,
  winter,
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String data = ""; 
  bool isLoading = false;
  bool flag = false;
  DateTime targetday = DateTime.now();
  String dropValue = "winter";
  String memo = "";


  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      //キーボード分スクロールさせるかどうか
      resizeToAvoidBottomInset: false,
      //要素がはみ出したときにスクロールさせる
      body: SingleChildScrollView(
        //上にスクロール(falseなら下に)
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Text(memo),
            TextFormField(
              enabled: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "memo" 
              ),
              onChanged: (String value){
                setState((){
                  memo = value;
                });
              }
            ),
            DropdownButton<String>(
              hint: Text('あなたの生まれた季節は？'),
              //value: dropValue,
              items: Season.values.map((e){
                return DropdownMenuItem<String>(
                  value: e.name,
                  child: Text(e.name)
                );
              }).toList(), 
              onChanged: (value){
                setState((){
                  dropValue = value!;
                });
              },
            ),

            IconButton(
              icon: Icon(Icons.alarm, color:Colors.redAccent, size:30.0),
              onPressed: () async{
                //datepicker(セレクトボックス状＝ドラムロールっていうらしい)
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(1940, 1,1),
                  maxTime: DateTime(2099, 12, 31),
                  onConfirm: (date){
                    setState(() {
                      targetday = date;
                    });
                    
                  },
                  currentTime: targetday, locale: LocaleType.jp
                );
                
              }
            ),

            //stack:この中のwidget同士を重ねる(プログレスバーの中に文字を重ねたい場合など)
            Stack(children:[
              //プログレスバー
              SizedBox(
                child:LinearProgressIndicator(
                  minHeight: 50,
                  backgroundColor: Color.fromARGB(255, 231, 230, 225),
                  value: (_counter / 20).toDouble(),
                )
              ),
              //中の％表示
              Text(
                //toStringAsFixed:切り上げ
              '${ ((_counter / 20)* 100).toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ]),
            // なんちゃってgoogle検索
            TextField(
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 183, 188, 214),
                filled: true,
                hintText: '検索したい言葉を入力！',
                border: OutlineInputBorder(),
              ),
              // データが変更したら入力されたテキストの値を引数で受け取る
              onChanged: (String value) {
                // 画面を更新する
                setState(() {
                  // データを変更
                  data = value;
                });
              },
            ),
            //fontawesomeflutter
            IconButton(
              icon: Icon(FontAwesomeIcons.language, color:Colors.teal),
              onPressed: () async{
                if(data.isNotEmpty){
                  setState(() {
                      isLoading = true;
                    });
                  try{

                      //string を uri型にする
                    var url = Uri.parse(
                      "https://www.google.com/search?q=${data}"
                    );
                    //一旦ちゃんと開けるかをテスト
                    if(await canLaunchUrl(url)){
                      //url_launcher: aタグみたいなやつ
                      //その上でリンク先へ飛ぶ
                      await launchUrl(url);

                    }

                  }finally{
                    
                    setState(() {
                    isLoading = false;
                    });

                  }
                }
              }
            ),
            if (isLoading)
              const ColoredBox(
                color: Colors.black54,
                child: Center(
                  // グルグルするやつ(動いてんのかな)
                  child: CircularProgressIndicator(
                    strokeWidth: 10.0,
                  ),
                ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: Center(
          //トグルスイッチ
          child: SwitchListTile(
            title: Text("トグルスイッチタイルです"),
            value: flag,
            //スイッチが変更された時
            onChanged: (bool value){
              setState((){
                flag = value;
              });
            },
          )
        )
      ),
      //endDrawer: 右側に表示されるサイドメニュー
      endDrawer: const Drawer(
        child: Center(child: Text("EndDrawer"))
      ), 
    );
  }
}