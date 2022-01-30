import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_tracking/cubit/sendingdata_cubit.dart';
import 'package:covid_tracking/data/firebasedata.dart';
import 'package:covid_tracking/screen/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final firebasefirestore = FirebaseFirestore.instance;
final boyRef = firebasefirestore.collection("users");

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
var phoneno;
class _LoginScreenState extends State<LoginScreen> {
  
  // String? name;
  TextEditingController _controller = TextEditingController();
  TextEditingController _controllername = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "CONNECT WITH US",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.black,
              ))),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0,
                      left: 20.0),
                  child: const Text(
                    "ENTER PHONE NUMBER",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    counter: Offstage(),
                    hintText: "7096******",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    hintStyle:
                        const TextStyle(color: Colors.black54, fontSize: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  controller: _controller,
                  onChanged: (value) {
                    if (value.isNotEmpty && value.length == 10) {
                      setState(() {
                        // _validate = true;
                        phoneno = value;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                      onPressed: () async {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => OTP()));
                        logUser();
                      
                      },
                      child: const Text(
                        "SEND OTP",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: Colors.black, width: 2.0))))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void logUser() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => OTPScreen(
                  phone: _controller.text,
                  name: _controllername.text,
                )));
  }
}
