import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

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
  VideoPlayerController? _controller;
  final imagePicker = ImagePicker();

  //カメラから動画を取得するメソッド
  Future getVideoFromCamera() async{
    XFile? PickedFile = await imagePicker.pickVideo(
      source: ImageSource.camera
    );
    
      if(PickedFile != null){
        _controller = VideoPlayerController.file(File(PickedFile.path));
        _controller!.initialize().then((_) => {
          setState(() {
            _controller!.play();
          })
        });
      }
  } 

  //ギャラリーから動画を取得
  Future getVideoFromGarally() async{
    XFile? PickedFile = await imagePicker.pickVideo(source: ImageSource.gallery);
    if(PickedFile != null){
      _controller = VideoPlayerController.file(File(PickedFile.path));
      _controller!.initialize().then((_){
        setState(() {
          _controller!.play();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Center(
        //取得した写真を表示(ない場合はメッセージ)        
        child: _controller == null
          ? Text('写真を選択してください', style: Theme.of(context).textTheme.headlineLarge)
          : VideoPlayer(_controller!)
        ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: getVideoFromCamera,
            tooltip: 'camera',
            child: const Icon(Icons.video_call),
          ), 
          FloatingActionButton(
            onPressed: getVideoFromGarally,
            tooltip: 'garally',
            child: const Icon(Icons.movie_creation),
          ),
        ],
      )
    );
  }
}