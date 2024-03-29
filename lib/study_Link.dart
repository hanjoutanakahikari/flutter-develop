import 'package:flutter/material.dart';
//別dartはimportしておく
import 'test_page1.dart';
import 'test_page2.dart';
import 'test_page3.dart';


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
  }

  late PageController _pageController;
  int _selectedIndex = 0;

  final _Pages = [
    TestPage1(),
    TestPage2(),
    TestPage3()
  ];

  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),        
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _Pages,
      )
    );        
      
  }
}