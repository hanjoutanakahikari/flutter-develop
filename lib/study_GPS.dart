import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

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
  String _latitude = "NoData";
  String _longitude = "NoData";
  String _altitude = "NoData";
  String _distanceInMeters = "NoData";
  String _bearing = "NoData";
  String _country = "NoData";
  String _administrativeArea = "NoData";
  String _locality = "NoData";
  String noPermission = "";
  bool isLoading = false;

  Future<void> getLocation() async{
    //権限を取得
    LocationPermission permission = await Geolocator.requestPermission();

    //権限がない場合は戻る
    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
      setState(() {
      noPermission = "権限ないですよ";
      });
      return;
    }
    setState(() {
      noPermission = "権限ありますよ";
      isLoading = true;
    });
                    
    try{
        //LocationAccuracy.high：めっちゃ正確な情報を出して
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        // 取得した位置情報の経度と緯度を使い、詳細情報を取り出す
        final placeMarks = await geoCoding.placemarkFromCoordinates(position.latitude, position.longitude);

        // 上記のplaceMarksは配列で帰ってくるので一つだけ取り出す
        final placeMark = placeMarks[0];

        setState(() {
          //北緯がプラス、南緯がマイナス
          _latitude = "緯度: ${position.latitude.toStringAsFixed(2)}";
          //東経がプラス、南緯がマイナス
          _longitude = "経度：${position.latitude.toStringAsFixed(2)}";
          //高度
          _altitude = "高度: ${position.altitude.toStringAsFixed(2)}";
          //距離を1000で割ってkmで返す(福井市との距離)
          _distanceInMeters = "距離: ${Geolocator.distanceBetween(position.latitude, position.longitude, 36.065, 136.222)}";
          //方位を返す(福井市との方位)
          _bearing = "方位：${Geolocator.bearingBetween(position.latitude, position.longitude, 36.065, 136.222)}";
          // 国が取得できます
          _country = "${placeMark.country} 国"; 
          // 県が取得できます(日本の場合)
          _administrativeArea = "${placeMark.administrativeArea} 県";
          // 市が取得できます(日本の場合)
          _locality = "${placeMark.locality} 市";
        });
                      
      }finally{
        
        setState(() {
        isLoading = false;
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
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(noPermission),
            Text(
              _latitude,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              _longitude,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              _distanceInMeters,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              _bearing,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              _country,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              _administrativeArea,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              _locality,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (isLoading)
              const ColoredBox(
                color: Colors.black54,
                child: Center(
                  // グルグルするやつ動いた！
                  child: CircularProgressIndicator(
                    strokeWidth: 10.0,
                  ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getLocation,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
