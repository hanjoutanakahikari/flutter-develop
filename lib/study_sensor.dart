import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
  String _userAccelerometerValues = "";
  String _gyroscopeValues = ""; 

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
            Text(
              _userAccelerometerValues,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              _gyroscopeValues,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    userAccelerometerEventStream(samplingPeriod: SensorInterval.normalInterval).listen(
        (UserAccelerometerEvent event) {
          
          setState(() {
            _userAccelerometerValues = "加速度センサー\n${event.x}\n${event.y}\n${event.z}";
            
          });
        }
    );
    gyroscopeEventStream(samplingPeriod: SensorInterval.normalInterval).listen(
        (GyroscopeEvent event) {
          setState(() {
            _gyroscopeValues = "ジャイロセンサー\n${event.x}\n${event.y}\n${event.z}";
          });
        }
    );
    
  }
}
