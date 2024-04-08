import 'package:flutter/material.dart';
import 'stateful_tile.dart';

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
  late List<Widget> tiles;

  @override
  void initState(){
    super.initState();
    //2つのStatefulWidgetを装備
    tiles = [
      //keyで判別するから一意のUniqueKey()にする
      StatefulTile(key: UniqueKey()),
      StatefulTile(key: UniqueKey())
    ];
  }

  //入れ替え処理
  void changeTiles(){
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Row(children: tiles),
      floatingActionButton: FloatingActionButton(
        onPressed: changeTiles,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
