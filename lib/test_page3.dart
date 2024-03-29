import 'package:flutter/material.dart';

class TestPage3 extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("test3"),
      ),           
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () =>{
                Navigator.of(context)
                  .pop()
              },
              child: const Text("戻る", style: TextStyle(fontSize: 80),) 
            )
          ],
        ) 
      )
    );        
      
  }
}