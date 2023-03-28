// ignore_for_file: prefer_const_constructors, unused_import, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Google Maps'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('data',
            style: Theme.of(context).textTheme.bodyText1,
            ),
            MaterialButton(onPressed: () {
              Navigator.of(context).pushNamed('/geolocator');
            }, 
            // ignore: sort_child_properties_last
            child: Text('GeoLocator Page',
            style: Theme.of(context).textTheme.button,
            ),
            color: Theme.of(context).buttonColor,
            ),
          ],
      
        ),
      ),
    );
  }
}