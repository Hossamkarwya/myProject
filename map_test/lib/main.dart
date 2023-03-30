// ignore_for_file: prefer_const_constructors, duplicate_ignore, deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:map_test/geoLocator.dart';

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
          titleTextStyle: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Merriweather'),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          ),
          fontFamily: 'Merriweather',
      primarySwatch: Colors.amber,
      primaryColor: Colors.red,
      buttonColor: Colors.amber[900],
      textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
        bodyText1: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),
      ),
      ),
      
      routes: {
        '/'   :(context) => GeoLocatorPage(),
        '/geolocator'   :(context) => GeoLocatorPage(),
      },
    );
  }
}

