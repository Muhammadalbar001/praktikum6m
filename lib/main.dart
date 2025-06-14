import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build (BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Muhammad Albar', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.green ,
        ),
        body: Center(
          child: Text('Halo Selamat Datang Di Flutter'),
        ),
      ),
    );
  }
}