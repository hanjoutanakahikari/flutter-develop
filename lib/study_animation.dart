import 'dart:math';
import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage>  with TickerProviderStateMixin {
    late AnimationController _animationController;
    late Animation<double> _animationDouble;
    final Tween<double> _tweenDouble = Tween(begin:0.0, end:200.0);
    late Animation<Color?> _animationColor;
    final ColorTween _tweenColor = ColorTween(begin: Colors.deepOrange, end: Colors.white12);
    late Animation _animation;

    //再生
    void _forward() async{
      setState(() {
        _animationController.forward();
      });
    }

    //停止
    _stop() async{
      setState(() {
        _animationController.stop();
      });
    }

    //逆再生
    void _reverse() async{
      setState(() {
        _animationController.reverse();
      });
    }

    @override
    void initState(){
      super.initState();
      //アニメーションの更新や同期を行うためのController
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3)
      );
      //Tween+AnimationContoroller で animationサイズ
      _animationDouble = _tweenDouble.animate(_animationController);
      _animationDouble.addListener(() {
        setState(() {  
        });
      });
      //Tween+AnimationContoroller で animation色
      _animationColor = _tweenColor.animate(_animationController);
      _animationColor.addListener(() {
        setState(() {
          
        });
      });

      _animation = _animationController.drive(
        Tween(begin:0.0, end:2.0* pi)
      );

    }

    @override
    void dispose(){
      _animationController.dispose();
      super.dispose();
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
           Text("AnimationController:${_animationController.value}"),
           Text("AnimationDouble:${_animationDouble.value}"),
           Text("AnimationColor:${_animationColor.value}"),
           //拡大縮小動くやつ
           SizeTransition(
            sizeFactor: _animationController,
            child: Center(
              child: SizedBox(
                width: _animationDouble.value,
                height: _animationDouble.value,
                child: Container(
                  color: _animationColor.value,
                )
              ),
            )
            ),
            AnimatedBuilder(
              animation: _animation, 
              builder: (context,_){
                return Transform.rotate(
                  angle: _animation.value,
                  child: const Icon(Icons.cached, size: 100),
                );
              }
            )
          ],
        ),
      ),
      //再生、停止、逆再生のボタン　
      floatingActionButton: Row( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _forward,
            child: const Icon(Icons.arrow_circle_up_outlined),
          ),
          FloatingActionButton(
            onPressed: _stop,
            child: const Icon(Icons.pause),
          ),
          FloatingActionButton(
            onPressed: _reverse,
            child: const Icon(Icons.arrow_circle_down_outlined)
          )

        ],), 
    );
  }
}
