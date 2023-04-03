// ignore_for_file: prefer_const_constructors, unused_import, deprecated_member_use, unused_element, unused_local_variable, unnecessary_brace_in_string_interps, sized_box_for_whitespace, unnecessary_null_comparison, avoid_print, prefer_typing_uninitialized_variables, file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:io'; //=============== currentLocation initaiztion ===================
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
  var lat;
  var long;
  bool showText = false;
  bool? serviceEnabled;
  LocationPermission? permission;
  late CameraPosition _kGooglePlex;
  late GoogleMapController gmc;  //=for controller =============
  setMarkerImage()async{
    setState(() {
      
    });
    myMarker.add(Marker(
      //icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'images/logo.png'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      draggable: true,
      markerId: MarkerId('2'),position: LatLng(21.422529 , 39.825970),
    infoWindow: InfoWindow(title: 'El Haram')),);
  }
   late Set<Marker> myMarker = {
    
  };
  //=============== for Live Location ==============
  late StreamSubscription<Position> positionStream;

//=== Determine the current position of your device
  Future determinedPosition() async {
    //=========== check services =================
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled == false) {
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
  Future<void> getLatLong() async {
    currentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);
    lat = currentLocation.latitude;
    long = currentLocation.longitude;
    //====== CameraPosition ===========
      _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 16.4746,
    );
    myMarker.add(Marker(
      draggable: true,
      onDragEnd: (LatLng value) {
        // to do ===================
        print(value);
      },
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      markerId: MarkerId('1'),position: LatLng(lat, long),
    infoWindow: InfoWindow(title: 'My Location')),);
    setState(() {});
  }

  //================================= Live Location ============
  changeMarker(newLat , newLong){
    //======== to move marker =================
    
    myMarker.clear();
    myMarker.add(Marker(markerId: MarkerId('1'),position: LatLng(newLat, newLong)));
    //========== to move map =================
    gmc.animateCamera(CameraUpdate.newLatLng(LatLng(newLat, newLong)));
    setState(() {
                              
    });

  }

  @override
  void initState() {
    //============ Streem ===================
    positionStream = Geolocator.getPositionStream().listen(
    (Position position) {
         changeMarker(position.latitude , position.longitude);
    });
    setMarkerImage();
    getLatLong();
    determinedPosition();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeoLocator'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showText == false
                    ? Text('')
                    : Text(
                        'Services Enabled : $serviceEnabled',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                showText == false
                    ? Text('')
                    : Text(
                        '$permission',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      showText = true;
                    });
                    determinedPosition();
                    // ignore: sort_child_properties_last
                  },
                  child: Text(
                    'ckeck the service enabled',
                    style: Theme.of(context).textTheme.button,
                  ),
                  color: Theme.of(context).buttonColor,
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      showText = false;
                    });
                    determinedPosition();
                    // ignore: sort_child_properties_last
                  },
                  child: Text(
                    'Clear',
                    style: Theme.of(context).textTheme.button,
                  ),
                  color: Theme.of(context).buttonColor,
                ),
                MaterialButton(
                  onPressed: () async {
                    getLatLong();
                    print(currentLocation.latitude);
                    print(currentLocation.longitude);
                    showText = true;

                    //============= get information of my location ============
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        currentLocation.latitude, currentLocation.longitude);
                    setState(() {
                      placeCountry = placemarks[0].country;
                      placeAdministrativeArea =
                          placemarks[0].administrativeArea;
                      placeLocality = placemarks[0].locality;
                      placeStreet = placemarks[0].street;
                      placePostalCode = placemarks[0].postalCode;
                    });
                    print(placeCountry);

                    // ignore: sort_child_properties_last
                  },
                  child: Text(
                    'Current Position',
                    style: Theme.of(context).textTheme.button,
                  ),
                  color: Theme.of(context).buttonColor,
                ),
                showText == false
                    ? Text('')
                    : Text(
                        'Latitude : ${currentLocation.latitude}',
                        style: TextStyle(fontSize: 18),
                      ),
                showText == false
                    ? Text('')
                    : Text(
                        'Longitude : ${currentLocation.longitude}',
                        style: TextStyle(fontSize: 18),
                      ),
                showText == false
                    ? Text('')
                    : Text(
                        'Country : $placeCountry',
                        style: TextStyle(fontSize: 18),
                      ),
                showText == false
                    ? Text('')
                    : Text(
                        'AdministrativeArea : $placeAdministrativeArea',
                        style: TextStyle(fontSize: 18),
                      ),
                showText == false
                    ? Text('')
                    : Text(
                        'Locality : $placeLocality',
                        style: TextStyle(fontSize: 18),
                      ),
                showText == false
                    ? Text('')
                    : Text(
                        'Street : $placeStreet',
                        style: TextStyle(fontSize: 18),
                      ),
                showText == false
                    ? Text('')
                    : Text(
                        'PostalCode : $placePostalCode',
                        style: TextStyle(fontSize: 18),
                      ),
                _kGooglePlex == null
                    ? CircularProgressIndicator()
                    : Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                        height: 600,
                        width: double.infinity,
                        child: GoogleMap(
                          markers: myMarker,
                          onTap: (argument) {  //===== to move marker icon ================
                            
                          },
                          mapType: MapType.normal,
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            gmc = controller;
                          },
                        ),
                      ),
                      Center(
                        child: MaterialButton(
                          color: Theme.of(context).buttonColor,
                          onPressed: () {
                            setMarkerImage();
                            //=== go to new location ===================(El Haram)
                            LatLng latLong =LatLng(21.422529 , 39.825970);
                            gmc.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: latLong,
                                zoom: 16.0,
                                tilt: 45,
                                bearing: 45,
                                )
                            ));
                          },
                          child: Text('Go to El Haram',style: Theme.of(context).textTheme.bodyMedium,),
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
// 21.422529 , 39.825970   El Haram