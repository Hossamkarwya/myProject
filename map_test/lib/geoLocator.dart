// ignore_for_file: prefer_const_constructors, unused_import, deprecated_member_use, unused_element, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:io';//=============== currentLocation initaiztion ===================
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocatorPage extends StatefulWidget {
  const GeoLocatorPage({super.key});

  @override
  State<GeoLocatorPage> createState() => _GeoLocatorPageState();
}

class _GeoLocatorPageState extends State<GeoLocatorPage> {
  //===============================================
  dynamic placeCountry;
  dynamic placeAdministrativeArea;
  dynamic placeLocality;
  dynamic placeStreet;
  dynamic placePostalCode;
  late Position currentLocation;
  bool showText= false;
  bool? serviceEnabled;                 
  LocationPermission? permission;
//=== Determine the current position of your device 
Future determinedPosition() async {
  
 //=========== check services =================
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(serviceEnabled == false){
    // ignore: use_build_context_synchronously
    AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Services',
            desc: 'Services position not Enabled',
          
            ).show();
  }
  //============ check permission =============
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
            getLatLong();

          }
      }
  
  setState(() {});
}


//=======function to get  Current position==============
 Future<Position> getLatLong() async{
 return await Geolocator.getCurrentPosition().then((value) => value);
}
@override
  void initState() {
    determinedPosition();
    super.initState();
  }
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('GeoLocator'),),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showText == false ? Text('') :
                Text('Services Enabled : $serviceEnabled', style: Theme.of(context).textTheme.bodyText1,),
                showText == false ? Text('') :
                Text('$permission',
                style: Theme.of(context).textTheme.bodyText1,
                ),
                MaterialButton(onPressed: () {
                  setState(() {
                   showText = true;
                  });
                  determinedPosition();
                // ignore: sort_child_properties_last
                }, child: Text('ckeck the service enabled',
                style: Theme.of(context).textTheme.button,
                ),
                color: Theme.of(context).buttonColor,
                ),
                MaterialButton(onPressed: () {
                  setState(() {
                    showText = false;
                  });
                  determinedPosition();
                // ignore: sort_child_properties_last
                }, child: Text('Clear',
                style: Theme.of(context).textTheme.button,
                ),
                color: Theme.of(context).buttonColor,
                ),
                MaterialButton(onPressed: () async{
                  currentLocation = await getLatLong();
                  print(currentLocation.latitude);
                  print(currentLocation.longitude);
                  showText = true;
                  
          
                  //============= get information of my location ============
                  List<Placemark> placemarks = await placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);
                  setState(() {
                    placeCountry = placemarks[0].country;
                    placeAdministrativeArea = placemarks[0].administrativeArea;
                    placeLocality = placemarks[0].locality;
                    placeStreet = placemarks[0].street;
                    placePostalCode = placemarks[0].postalCode;
                  });
                  print(placeCountry);
          
                  
                // ignore: sort_child_properties_last
                }, child: Text('Current Position',
                style: Theme.of(context).textTheme.button,
                ),
                color: Theme.of(context).buttonColor,
                ),
                showText == false ? Text(''):
                Text('Latitude : ${currentLocation.latitude}',style: TextStyle(fontSize: 18),),
                showText == false ? Text(''):
                Text('Longitude : ${currentLocation.longitude}',style: TextStyle(fontSize: 18),),
                showText == false ? Text(''):
                Text('Country : $placeCountry',style: TextStyle(fontSize: 18),),
                showText == false ? Text(''):
                Text('AdministrativeArea : $placeAdministrativeArea',style: TextStyle(fontSize: 18),),
                showText == false ? Text(''):
                Text('Locality : $placeLocality',style: TextStyle(fontSize: 18),),
                showText == false ? Text(''):
                Text('Street : $placeStreet',style: TextStyle(fontSize: 18),),
                showText == false ? Text(''):
                Text('PostalCode : $placePostalCode',style: TextStyle(fontSize: 18),),
                Container(
                  height: 400,
                  width: 300,
                  child:  GoogleMap(
                           mapType: MapType.hybrid,
                           initialCameraPosition: _kGooglePlex,
                           onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
         },
      ),
                ),
          
          
              ],
                
            ),
          ),
        ),
      ),
    );
  }
}




//====================================== by geolocator ====================
// Services     and Permissions