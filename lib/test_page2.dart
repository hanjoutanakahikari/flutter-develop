import 'package:flutter/material.dart';
import 'test_page3.dart';

class TestPage2 extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("test2"),
      ),           
      body: Center(
        child: Container(
              child: const Text("test2", style:TextStyle(fontSize: 80)),
        ),          
      ) 
    );
  }
}