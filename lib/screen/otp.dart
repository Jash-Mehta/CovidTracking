import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_tracking/cubit/sendingdata_cubit.dart';
import 'package:covid_tracking/data/firebasedata.dart';
import 'package:covid_tracking/screen/introscreen.dart';
import 'package:covid_tracking/screen/sendrequest.dart';
import 'package:covid_tracking/widget/maindrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String name;

  const OTPScreen({
    Key? key,
    required this.phone,
    required this.name,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

int check = 0;
bool otpcheck = false;

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: Colors.grey,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog(
      // ignore: prefer_const_constructors
      title: Text("Number Blocked"),
      content:
          Text("Your Phoneno.${widget.phone} is Blocked. Try after 5 min."),
      actions: <Widget>[
        // ignore: prefer_const_constructors
        ElevatedButton(onPressed: () => exit(0), child: const Text("EXIT")),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Verify Phone',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 23.0),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        // Container(
        //     height: 160.0,
        //     width: 160.0,
        //     margin: const EdgeInsets.only(top: 70.0),
        //     child: Image.asset("images/lock.png")),
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          "Authenticate Your Account",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          // margin: EdgeInsets.only(top: 40.0),
          child: Center(
            child: Visibility(
              visible: _verificationCode == null ? false : true,
              child: Text(
                'Code is sent to ${widget.phone}',
                style: const TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 26.0),
              ),
            ),
          ),
        ),

        Container(
          height: 90.0,
          width: 50.0,
          color: Colors.white,
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(20.0),
          child: PinPut(
            textStyle: const TextStyle(color: Colors.white),
            fieldsCount: 6,
            onSubmit: (String pin) async {
              try {
                await FirebaseAuth.instance
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: _verificationCode!, smsCode: pin))
                    .then((value) => {
                          if (value.user != null)
                            {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          IntroductionScreen()),
                                  (route) => false),
                            },
                        });
              } catch (e) {
                check++;
                if (check == 5) {
                  addcurrenttime();
                  checkboolean();
                  showDialog(
                    barrierDismissible: false,
                    barrierLabel: "Click on Exit",
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
                FocusScope.of(context).unfocus();
                _scaffoldkey.currentState!
                    .showSnackBar(SnackBar(content: Text('invalid OTP')));
              }
            },
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            submittedFieldDecoration: _pinPutDecoration.copyWith(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF02B3E8),
                  Color(0xFF1A55B3),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            selectedFieldDecoration: _pinPutDecoration.copyWith(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF02B3E8),
                  Color(0xFF1A55B3),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            followingFieldDecoration: _pinPutDecoration.copyWith(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey.shade300,
              border: Border.all(
                color: const Color.fromRGBO(2, 179, 232, 1),
              ),
            ),
          ),
        ),

        Center(
          child: GestureDetector(
            onTap: () => _verifyPhone(),
            child: const Text(
              "Didn't receive code? Request again.",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ])),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              // print('user logged in');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => IntroductionScreen()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120),
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            _verificationCode = verificationId;
          });
        });
  }

  @override
  void initState() {
    super.initState();
    // call our getcheckboolean method...
    var now = getcheckboolean();
    now.then((v) {
      print(v);
      if (v == true) {
        var time = getcurrenttime();
        time.then((v) {
          print(timestamp);
          print(v);
          /* if   userblocked time is greater than timestamp(currenttime) the user will unblocked...
          */
          if (timestamp >= v + 5) {
            recheckboolean();
            _verifyPhone();
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  // ignore: prefer_const_constructors
                  title: Text("Number Blocked"),
                  content: Text(
                      "Your Phoneno.${widget.phone} is Blocked. Try after 5 min"),
                  actions: <Widget>[
                    // ignore: prefer_const_constructors
                    ElevatedButton(
                        onPressed: () => exit(0), child: const Text("EXIT")),
                  ],
                );
              },
            );
          }
        });
      } else {
        print("code is verify");
        _verifyPhone();
      }
    });
  }
}

int timestamp = DateTime.now().minute;
// we are storing that time when user is blocked....
addcurrenttime() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('currenttime', timestamp);
}

// we are collecting that time when user is blocked
Future<int> getcurrenttime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int getvalue = prefs.getInt('currenttime') as int;
  return getvalue;
}

// so when user is blocked boolean will be ture.....for a 5 min
checkboolean() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('checkbool', true);
}

// we are collecting that boolean....
Future<bool> getcheckboolean() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Reture bool
  bool? getbool = prefs.getBool('checkbool');
  // check the getbool value....
  if (getbool == null) {
    prefs.setBool('checkbool', false);
    bool? gettingbool = prefs.getBool('checkbool');
    return Future.value(gettingbool);
  } else {
    return Future.value(getbool);
  }
}

// After 5 min we update are boolean value to false....so user can move forward...
recheckboolean() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('checkbool', false);
}
