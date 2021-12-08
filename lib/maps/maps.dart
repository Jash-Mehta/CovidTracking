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
  bool isMapCreated = false;
  final Set<Marker> _markers = {};
  Future<India>? _covidIndia;
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _covidIndia = India_Manager().getcovid();
    getLocation();
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

  void getLocation() async {
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));
      setState(() {
        _markers.add(Marker(
          markerId: const MarkerId('Home'),
          position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isMapCreated) {
      changeMapMode();
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "India COVID Tracking",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.black,
              ))
              ),
      body: SafeArea(
          child: FutureBuilder(
              future: _covidIndia,
              builder: (BuildContext context, AsyncSnapshot<India> snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Table(
                          border:
                              TableBorder.all(color: Colors.black, width: 1.0),
                          children: [
                            TableRow(children: [
                              Text(
                                "States",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Text(
                                "Active",
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17),
                              ),
                              Text(
                                "Deaths",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red[900],
                                    fontSize: 17),
                              ),
                              Text(
                                "Confirmed",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange[900],
                                    fontSize: 17),
                              ),
                              Text(
                                "Recovered",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green[900],
                                    fontSize: 17),
                              )
                            ])
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          height: 380.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.5),
                          ),
                          child: ListView.builder(
                            itemCount: snapshot.data!.statewise.length,
                            itemBuilder: (BuildContext context, int index) {
                              var states = snapshot.data!.statewise[index];
                              return Table(
                                  border: TableBorder.all(
                                      color: Colors.black, width: 0.8),
                                  children: [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            states.state,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            states.active,
                                            style: TextStyle(
                                                color: Colors.blue[800],
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            states.deaths,
                                            style: TextStyle(
                                                color: Colors.red[800],
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              states.confirmed,
                                              style: TextStyle(
                                                  color: Colors.orange[800],
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            states.recovered,
                                            style: TextStyle(
                                                color: Colors.green[800],
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    )
                                  ]);
                            },
                          )),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3.0, right: 3.0),
                        height: 250.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xDD000000),
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
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
                            markers: _markers,
                          ),
                        ),
                      )
                    ]),
                  );
                }
                return Center(child: CircularProgressIndicator());
              })),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            CupertinoIcons.location_solid,
            color: Colors.black,
          ),
          onPressed: () {
            getLocation();
          }),
    );
  }
}
