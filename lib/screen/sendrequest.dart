// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:io';
import 'package:covid_tracking/api/firebaseapi.dart';
import 'package:covid_tracking/cubit/sendingdata_cubit.dart';
import 'package:covid_tracking/model/senderdetail.dart';
import 'package:covid_tracking/widget/appbar.dart';
import 'package:covid_tracking/widget/buttons.dart';
import 'package:covid_tracking/widget/heightcontainer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class Sendrequest extends StatefulWidget {
  const Sendrequest({Key? key}) : super(key: key);

  @override
  _SendrequestState createState() => _SendrequestState();
}

final _formKey = GlobalKey<FormState>();

var name, address, age, contact;
Location currentLocation = Location();
SenderDetail? senderDetail;
double? latitude;
double? longitude;
String? names;
String? senderaddress;
File? file;
UploadTask? task;
var files = FirebaseAuth.instance.currentUser!.uid;

class _SendrequestState extends State<Sendrequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70), child: StartingBar()),
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
                      return BlocProvider<SendingdataCubit>(
                        create: (context) => SendingdataCubit(),
                        child:
                            BlocBuilder<SendingdataCubit, SendingdataInitial>(
                          builder: (context, state) {
                            return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              "Send Request",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
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
                                        HeightContainer(
                                          height: 50.0,
                                          child: TextFormField(
                                              initialValue: names,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  labelText: "Name",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0))),
                                              keyboardType: TextInputType.name,
                                              onChanged: (value) {
                                                name = value;
                                              },
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? "Please enter your name"
                                                      : null),
                                        ),
                                        HeightContainer(
                                          height: 120.0,
                                          child: TextFormField(
                                              initialValue: senderaddress,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                  width: 1.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  labelText: "Address",
                                                  labelStyle: const TextStyle(
                                                      color: Colors.black45),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0))),
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 20,
                                              onChanged: (value) {
                                                address = value;
                                              },
                                              validator: (value) => value!
                                                      .isEmpty
                                                  ? "Please enter your Address"
                                                  : null),
                                        ),
                                        HeightContainer(
                                          height: 50.0,
                                          child: TextFormField(
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  labelText: "ContactNo.",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0))),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                contact = value;
                                              },
                                              validator: (value) => value!
                                                      .isEmpty
                                                  ? "Please enter your PhoneNo."
                                                  : null),
                                        ),
                                        HeightContainer(
                                          height: 50.0,
                                          child: TextFormField(
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  labelText: "Age",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0))),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                age = value;
                                              },
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? "Please enter your Age"
                                                      : null),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 30.0),
                                          child: Text(
                                            "Upload the Documents of COVID",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30.0),
                                          child: Buttons(
                                            height: 30.0,
                                            width: 30.0,
                                            text: "",
                                            icon: Icons.upload,
                                            onpressed: () {
                                              /**
                                               * !Select file from the local devices.......
                                               * */
                                              selectfile();
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Center(
                                          child: Buttons(
                                              icon: Icons.verified,
                                              height: 40.0,
                                              width: 80.0,
                                              onpressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (latitude! > 22 &&
                                                      latitude! < 23) {
                                                    var getDname = name;
                                                    var getDaddress = address;
                                                    if (getDname != null) {
                                                      var box = Hive.box(
                                                          'senderdetail');
                                                      box.put('name', getDname);
                                                    }
                                                    if (getDaddress != null) {
                                                      var box = Hive.box(
                                                          'senderdetail');
                                                      box.put('address',
                                                          getDaddress);
                                                    }
                                                    uploadfiles();
                                                    BlocProvider.of<
                                                                SendingdataCubit>(
                                                            context)
                                                        .submit();
                                                  } else {
                                                    print(
                                                      "Service is not avaible in your area.....",
                                                    );
                                                    Navigator.pop(context);
                                                  }
                                                }
                                              },
                                              text: "SUBMIT"),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      );
                    },
                  );
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

// ignore: slash_for_doc_comments
/**
 * !to get user current location......
 */
  void getLocation() async {
    var location = await currentLocation.getLocation();
    latitude = location.latitude as double;
    longitude = location.longitude as double;
  }
// ignore: slash_for_doc_comments
/**
 * !to fetch data from hive......
 */

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
// ignore: slash_for_doc_comments
/**
 * !Selectfiles from the local devices.... 
 * */

  Future selectfile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

// ignore: slash_for_doc_comments
/**
 * !Upload the pdf to the FireStorage......
  */
  Future uploadfiles() async {
    if (file == null) return;
    final filename = files;
    final destination = 'files/$filename';
    task = FirebaseApi.uploadFile(destination, file!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
  }
}
