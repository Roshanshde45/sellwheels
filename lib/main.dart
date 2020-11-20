import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellwheels/HomePage.dart';
import 'package:sellwheels/LoginSignUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LoginSignUp(),
    );
  }
}

