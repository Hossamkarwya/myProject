Auther : Hossam Karwya
App    : Map_Test
date   : 27-03-2023
=============================================
 I am training to used google maps And git 

=========================================
packages which used:
geocoding: ^2.1.0
google_maps_flutter: ^2.2.5
flutter_polyline_points: ^1.0.0
geolocator: ^9.0.2
awesome_dialog: ^3.0.2
======================================
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:io';   //============= initaiztion currentPosition ============

===========================================
API Key google platform:
AIzaSyAax7UxFFIe5B-wzfqzU_o3dDRz4-mftEk
========================================
geolocator: ^9.0.2  ========== installing =============

1- Add the following to your "gradle.properties" file:
android.useAndroidX=true
android.enableJetifier=true

2- Make sure you set the compileSdkVersion in your "android/app/build.gradle" file to 33:
android {
  compileSdkVersion 33

  ...
}

3 - Permissions  <manifest><android\app\src\main\AndroidManifest.xml>

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

4- for IOS add in Info.plist
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location when in the background.</string>

====================================================================================
geocoding: ^2.1.0  //================= Installing =============
1- Add the following to your "gradle.properties" file:
android.useAndroidX=true
android.enableJetifier=true

2- Make sure you set the compileSdkVersion in your "android/app/build.gradle" file to 33:
android {
  compileSdkVersion 33

  ...
}


================================= test with github ====================