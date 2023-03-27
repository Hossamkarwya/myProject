// ignore_for_file: prefer_const_constructors, duplicate_ignore, deprecated_member_use

import 'package:flutter/material.dart';

import 'homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map',
      theme: ThemeData(
        // ignore: prefer_const_constructors
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),
          centerTitle: true,
          ),
      primarySwatch: Colors.amber,
      primaryColor: Colors.red,
      buttonColor: Colors.amber[900],
      textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
      ),
      ),
      home: HomePage(),
    );
  }
}

