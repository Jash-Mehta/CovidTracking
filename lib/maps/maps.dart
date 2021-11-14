// ignore_for_file: prefer_const_constructors

import 'package:covid_tracking/api/api_manager.dart';
import 'package:covid_tracking/model/indiadata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
  // final Set<Marker> _markers = {};
  bool isMapCreated = false;
// for fetching current location.....
  // void getLocation() async {
  //   var location = await currentLocation.getLocation();
  //   currentLocation.onLocationChanged.listen((LocationData loc) {
  //     _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
  //       zoom: 12.0,
  //     )));
  //     setState(() {
  //       _markers.add(Marker(
  //           markerId: const MarkerId('Home'),
  //           position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),

  //           )
  //           );
  //     });
  //   });
  // }
  Future<India>? _covidIndia;
  @override
  void initState() {
    super.initState();
    _covidIndia = India_Manager().getcovid();
    // setState(() {
    //   // getLocation();
    // });
  }

  changeMapMode() {
    getJsonFile("assets/daymode.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller!.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    if (isMapCreated) {
      changeMapMode();
    }

    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: _covidIndia,
        builder: (BuildContext context, AsyncSnapshot<India> snapshot) {
          if (snapshot.hasData) {
            for (int i = 1; i < snapshot.data!.statewise.length; i++) {
              var article = snapshot.data!.statewise[i];

              return Stack(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: const LatLng(20.5937, 78.9629),
                        zoom: 12.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                        isMapCreated = true;
                        changeMapMode();
                        setState(() {});
                      },
                      // markers: _markers,
                      markers: {
                        Marker(
                            position: LatLng(11.059821, 78.387451),
                            markerId: MarkerId("Home"),
                            infoWindow: InfoWindow(title: article.state))
                      }),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 80.0,
                      width: 200.0,
                      margin: EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.statewise.length,
                        itemBuilder: (BuildContext context, int index) {
                          var map = snapshot.data!.statewise[index];
                          return Container(
                            width: 55.0,
                            margin: EdgeInsets.only(left: 5.0, right: 5.0),
                            decoration: BoxDecoration(color: Colors.white),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Icon(CupertinoIcons.location_solid,
                                    color: Colors.red, size: 33.0),
                                SizedBox(height: 5.0),
                                Text(map.statecode,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ]);
            }
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.location_searching,
          color: Colors.white,
        ),
        onPressed: () {
          // getLocation();
        },
      ),
    );
  }
}
