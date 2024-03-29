import 'package:flutter/material.dart';
import 'test_page2.dart';

class TestPage1 extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("test1"),
      ),           
      body: Center(
        child: TextButton(
          onPressed: () =>{
            Navigator.of(context).pushNamed("/test2")
            //あるいは
            //Navigator.pushNamed(context, "/test2")
          },
          child: const Text("進む", style:TextStyle(fontSize: 80)),
        )
      )
    );        
      
  }
}


