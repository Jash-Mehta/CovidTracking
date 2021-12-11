// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_tracking/model/senderdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
// import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference reference =
    firebaseFirestore.collection("SendingRequest");

class Sendrequest extends StatefulWidget {
  const Sendrequest({Key? key}) : super(key: key);

  @override
  _SendrequestState createState() => _SendrequestState();
}

var name, address, age, contact;
Location currentLocation = Location();
SenderDetail? senderDetail;
double? latitude;
double? longitude;
String? names;
String? senderaddress;

class _SendrequestState extends State<Sendrequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Booking Request",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  color: Colors.black,
                ))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                if (await Permission.location.request().isGranted) {
                  getdata();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Send Request",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Note:- Before submitting the form make sure you have enter correct detail",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 20.0),
                                    height: 50.0,
                                    width: double.infinity,
                                    child: TextFormField(
                                      initialValue: names,

                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          labelText: "Name",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      keyboardType: TextInputType.name,
                                      // controller: controllerName,
                                      onChanged: (value) {
                                        name = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 20.0),
                                    height: 120.0,
                                    width: double.infinity,
                                    child: TextFormField(
                                      initialValue: senderaddress,
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          labelText: "Address",
                                          labelStyle: const TextStyle(
                                              color: Colors.black45),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 20,
                                      onChanged: (value) {
                                        address = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 20.0),
                                    height: 50.0,
                                    width: double.infinity,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          labelText: "ContactNo.",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        contact = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 20.0),
                                    height: 50.0,
                                    width: double.infinity,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          labelText: "Age",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        age = value;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (latitude! > 22 && latitude! < 23) {
                                          // Sending data to the localDatabase(hive)........
                                          var getDname = name;
                                          var getDaddress = address;
                                          var box = Hive.box('senderdetail');
                                          box.put('name', getDname);
                                          box.put('address', getDaddress);
                                          // Sending Data Users data to firebase
                                          if (names != null && senderaddress!=null) {
                                            reference.add({
                                              'Name': names,
                                              'Address': senderaddress,
                                              'Contact': contact,
                                              'Age': age
                                            }).then((value) =>
                                                Navigator.pop(context));
                                          } else {
                                            reference.add({
                                              'Name': name,
                                              'Address': address,
                                              'Contact': contact,
                                              'Age': age
                                            }).then((value) =>
                                                Navigator.pop(context));
                                          }
                                        } else {
                                          print(
                                            "Service is not avaible in your area.....",
                                          );

                                          Navigator.pop(context);
                                        }
                                      },
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all<double>(
                                                  10.0),
                                          shadowColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black87),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      child: const SizedBox(
                                        height: 40.0,
                                        width: 80.0,
                                        child: Center(
                                            child: Text(
                                          "SUBMIT",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                      )),
                                  const SizedBox(
                                    height: 20.0,
                                  )
                                ],
                              ),
                            ));
                      });
                }
              },
              child: Center(
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green[600]),
                  child: const Center(
                      child: Text(
                    "SEND",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            )
          ],
        ));
  }

// to get user current location......
  void getLocation() async {
    var location = await currentLocation.getLocation();
    latitude = location.latitude as double;
    longitude = location.longitude as double;
  }

// to fetch data from hive......
  void getdata() {
    var boxs = Hive.box('senderdetail');
    names = boxs.get('name');
    senderaddress = boxs.get('address');
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    setState(() {
      getdata();
    });
  }
}
