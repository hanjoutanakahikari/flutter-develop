import 'package:flutter/material.dart';

class TestPage3 extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("test3"),
      ),           
      body: Center(
        child: Container(
              child: const Text("test3", style:TextStyle(fontSize: 80)),
        ),          
      ) 
    );        
      
  }
}